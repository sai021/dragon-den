"""Convert the checked Dragon KiCad schematic to embedded-symbol EAGLE XML."""
from pathlib import Path
import sexpdata as sx
import xml.etree.ElementTree as E
import math,json,shutil,copy,zipfile
BASE=Path(__file__).resolve().parents[1]/'hardware'
OUT=BASE/'eagle';OUT.mkdir(exist_ok=True)
tree=sx.loads((BASE/'kicad'/'Dragon-Lamp.kicad_sch').read_text())
expected=json.loads((BASE/'kicad'/'connections.json').read_text())
def tag(v):return str(v[0]) if isinstance(v,list) and v else ''
def many(v,t):return [a for a in v if tag(a)==t]
def one(v,t):return many(v,t)[0]
def sub(p,t,**attrs):return E.SubElement(p,t,{k:str(v) for k,v in attrs.items()})
def num(v):return round(float(v),4)
def point(v):return tuple(num(a) for a in v)
def eaglept(p):return (p[0],num(260-p[1]))
def libname(name):return name.replace(':','_')
root=E.Element('eagle',version='9.6.2');drawing=sub(root,'drawing');settings=sub(drawing,'settings')
sub(settings,'setting',alwaysvectorfont='no');sub(settings,'setting',verticaltext='up')
sub(drawing,'grid',distance=.05,unitdist='inch',unit='inch',style='lines',multiple=1,display='no',altdistance=.025,altunitdist='inch',altunit='inch')
layers=sub(drawing,'layers')
for n,name,color in [(1,'Top',4),(16,'Bottom',1),(17,'Pads',2),(20,'Dimension',15),(21,'tPlace',7),(25,'tNames',7),(27,'tValues',7),(29,'tStop',7),(30,'bStop',7),(51,'tDocu',7),(91,'Nets',2),(92,'Busses',1),(93,'Pins',2),(94,'Symbols',4),(95,'Names',7),(96,'Values',7),(97,'Info',7),(98,'Guide',6)]:sub(layers,'layer',number=n,name=name,color=color,fill=1,visible='yes',active='yes')
sch=sub(drawing,'schematic',xreflabel='%F%N/%S.%C%R',xrefpart='/%S.%C%R')
libraries=sub(sch,'libraries');lib=sub(libraries,'library',name='Dragon_KiCad_Official')
sub(lib,'description').text='Converted official KiCad 8.0.0 symbols; see included license. Module connectors are logical wiring terminals.'
packages=sub(lib,'packages');symbols=sub(lib,'symbols');devicesets=sub(lib,'devicesets')
# Dimensioned provisional through-hole packages. Connectors are wire harnesses,
# not unverified mechanical footprints of the ESP32 or sensor modules.
package_for={
 'Device:R':'R_VERTICAL_P2.54', 'Device:C':'C_DISC_P5.00',
 **{f'Connector_Generic:Conn_01x0{n}':f'HEADER_1X{n}_P2.54' for n in (2,3,8)}}
def outline(p,x1,y1,x2,y2):
 for a,b in [((x1,y1),(x2,y1)),((x2,y1),(x2,y2)),((x2,y2),(x1,y2)),((x1,y2),(x1,y1))]:
  sub(p,'wire',x1=a[0],y1=a[1],x2=b[0],y2=b[1],width=.15,layer=21)
for name in package_for.values():
 p=sub(packages,'package',name=name)
 sub(p,'description').text='Provisional through-hole footprint: verify actual component dimensions. Header pin order is the schematic harness order.'
 if name.startswith('HEADER'):
  count=int(name.split('_')[1][2:]);coords=[(i*2.54,0) for i in range(count)];drill=1;diameter=1.8
  outline(p,-1.27,-1.27,(count-1)*2.54+1.27,1.27)
 else:
  pitch=2.54 if name.startswith('R_') else 2.54 if name.startswith('LDR') else 5
  coords=[(-pitch/2,0),(pitch/2,0)];drill=.9;diameter=1.8
  if name.startswith('R_'):sub(p,'circle',x=-pitch/2,y=0,radius=1.25,width=.15,layer=21)
  elif name.startswith('C_DISC'):outline(p,-2.5,-1.25,2.5,1.25)
  else:
   sub(p,'circle',x=0,y=0,radius=5 if name.startswith('CP_') else 2.5,width=.15,layer=21)
   if name.startswith('CP_'):sub(p,'text',x=-4,y=2,size=1,layer=21).text='+'
 for i,(x,y) in enumerate(coords,1):sub(p,'pad',name=i,x=x,y=y,drill=drill,diameter=diameter,shape='square' if i==1 else 'round')
 sub(p,'text',x=-2,y=6,size=1.27,layer=25).text='>NAME'
 sub(p,'text',x=-2,y=-7,size=1.27,layer=27).text='>VALUE'
