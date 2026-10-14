from pathlib import Path
import sexpdata as sx
import uuid, math, copy, html, json
P=Path(__file__).resolve().parents[1]/'hardware'/'kicad'
def uid():return str(uuid.uuid4())
def tag(a):return str(a[0]) if isinstance(a,list) and a else ''
def children(a,t):return [v for v in a if tag(v)==t]
def child(a,t):return children(a,t)[0]
def q(s):return json.dumps(str(s))
libs={}
for lib,names in {'Device':['R','C'],'Connector_Generic':['Conn_01x02','Conn_01x03','Conn_01x08']}.items():
 tree=sx.loads((P/'source-libraries'/f'{lib}.kicad_sym').read_text())
 for name in names:
  sym=next(v for v in children(tree,'symbol') if v[1]==name)
  libs[f'{lib}:{name}']=copy.deepcopy(sym)
rootid=uid();objects=[];draw=[];pins={};expected={};wires=[];dots=set();bom=[]
def text(x,y,s,size=1.5):
 objects.append(f'(text {q(s)} (at {x} {y} 0) (effects (font (size {size} {size})) (justify left bottom)) (uuid {uid()}))')
 draw.append(f'<text x="{x}" y="{y}" font-size="{size}" fill="#15304a">{html.escape(s)}</text>')
def wire(a,b,net):
 a=tuple(round(v,4) for v in a);b=tuple(round(v,4) for v in b)
 if a==b:return
 assert a[0]==b[0] or a[1]==b[1],(a,b)
 objects.append(f'(wire (pts (xy {a[0]} {a[1]}) (xy {b[0]} {b[1]})) (stroke (width 0) (type default)) (uuid {uid()}))')
 wires.append((a,b,net));draw.append(f'<path d="M{a[0]},{a[1]} L{b[0]},{b[1]}" stroke="#168043" stroke-width="0.3" fill="none"/>')
def route(net,*pts):
 for a,b in zip(pts,pts[1:]):wire(a,b,net)
def dot(x,y):dots.add((x,y))
def label(x,y,s):
 objects.append(f'(label {q(s)} (at {x} {y} 0) (effects (font (size 1.27 1.27)) (justify left bottom)) (uuid {uid()}))')
 draw.append(f'<text x="{x}" y="{y-0.7}" font-size="1.4" fill="#168043">{html.escape(s)}</text>')
def place(ref,lib,val,x,y,angle=0):
 sym=libs[lib];rad=math.radians(angle)
 def tr(lx,ly):return (round(x+lx*math.cos(rad)+ly*math.sin(rad),4),round(y+lx*math.sin(rad)-ly*math.cos(rad),4))
 props=f'(property "Reference" {q(ref)} (at {x+4} {y-2} 0) (effects (font (size 1.27 1.27)) (justify left))) (property "Value" {q(val)} (at {x+4} {y+1} 0) (effects (font (size 1.27 1.27)) (justify left)))'
 pinstr=''
 for unit in children(sym,'symbol'):
  for g in unit[2:]:
   t=tag(g)
   if t=='pin':
    at=child(g,'at');p=tr(at[1],at[2]);num=str(child(g,'number')[1]);pins[ref,num]=p
    pinstr+=f'(pin {q(num)} (uuid {uid()}))'
    leng=child(g,'length')[1];a=math.radians(at[3]);end=tr(at[1]+leng*math.cos(a),at[2]+leng*math.sin(a))
    draw.append(f'<path d="M{p[0]},{p[1]} L{end[0]},{end[1]}" stroke="#83312c" stroke-width="0.25"/>')
    if ref.startswith('J'):draw.append(f'<text x="{p[0]+1}" y="{p[1]-0.5}" font-size="1.1">{num}</text>')
   elif t in ('rectangle','polyline'):
    if t=='rectangle':
     a=child(g,'start')[1:];b=child(g,'end')[1:];ps=[a,[a[0],b[1]],b,[b[0],a[1]],a]
    else:ps=[v[1:] for v in child(g,'pts')[1:]]
    points=' '.join(f'{a},{b}' for a,b in (tr(*v) for v in ps))
    draw.append(f'<polyline points="{points}" fill="none" stroke="#83312c" stroke-width="0.25"/>')
   elif t=='circle':
    cx,cy=tr(*child(g,'center')[1:]);r=child(g,'radius')[1]
    draw.append(f'<circle cx="{cx}" cy="{cy}" r="{r}" fill="none" stroke="#83312c" stroke-width="0.25"/>')
 objects.append(f'(symbol (lib_id {q(lib)}) (at {x} {y} {angle}) (unit 1) (in_bom yes) (on_board yes) (dnp no) (uuid {uid()}) {props} {pinstr} (instances (project "Dragon-Lamp" (path "/{rootid}" (reference {q(ref)}) (unit 1)))))')
 draw.append(f'<text x="{x+4}" y="{y-2}" font-size="1.4">{ref}</text><text x="{x+4}" y="{y+1}" font-size="1.4">{html.escape(val)}</text>')
 bom.append((ref,val,lib))
