"""Reproducible raster-derived prototype; millimetres, no source masks changed."""
from pathlib import Path
import json
import numpy as np
from PIL import Image, ImageDraw
from scipy import ndimage as ndi
from skimage.measure import marching_cubes
import trimesh

ROOT = Path(__file__).resolve().parent
SRC = ROOT.parent
PITCH = 0.1
SIZE = 650
PAD = 14
Z_FACE = 14.0
Z_TRANSITION = 11.8
Z_COLLAR = 1.5
ZONE = ['BG','LE','RE','LW','RW','LH','RH','FA','BO','TA']
COLORS = np.array([[105,122,147],[255,194,66],[255,194,66],[118,93,194],[118,93,194],
                   [229,153,68],[229,153,68],[74,177,189],[73,169,115],[213,111,167]],dtype=np.uint8)

def read(name):
    return np.asarray(Image.open(SRC / name).convert('L').resize((SIZE,SIZE),Image.Resampling.LANCZOS))

def regions(mask, front=False):
    lab,n=ndi.label(~mask)
    counts=np.bincount(lab.ravel())
    result=np.full(lab.shape,-1,dtype=np.int16)
    if front:
        # Seeds refer to the registered source, in mm from its upper-left corner.
        seeds={'BG':[(32,5),(60,60)],'LE':[(5.1,20)],'RE':[(53.3,11.1)],
               'LW':[(13,31)],'RW':[(51,31)],'LH':[(24,13.5)],'RH':[(41,13.5)],
               'FA':[(32,23)],'BO':[(32,46)],'TA':[(20,61)]}
        for zone,pts in seeds.items():
            for x,y in pts:
                region=int(lab[round(y/PITCH),round(x/PITCH)])
                assert region and counts[region]>30,(zone,region)
                result[lab==region]=ZONE.index(zone)
    else:
        for led in json.loads((SRC/'led-coordinates-and-zones.json').read_text())['leds']:
            region=lab[round(led['y_mm']/PITCH),round(led['x_mm']/PITCH)]
            assert region
            existing=np.unique(result[lab==region])
            assert np.all((existing==-1)|(existing==ZONE.index(led['zone'])))
            result[lab==region]=ZONE.index(led['zone'])
    missing=np.unique(lab[(result<0)&(counts[lab]>30)&(lab>0)])
    assert not len(missing), f'Unassigned chambers {missing}'
    _,inds=ndi.distance_transform_edt(result<0,return_indices=True)
    filled=result[tuple(inds)]
    return filled

def sdf(region):
    return (ndi.distance_transform_edt(region)-ndi.distance_transform_edt(~region)).astype(np.float32)*PITCH

def boundaries(labels):
    edge=np.zeros(labels.shape,bool)
    diff=labels[:-1]!=labels[1:]
    edge[:-1]|=diff; edge[1:]|=diff
    diff=labels[:,:-1]!=labels[:,1:]
    edge[:,:-1]|=diff; edge[:,1:]|=diff
    return edge

rear=read('02-led-side-partition-mask.png')<128
front=read('03-lithophane-side-partition-mask.png')<128
for mask in [rear,front]:
    islands,_=ndi.label(~mask)
    counts=np.bincount(islands.ravel())
    mask[(islands>0)&(counts[islands]<30)]=True
back_labels=regions(rear)
front_labels=regions(front,True)
back_fields=np.stack([sdf(back_labels==i) for i in range(len(ZONE))])
front_fields=np.stack([sdf(front_labels==i) for i in range(len(ZONE))])
thickness=2-1.8*read('04-dragon-lithophane-input-white-is-thin.png').astype(np.float32)/255
top=Z_FACE-thickness
perimeter_top=np.pad(top,PAD,mode='edge')
rim=np.zeros(perimeter_top.shape,bool)
rim[2:-2,2:PAD]=True;rim[2:-2,-PAD:-2]=True
rim[2:PAD,2:-2]=True;rim[-PAD:-2,2:-2]=True
# Lower edge is at z=0. Outer wall is above the PCB, outside its 65 mm outline.
zvalues=np.arange(-0.1,14.21,PITCH)
volume=np.zeros((len(zvalues),SIZE+2*PAD,SIZE+2*PAD),bool)
air_by_zone=np.zeros((len(ZONE),len(zvalues),SIZE,SIZE),bool)
snapshots=[]
minimum_areas={z:1e9 for z in ZONE}
for k,z in enumerate(zvalues):
    if z < -1e-6: continue
    t=np.clip((z-Z_COLLAR)/(Z_TRANSITION-Z_COLLAR),0,1)
    labels=np.argmax((1-t)*back_fields+t*front_fields,axis=0)
    width=1.2-0.4*t
    wall=ndi.distance_transform_edt(~boundaries(labels))*PITCH <= width/2-PITCH/2
    # Preserve the actual endpoint masks, including hand-drawn front contacts.
    if z<=Z_COLLAR: wall=rear.copy()
    if z>=Z_TRANSITION: wall=front.copy()
    active=z<=top
    volume[k,PAD:-PAD,PAD:-PAD]=wall&active
    volume[k]|=rim&(z<=perimeter_top)
    for i,zone in enumerate(ZONE):
        air_by_zone[i,k]=(~wall)&(labels==i)&active
        if z<=11.8:
            minimum_areas[zone]=min(minimum_areas[zone],float(air_by_zone[i,k].sum()*PITCH**2))
    if any(abs(z-h)<0.025 for h in [0,3,6,9,11.8]):
        rgb=COLORS[labels].copy();rgb[wall]=[25,30,39]
        snapshots.append((z,Image.fromarray(rgb)))
    if k%30==0: print(f'Built z={z:.1f}',flush=True)