defs={s[1]:s for s in many(one(tree,'lib_symbols'),'symbol')};localpins={}
for name,definition in defs.items():
 symbol=sub(symbols,'symbol',name=libname(name));localpins[name]={}
 for unit in many(definition,'symbol'):
  for g in unit[2:]:
   t=tag(g)
   if t in ('polyline','rectangle'):
    if t=='polyline':ps=[point(p[1:]) for p in one(g,'pts')[1:]]
    else:
     a=point(one(g,'start')[1:]);b=point(one(g,'end')[1:]);ps=[a,(a[0],b[1]),b,(b[0],a[1]),a]
    width=max(.127,float(one(one(g,'stroke'),'width')[1]))
    for a,b in zip(ps,ps[1:]):sub(symbol,'wire',x1=a[0],y1=a[1],x2=b[0],y2=b[1],width=width,layer=94)
   elif t=='circle':
    x,y=one(g,'center')[1:];sub(symbol,'circle',x=x,y=y,radius=one(g,'radius')[1],width=.127,layer=94)
   elif t=='pin':
    a=one(g,'at');x,y,angle=a[1:];length=float(one(g,'length')[1]);pin=str(one(g,'number')[1])
    localpins[name][pin]=(x,y)
    # EAGLE has discrete pin lengths. Point pins + exact graphical leads
    # preserve KiCad's electrical endpoints and geometry without snapping.
    sub(symbol,'pin',name=pin,x=x,y=y,visible='off',length='point',direction='pas',rot=f'R{int(angle)%360}')
    rad=math.radians(angle);sub(symbol,'wire',x1=x,y1=y,x2=num(x+length*math.cos(rad)),y2=num(y+length*math.sin(rad)),width=.127,layer=94)
    if name.startswith('Connector'):
     sub(symbol,'text',x=x+1,y=y+.5,size=1.016,layer=95).text=pin
   else:raise ValueError(f'Unhandled graphic {t} in {name}')
 # Name and value are smashed to the original KiCad sheet coordinates below.
 sub(symbol,'text',x=4,y=2,size=1.27,layer=95).text='>NAME'
 sub(symbol,'text',x=4,y=-1,size=1.27,layer=96).text='>VALUE'
 ds=sub(devicesets,'deviceset',name=libname(name),prefix='J' if name.startswith('Connector') else name.split(':')[1][0],uservalue='yes');gates=sub(ds,'gates')
 sub(gates,'gate',name='G$1',symbol=libname(name),x=0,y=0)
 device=sub(sub(ds,'devices'),'device',name='-THT',package=package_for[name])
 connects=sub(device,'connects')
 for pin in sorted(localpins[name]):sub(connects,'connect',gate='G$1',pin=pin,pad=pin)
 sub(sub(device,'technologies'),'technology',name='')
sub(sch,'attributes');sub(sch,'variantdefs');classes=sub(sch,'classes');cl=sub(classes,'class',number=0,name='default',width=0,drill=0);sub(cl,'clearance',**{'class':0,'value':.254})
parts=sub(sch,'parts');sheet=sub(sub(sch,'sheets'),'sheet');plain=sub(sheet,'plain');sub(sheet,'moduleinsts');instances=sub(sheet,'instances');sub(sheet,'busses');nets=sub(sheet,'nets')
for nc in many(tree,'no_connect'):
 x,y=eaglept(one(nc,'at')[1:3])
 for dy in (-.6,.6):sub(plain,'wire',x1=x-.6,y1=y+dy,x2=x+.6,y2=y-dy,width=.15,layer=97)
for t in many(tree,'text'):
 a=one(t,'at');x,y=eaglept(a[1:3]);size=one(one(one(t,'effects'),'font'),'size')[1]
 sub(plain,'text',x=x,y=y,size=size,layer=97).text=t[1]