def p(ref,n):return pins[ref,str(n)]
place('J1','Connector_Generic:Conn_01x08','ESP32 1x8 socket',55,80)
place('J2','Connector_Generic:Conn_01x03','Matrix input',145,70)
place('J3','Connector_Generic:Conn_01x03','TTP223 module',215,70)
place('J4','Connector_Generic:Conn_01x02','USB-C breakout 5V',55,120)
place('R1','Device:R','330R',115,72.54,90)
place('C2','Device:C','100nF',230,120)
place('J5','Connector_Generic:Conn_01x02','Off-board LDR',280.08,65)
place('R3','Device:R','10k',275,120)
place('C3','Device:C','100nF optional',300,120)
place('R4','Device:R','100k / 1%',345,65)
place('R5','Device:R','20k / 1%',345,120)
place('C4','Device:C','100nF',375,120)
# Explicit power rails; connection dots are placed at branch points.
branches={'+5V':[],'+3V3':[],'GND':[]}
def railpin(ref,n,net,xroute=None):
 a=p(ref,n);x=a[0] if xroute is None else xroute;y={'+5V':25,'+3V3':35,'GND':150}[net]
 route(net,a,(x,a[1]),(x,y));branches[net].append(x);expected[ref,str(n)]=net
for ref,n,net,x in [('J1',1,'+5V',20),('J1',3,'+3V3',25),('J1',2,'GND',30),('J4',1,'+5V',10),('J4',2,'GND',15),('J2',1,'+5V',130),('J2',2,'GND',132),('J3',1,'+3V3',200),('J3',2,'GND',202),('C2',1,'+3V3',None),('C2',2,'GND',None),('J5',1,'+3V3',None),('R3',2,'GND',None),('C3',2,'GND',None),('R4',1,'+5V',None),('R5',2,'GND',None),('C4',2,'GND',None)]:railpin(ref,n,net,x)
for net,xs in branches.items():
 y={'+5V':25,'+3V3':35,'GND':150}[net];xs=sorted(set(xs))
 for a,b in zip(xs,xs[1:]):wire((a,y),(b,y),net)
 for x in xs:dot(x,y)
 label(xs[0],y,net)
# Matrix data: real series resistor between GPIO12 and DIN.
route('LED_DIN',p('R1',1),p('J2',3));expected['R1','1']=expected['J2','3']='LED_DIN'
for num,net,target,tx,ry in [(5,'GPIO12_LED',p('R1',2),100,165),(6,'GPIO11_TOUCH',p('J3',3),190,175),(8,'GPIO9_LDR',(260,95),260,185),(7,'GPIO10_VSENSE',(330,95),330,195)]:
 a=p('J1',num);lx=35+(num-4)*2.54
 route(net,a,(lx,a[1]),(lx,ry),(tx,ry),(tx,target[1]),target)
 label(lx+5,ry,net);expected['J1',str(num)]=net
expected['R1','2']='GPIO12_LED';expected['J3','3']='GPIO11_TOUCH'
for net,upper,lower,cap,x,cx,tx in [('GPIO9_LDR','J5','R3','C3',275,300,260),('GPIO10_VSENSE','R4','R5','C4',345,375,330)]:
 route(net,p(upper,2),(x,95),p(lower,1))
 route(net,(tx,95),(x,95),(cx,95),p(cap,1));dot(x,95)
 expected[upper,'2']=expected[lower,'1']=expected[cap,'1']=net
