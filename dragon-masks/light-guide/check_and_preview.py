from pathlib import Path
import json
import numpy as np
from scipy import ndimage as ndi
import trimesh
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.art3d import Poly3DCollection

root=Path(__file__).resolve().parent
a=np.load(root/'geometry-grid.npz')
zones=['BG','LE','RE','LW','RW','LH','RH','FA','BO','TA']
z=a['z']; last=int(np.argmin(abs(z-11.8)))
air=~a['solid'][1:last+1,14:-14,14:-14]
labels,n=ndi.label(air)
connections={}
for i,zone in enumerate(zones):
    sources=np.unique(labels[0][a['back_labels']==i]);sources=sources[sources>0]
    targets=[]
    for j,target in enumerate(zones):
        region=(a['front_labels']==j)&(labels[-1]>0)
        area=float(np.isin(labels[-1][region],sources).sum()*0.01)
        if area>0.1: targets.append({'zone':target,'reachable_area_mm2':round(area,2)})
    connections[zone]=targets
result={'air_components_to_z11p8':int(n),'rear_to_front_connections':connections,
        'no_cross_zone_air_connections':all(all(t['zone']==s for t in ts) for s,ts in connections.items())}
(root/'chamber-check.json').write_text(json.dumps(result,indent=2))
print(json.dumps(result,indent=2),flush=True)

mesh=trimesh.load_mesh(root/'dragon-light-guide-prototype.stl')
preview=mesh.simplify_quadric_decimation(face_count=85000)
fig=plt.figure(figsize=(13,7),facecolor='#eef2f7')
for k,(elev,azim,title) in enumerate([(55,-65,'Dragon side'),(-55,-65,'LED side')]):
    ax=fig.add_subplot(1,2,k+1,projection='3d',computed_zorder=False)
    triangles=preview.triangles
    normals=preview.face_normals
    light=np.array([-.3,-.5,1]);light/=np.linalg.norm(light)
    shade=.48+.5*np.maximum(0,normals@light)
    colors=shade[:,None]*np.array([.32,.55,.65])[None,:]
    poly=Poly3DCollection(triangles,facecolors=colors,linewidths=0,rasterized=True)
    ax.add_collection3d(poly)
    ax.set(xlim=(-2,67),ylim=(-2,67),zlim=(0,15))
    ax.set_box_aspect((69,69,15));ax.view_init(elev=elev,azim=azim)
    ax.set_axis_off();ax.set_title(title,color='#172333',fontsize=16)
fig.suptitle('Dragon light guide • prototype',fontsize=21,color='#172333')
fig.text(.5,.06,'65 mm face • nominal 12 mm minimum cavity depth • contoured lithophane contact',ha='center',color='#172333')
plt.savefig(root/'preview.png',dpi=140,bbox_inches='tight',facecolor=fig.get_facecolor())