print('Meshing',flush=True)
np.savez_compressed(ROOT/'geometry-grid.npz',solid=volume,z=zvalues,back_labels=back_labels,front_labels=front_labels,top=top)
vertices,faces,_,_=marching_cubes(np.pad(volume,1),0.5,spacing=(PITCH,PITCH,PITCH),allow_degenerate=False)
vertices-=PITCH
# Array z,y,x to CAD x,y,z. Flip y as a coordinate conversion for a front view.
vertices=np.column_stack([vertices[:,2]-PAD*PITCH,65-(vertices[:,1]-PAD*PITCH),vertices[:,0]+zvalues[0]])
mesh=trimesh.Trimesh(vertices,faces,process=True)
mesh.fix_normals()
parts=mesh.split(only_watertight=False)
print('Solid component volumes', [p.volume for p in parts],flush=True)
mesh=max(parts,key=lambda p:p.volume)
# Keep the watertight full-resolution mesh; aggressive decimation damages contacts.
# Quantized voxel cap is half a sample below zero: put its mounting face at zero.
mesh.vertices[:,2]-=mesh.bounds[0,2]
mesh.export(ROOT/'dragon-light-guide-prototype.stl')

leds=json.loads((SRC/'led-coordinates-and-zones.json').read_text())['leds']
clearances=[]
distance=ndi.distance_transform_edt(~rear)*PITCH
for led in leds:
    x,y=led['x_mm'],led['y_mm']; half=led['package_mm']/2
    cut=distance[max(0,int((y-half)/PITCH)):min(SIZE,int(np.ceil((y+half)/PITCH))),
                 max(0,int((x-half)/PITCH)):min(SIZE,int(np.ceil((x+half)/PITCH)))]
    clearances.append(float(cut.min()))
reach={}
for i,zone in enumerate(ZONE):
    comps,n=ndi.label(air_by_zone[i])
    base_ids=np.unique(comps[1]); base_ids=base_ids[base_ids>0]
    target=air_by_zone[i,int(round((11.8-zvalues[0])/PITCH))]
    ids=comps[int(round((11.8-zvalues[0])/PITCH))][target]
    reach[zone]={'reachable_fraction':float(np.isin(ids,base_ids).mean()) if len(ids) else 0,
                 'unreachable_area_mm2':float((~np.isin(ids,base_ids)).sum()*PITCH**2)}
    del comps
report={'status':'prototype; unmeasured PCB components and optical performance require physical checks',
        'pitch_mm':PITCH,'bounds_mm':mesh.bounds.tolist(),'faces':len(mesh.faces),
        'watertight':bool(mesh.is_watertight),'winding_consistent':bool(mesh.is_winding_consistent),
        'connected_solid_components':len(mesh.split(only_watertight=False)),
        'volume_mm3':float(mesh.volume),'minimum_nominal_LED_package_to_rear_wall_mm':min(clearances),
        'front_air_reachability_from_rear_in_voxel_model':reach,'minimum_air_section_mm2':minimum_areas,
        'gap_definition':'PCB contact plane z=0; nominal visible face z=14; rear surface z=14-thickness; 0.1mm mesh sampling',
        'limits':['No measured component reliefs, mounting features, or PCB clearance allowance.',
                  'Zone connectivity is a flood-fill check, not ray tracing or measured light output.',
                  'Interior walls are raster-derived; sharp transitions at endpoint collars need slicer review.']}
(ROOT/'validation.json').write_text(json.dumps(report,indent=2))
sheet=Image.new('RGB',(1500,370),'#eef2f7');d=ImageDraw.Draw(sheet)
for j,(z,im) in enumerate(snapshots):
    sheet.paste(im.resize((286,286)),(j*300+7,45));d.text((j*300+12,18),f'z = {z:.1f} mm',fill='#172333')
d.text((12,345),'Registered front views: LED side at left, dragon side at right. Dark = divider material.',fill='#172333')
sheet.save(ROOT/'sections.png')
print(json.dumps(report,indent=2),flush=True)