pins={}
for s in many(tree,'symbol'):
 props={p[1]:p for p in many(s,'property')};ref=props['Reference'][2];name=one(s,'lib_id')[1];a=one(s,'at');x,y,angle=a[1:]
 sub(parts,'part',name=ref,library='Dragon_KiCad_Official',deviceset=libname(name),device='-THT',value=props['Value'][2])
 ex,ey=eaglept((x,y));inst=sub(instances,'instance',part=ref,gate='G$1',x=ex,y=ey,smashed='yes',rot=f'R{int(-angle)%360}')
 for k,target,layer in [('Reference','NAME',95),('Value','VALUE',96)]:
  at=one(props[k],'at');px,py=eaglept(at[1:3]);sub(inst,'attribute',name=target,x=px,y=py,size=1.27,layer=layer)
 rad=math.radians(angle)
 for pin,(lx,ly) in localpins[name].items():pins[f'{ref}.{pin}']=(num(x+lx*math.cos(rad)+ly*math.sin(rad)),num(y+lx*math.sin(rad)-ly*math.cos(rad)))
unused={'J1.4'}
assert set(pins)==set(expected)|unused
wirelist=[tuple(point(p[1:]) for p in one(w,'pts')[1:]) for w in many(tree,'wire')]
vertices={v for w in wirelist for v in w}|{v for k,v in pins.items() if k not in unused}
def on(v,a,b):return (a[0]==b[0]==v[0] and min(a[1],b[1])<=v[1]<=max(a[1],b[1])) or (a[1]==b[1]==v[1] and min(a[0],b[0])<=v[0]<=max(a[0],b[0]))
graph={v:set() for v in vertices};edges=[]
for a,b in wirelist:
 vs=sorted(v for v in vertices if on(v,a,b))
 for c,d in zip(vs,vs[1:]):graph[c].add(d);graph[d].add(c);edges.append((c,d))
assigned={};seen=set()
for start in vertices:
 if start in seen:continue
 component=set();todo=[start]
 while todo:
  v=todo.pop()
  if v in component:continue
  component.add(v);todo.extend(graph[v]-component)
 terminals=[key for key,p in pins.items() if p in component and key not in unused]
 names={expected[key] for key in terminals};assert len(names)==1,('Disconnected or shorted graph',terminals)
 net=names.pop();seen|=component
 for v in component:assigned[v]=net
netnodes={name:sub(nets,'net',name=name,**{'class':0}) for name in sorted(set(expected.values()))}
segments={name:sub(node,'segment') for name,node in netnodes.items()}
for key,p in pins.items():
 if key in unused:continue
 ref,pin=key.split('.');sub(segments[assigned[p]],'pinref',part=ref,gate='G$1',pin=pin)
for a,b in edges:
 net=assigned[a];assert assigned[b]==net;a=eaglept(a);b=eaglept(b)
 sub(segments[net],'wire',x1=a[0],y1=a[1],x2=b[0],y2=b[1],width=.1524,layer=91)
for v,adj in graph.items():
 if len(adj)>=3:
  x,y=eaglept(v);sub(segments[assigned[v]],'junction',x=x,y=y)
for t in many(tree,'label'):
 a=one(t,'at');v=point(a[1:3]);net=t[1];x,y=eaglept(v)
 assert any(on(v,a,b) and assigned[a]==net for a,b in edges)
 sub(segments[net],'label',x=x,y=y,size=1.27,layer=95)
sub(sch,'errors');E.indent(root)
file=OUT/'Dragon-Lamp.sch'
file.write_text('<?xml version="1.0" encoding="utf-8"?>\n<!DOCTYPE eagle SYSTEM "eagle.dtd">\n'+E.tostring(root,encoding='unicode'),encoding='utf-8')
read=E.parse(file);actual={}
for net in read.findall('.//sheet/nets/net'):
 for p in net.findall('./segment/pinref'):actual[p.get('part')+'.'+p.get('pin')]=net.get('name')
assert actual==expected
for part in read.findall('.//schematic/parts/part'):
 ds=next(d for d in devicesets if d.get('name')==part.get('deviceset'))
 device=ds.find('./devices/device');package=next(p for p in packages if p.get('name')==device.get('package'))
 mapping={c.get('pin'):c.get('pad') for c in device.findall('./connects/connect')}
 assert set(mapping)=={key.split('.')[1] for key in pins if key.startswith(part.get('name')+'.')}
 assert set(mapping.values())=={p.get('name') for p in package.findall('pad')}
 assert len(mapping)==len(set(mapping.values()))