for i,s in enumerate(['1 = 5V / VBUS','2 = GND','3 = 3V3','4 = GPIO13 / unused','5 = GPIO12 / matrix','6 = GPIO11 / touch','7 = GPIO10 / voltage','8 = GPIO9 / LDR']):text(60,85+i*3,s,1.25)
# GPIO13 is intentionally unused; do not attach it to a net.
objects.append(f'(no_connect (at {p("J1",4)[0]} {p("J1",4)[1]}) (uuid {uid()}))')
x,y=p('J1',4);draw.append(f'<path d="M{x-0.6},{y-0.6} l1.2,1.2 m-1.2,0 l1.2,-1.2" stroke="#168043" stroke-width="0.25"/>')
text(15,14,'DRAGON LAMP - MODULE WIRING SCHEMATIC',3)
text(15,20,'Official KiCad 8 symbols. J1 follows supplied physical row order: 5V, GND, 3V3, 13, 12, 11, 10, 9. Other connectors are wired interfaces.',1.6)
text(125,57,'J2: 1=5V, 2=GND, 3=DIN',1.4);text(190,57,'J3: 1=3V3, 2=GND, 3=OUT',1.4)
text(245,49,'LIGHT DIVIDER',2);text(325,49,'SUPPLY DIVIDER',2)
for i,s in enumerate(['J4: 1=VBUS, 2=GND. Existing USB-C breakout includes CC resistors; D+/D- unused.', 'Use PC USB into ESP32 OR external 5V at J4; never both powered without source isolation.', 'External supply: branch matrix power directly from source. All grounds common. 1000uF bulk capacitor is OFF BOARD across USB breakout VBUS/GND.', 'TTP223 and LDR share 3.3V. C2 is PCB bypass; keep a 100nF bypass near the remote TTP223 too. C4 is near GPIO10. C3 is optional filtering.', 'Divider: GPIO10 = VBUS / 6; at 5.00V expect 0.833V. J5: 1=3V3, 2=GPIO9 to remote LDR. No microphone.', 'Direct 3.3V LED data matches prototype; add a suitable 5V logic buffer if required by the actual matrix.']):text(15,214+i*5,s,1.6)
for x,y in dots:
 objects.append(f'(junction (at {x} {y}) (diameter 0) (color 0 0 0 0) (uuid {uid()}))')
 draw.append(f'<circle cx="{x}" cy="{y}" r="0.65" fill="#168043"/>')
libblocks=[]
for name,sym in libs.items():sym[1]=name;libblocks.append(sx.dumps(sym))
out='(kicad_sch (version 20231120) (generator "dragon_export") (uuid '+rootid+') (paper "A3") (lib_symbols '+'\n'.join(libblocks)+')\n'+'\n'.join(objects)+'\n(sheet_instances (path "/" (page "1"))))'
(P/'Dragon-Lamp.kicad_sch').write_text(out,encoding='utf-8');sx.loads(out)
assert set(expected)==set(pins)-{('J1','4')},(set(pins)-set(expected))
# Catch accidental endpoint/junction/pin contacts between different nets.
def on_segment(v,a,b):
 return ((a[0]==b[0]==v[0] and min(a[1],b[1])<=v[1]<=max(a[1],b[1])) or
         (a[1]==b[1]==v[1] and min(a[0],b[0])<=v[0]<=max(a[0],b[0])))
for a,b,net in wires:
 for c,d,other in wires:
  if net==other:continue
  for v in (a,b):assert not on_segment(v,c,d),('Net contact',net,other,v)
for key,v in pins.items():
 for a,b,net in wires:
  if net!=expected.get(key):assert not on_segment(v,a,b),('Pin contact',key,net)
# Check electrical connectivity by endpoints plus wire junctions, not by labels.
for net in set(expected.values()):
 nw=[(a,b) for a,b,n in wires if n==net];vs={v for w in nw for v in w};vs|={pins[k] for k,n in expected.items() if n==net}
 graph={v:set() for v in vs}
 for a,b in nw:
  on=[v for v in vs if (a[0]==b[0]==v[0] and min(a[1],b[1])<=v[1]<=max(a[1],b[1])) or (a[1]==b[1]==v[1] and min(a[0],b[0])<=v[0]<=max(a[0],b[0]))]
  for v in on:graph[v].update(on)
 seen=set();todo=[next(iter(vs))]
 while todo:
  v=todo.pop()
  if v in seen:continue
  seen.add(v);todo.extend(graph[v]-seen)
 assert seen==vs,net
(P/'Preview.svg').write_text('<svg xmlns="http://www.w3.org/2000/svg" width="1680" height="1040" viewBox="0 0 420 260"><rect width="420" height="260" fill="white"/><g font-family="Arial">'+''.join(draw)+'</g></svg>',encoding='utf-8')
(P/'connections.json').write_text(json.dumps({f'{r}.{n}':net for (r,n),net in expected.items()},indent=2))
print(f'PASS: {len(bom)} official-symbol instances, {len(pins)} pins, {len(set(expected.values()))} physically connected nets; parsed KiCad file.')