# Verify exported pin coordinates, including EAGLE's inverse rotation convention.
for inst in read.findall('.//sheet/instances/instance'):
 ref=inst.get('part');part=next(p for p in parts if p.get('name')==ref);symbol=next(s for s in symbols if s.get('name')==part.get('deviceset'))
 rad=math.radians(float(inst.get('rot')[1:]))
 for pin in symbol.findall('pin'):
  lx,ly=float(pin.get('x')),float(pin.get('y'));x=float(inst.get('x'))+lx*math.cos(rad)-ly*math.sin(rad);y=float(inst.get('y'))+lx*math.sin(rad)+ly*math.cos(rad)
  assert point((x,y))==eaglept(pins[ref+'.'+pin.get('name')])
shutil.copy2(BASE/'kicad'/'LICENSE.txt',OUT/'LICENSE.txt')
shutil.copy2(BASE/'kicad'/'Preview.svg',OUT/'Preview.svg')
shutil.copy2(BASE/'kicad'/'connections.json',OUT/'connections.json')
print(f'PASS: EAGLE XML; {len(parts)} parts, {len(pins)} transformed pin endpoints, {len(edges)} explicit wires, {len(netnodes)} nets identical to KiCad.')
print(f'PASS: all {len(parts)} parts have packages; all {len(pins)} pins map one-to-one to through-hole pads.')

# Supply real board elements/packages alongside the schematic for project import.
# Placement is deliberately spaced for import verification, NOT a finished layout.
br=E.Element('eagle',version='9.6.2');bd=sub(br,'drawing')
bd.append(copy.deepcopy(settings));bd.append(copy.deepcopy(drawing.find('grid')));bd.append(copy.deepcopy(layers))
b=sub(bd,'board');sub(b,'plain');bl=sub(b,'libraries');pl=sub(bl,'library',name=lib.get('name'));pl.append(copy.deepcopy(packages))
sub(b,'attributes');sub(b,'variantdefs');b.append(copy.deepcopy(classes));sub(b,'designrules',name='default')
els=sub(b,'elements');signals=sub(b,'signals')
for i,part in enumerate(parts):
 ds=next(d for d in devicesets if d.get('name')==part.get('deviceset'))
 dev=ds.find('./devices/device')
 sub(els,'element',name=part.get('name'),library=lib.get('name'),package=dev.get('package'),value=part.get('value'),x=(i%3)*30,y=(i//3)*20,rot='R0')
for name in sorted(set(expected.values())):
 sig=sub(signals,'signal',name=name)
 for key,net in expected.items():
  if net==name:
   ref,pin=key.split('.');sub(sig,'contactref',element=ref,pad=pin)
sub(b,'errors')
def xmlwrite(path,node):
 E.indent(node);path.write_text('<?xml version="1.0" encoding="utf-8"?>\n<!DOCTYPE eagle SYSTEM "eagle.dtd">\n'+E.tostring(node,encoding='unicode'),encoding='utf-8')
xmlwrite(OUT/'Dragon-Lamp.brd',br)
lr=E.Element('eagle',version='9.6.2');ld=sub(lr,'drawing');ld.append(copy.deepcopy(settings));ld.append(copy.deepcopy(drawing.find('grid')));ld.append(copy.deepcopy(layers));lc=copy.deepcopy(lib);lc.attrib.pop('name',None);ld.append(lc)
xmlwrite(OUT/'Dragon-Parts.lbr',lr)
boardread=E.parse(OUT/'Dragon-Lamp.brd')
assert {c.get('element')+'.'+c.get('pad'):sig.get('name') for sig in boardread.findall('.//signals/signal') for c in sig.findall('contactref')}==expected
assert len(boardread.findall('.//elements/element'))==12
with zipfile.ZipFile(BASE/'Dragon-Lamp-EasyEDA-Import.zip','w',zipfile.ZIP_DEFLATED) as z:
 for name in ('Dragon-Lamp.sch','Dragon-Lamp.brd'):z.write(OUT/name,name)
print('PASS: companion board has 12 packaged elements and identical 31 connected pads; library exported.')
