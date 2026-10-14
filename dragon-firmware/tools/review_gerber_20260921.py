from pathlib import Path
import re,json,math
import matplotlib;matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Polygon as Patch
from shapely.geometry import Point,LineString,box
from shapely.ops import unary_union,nearest_points
P=Path('hardware/review-2026-09-21')
report=[]
def log(s):report.append(s);print(s)
def parse(file):
 aps={};pos=None;ap=None;items=[]
 for l in (P/file).read_text().splitlines():
  if l.startswith('%ADD'):
   m=re.match(r'%ADD(\d+)(C|R|RoundRect),([-\d.X]+)\*%',l)
   if not m:raise ValueError(l)
   aps[int(m[1])]=(m[2],[float(x) for x in m[3].split('X')]);continue
  m=re.match(r'G54D(\d+)\*',l)
  if m:ap=int(m[1]);continue
  m=re.fullmatch(r'G01X(-?\d+)Y(-?\d+)D(0[123])\*',l)
  if m:
   xy=(int(m[1])/1e5,int(m[2])/1e5);mode=m[3];typ,dims=aps[ap]
   if mode=='03':
    geo=Point(xy).buffer(dims[0]/2,quad_segs=64) if typ=='C' else box(xy[0]-dims[0]/2,xy[1]-dims[1]/2,xy[0]+dims[0]/2,xy[1]+dims[1]/2) if typ=='R' else box(xy[0]-.9,xy[1]-.9,xy[0]+.9,xy[1]+.9).buffer(dims[0]/2,quad_segs=64)
    items.append({'g':geo,'kind':'pad','xy':xy,'w':dims[0]})
   elif mode=='01':
    assert typ=='C';items.append({'g':LineString([pos,xy]).buffer(dims[0]/2,quad_segs=64),'kind':'track','xy':xy,'start':pos,'w':dims[0]})
   pos=xy
  elif l.startswith(('G01','G02','G03','G36','G37','%LP','%SR')):raise ValueError(l)
 return items
layers=[parse('Gerber_TopLayer.GTL'),parse('Gerber_BottomLayer.GBL')]
rows=json.loads((P/'FlyingProbeTesting.json').read_text())['pins']['rows']
renames={'100nf3':'C3','100nf4':'C4','r1_330':'R1','r3_10k':'R3','r4_100k':'R4','r5_20k':'R5'}
for r in rows:
 ref,sep,pin=r[1].rpartition('_')
 if ref in renames:r[1]=renames[ref]+sep+pin
pins={r[1]:{'xy':(r[2]*.0254,r[3]*.0254),'net':r[6]} for r in rows if not r[1].startswith('PAD')}
# Reconstruct copper islands per layer, joining only through actual plated drills.
islands=[list(unary_union([a['g'] for a in ll]).geoms) for ll in layers]
nodes=[(li,i) for li,ii in enumerate(islands) for i in range(len(ii))];parent={n:n for n in nodes}
def root(n):
 while parent[n]!=n:n=parent[n]
 return n
def join(a,b):parent[root(a)]=root(b)
diam={};drills=[];t=None
for l in (P/'Drill_PTH_Through.DRL').read_text().splitlines():
 m=re.fullmatch(r'T(\d+)C([\d.]+)',l)
 if m:diam[int(m[1])]=float(m[2]);continue
 m=re.fullmatch(r'T(\d+)',l)
 if m:t=int(m[1]);continue
 m=re.fullmatch(r'X(-?[\d.]+)Y(-?[\d.]+)',l)
 if m:
  xy=(float(m[1]),float(m[2]));drills.append((xy,diam[t]));hits=[]
  for li,ii in enumerate(islands):
   for i,g in enumerate(ii):
    if g.covers(Point(xy)):hits.append((li,i))
  assert len(hits)==2,(xy,hits)
  join(*hits)
cn={};np={}
for name,p in pins.items():
 hits=[root((li,i)) for li,ii in enumerate(islands) for i,g in enumerate(ii) if g.buffer(.0003).covers(Point(p['xy']))]
 assert hits and len(set(hits))==1,(name,hits)
 r=hits[0];cn.setdefault(r,set()).add(p['net']);np.setdefault(p['net'],set()).add(r);p['root']=r
log('SHORTS: '+str({str(k):list(v) for k,v in cn.items() if len(v)>1}))
log('OPENS: '+str({k:list(v) for k,v in np.items() if len(v)>1}))
log(f'{len(pins)} unique named pins; {len(drills)} plated holes; {len(np)} electrical nets including unused NET_1.')
for net in sorted(np):log(net+': '+', '.join(k for k,p in pins.items() if p['net']==net))
outline=box(2.54,-54.61,30.48,-29.21)
log('Board dimensions: 27.94 mm X x 25.40 mm Y; ONE board, no V-scores.')
for li,ll in enumerate(layers):
 ds=[]
 for i,g in enumerate(islands[li]):
  for j,h in enumerate(islands[li][:i]):
   if root((li,i))!=root((li,j)):
    ds.append((g.distance(h),cn.get(root((li,i))),cn.get(root((li,j))),[tuple(p.coords)[0] for p in nearest_points(g,h)]))
 log(('TOP' if li==0 else 'BOTTOM')+' smallest different-net gaps: '+str(sorted(ds,key=lambda a:a[0])[:6]))
 log(('TOP' if li==0 else 'BOTTOM')+' copper to board edge: '+str(min(g.distance(outline.boundary) for g in islands[li])))
 assert all(outline.covers(g) for g in islands[li])
 log('Track widths: '+str(sorted(set(a['w'] for a in ll if a['kind']=='track'))))
rings=[]
for xy,d in drills:
 for li,ll in enumerate(layers):
  a=min((a for a in ll if a['kind']=='pad'),key=lambda a:Point(a['xy']).distance(Point(xy)))
  assert Point(a['xy']).distance(Point(xy))<.001
  rings.append((a['g'].boundary.distance(Point(xy))-d/2,xy))
log('Minimum nominal annular ring mm: '+str(min(rings)))
for ref in ['R1','R3','R4','R5','C3','C4']:
 log(ref+' pitch mm: '+str(math.dist(pins[ref+'_1']['xy'],pins[ref+'_2']['xy'])))
# Explicit logical comparison to intended circuit; passive pin polarity is irrelevant.
checks={'R1':{'12','NET_2'},'R3':{'9','GND'},'R4':{'+5V','10'},'R5':{'10','GND'},'C3':{'9','GND'},'C4':{'10','GND'}}
for ref,nets in checks.items():assert {pins[ref+'_1']['net'],pins[ref+'_2']['net']}==nets
assert [pins[f'J1_{i}']['net'] for i in range(1,9)]==['+5V','GND','+3V3','NET_1','12','11','10','9']
log('PASS intended resistor/divider/filter topology and J1 pin order. Component values NOT in these files.')
fig,axs=plt.subplots(1,3,figsize=(18,7))
for ax,which,title in zip(axs,[[0],[1],[1,0]],['Top copper','Bottom copper (viewed from top)','Both layers (viewed from top)']):
 for li in which:
  for a in layers[li]:ax.add_patch(Patch(list(a['g'].exterior.coords),facecolor=['#df2929','#265fde'][li],alpha=.7,edgecolor='none'))
 for xy,d in drills:ax.add_patch(plt.Circle(xy,d/2,color='white',zorder=5))
 for name,p in pins.items():
  x,y=p['xy'];ax.text(x,y+.95,name+' '+p['net'],fontsize=5.5,rotation=45,zorder=6)
 ax.plot(*outline.exterior.xy,color='black');ax.set_aspect('equal');ax.set_xlim(1,32);ax.set_ylim(-55,-27);ax.set_title(title);ax.set_xlabel('mm');ax.grid(alpha=.2)
fig.tight_layout();fig.savefig(P/'copper-review.png',dpi=200)
(P/'geometry-checks.txt').write_text('\n'.join(report))

fig,axs=plt.subplots(1,2,figsize=(12,6))
for li,(side,ext) in enumerate([('Top','GTS'),('Bottom','GBS')]):
 mask=parse(f'Gerber_{side}SolderMaskLayer.{ext}')
 silk=parse(f'Gerber_{side}SilkscreenLayer.'+('GTO' if li==0 else 'GBO'))
 mg=unary_union([a['g'] for a in mask]);sg=unary_union([a['g'] for a in silk])
 assert len(mask)==30
 uncovered=[];encroach=[]
 for a in layers[li]:
  if a['kind']=='pad' and not mg.buffer(.001).covers(a['g']):uncovered.append(a['xy'])
 for a in mask:
  net=next((v['net'] for v in pins.values() if math.dist(v['xy'],a['xy'])<.001),None)
  for i,g in enumerate(islands[li]):
   if net not in cn[root((li,i))] and a['g'].intersects(g):encroach.append((a['xy'],net,cn[root((li,i))]))
 log(side+' mask openings: 30; incompletely exposed pads: '+str(uncovered)+'; openings exposing other nets: '+str(encroach))
 log(side+' silk overlap mask area mm2: '+str(sg.intersection(mg).area))
 ax=axs[li];ax.add_patch(Patch(list(outline.exterior.coords),facecolor='#183e30'))
 for a in layers[li]:ax.add_patch(Patch(list(a['g'].exterior.coords),facecolor='#39644c',edgecolor='none'))
 for a in mask:ax.add_patch(Patch(list(a['g'].exterior.coords),facecolor='#bbbbbb',edgecolor='none'))
 for a in silk:ax.add_patch(Patch(list(a['g'].exterior.coords),facecolor='white',edgecolor='none'))
 for xy,d in drills:ax.add_patch(plt.Circle(xy,d/2,color='#111111'))
 ax.set_aspect('equal');ax.set_xlim(1,32);ax.set_ylim(-55,-27);ax.set_title(side+' (viewed from top)')
fig.tight_layout();fig.savefig(P/'manufactured-appearance.png',dpi=200)
(P/'geometry-checks.txt').write_text('\n'.join(report))


fig,ax=plt.subplots(figsize=(8,6))
for a in layers[1]:ax.add_patch(Patch(list(a['g'].exterior.coords),facecolor='#2865ce',edgecolor='none',alpha=.8))
for xy,d in drills:ax.add_patch(plt.Circle(xy,d/2,color='white'))
x,y=pins['R4_2']['xy'];ax.plot([x,8.72008],[y,y],color='#ee8800',lw=4,linestyle='--',label='Suggested short connection to pad centre')
ax.annotate('Only ~0.051 mm copper overlap',xy=(8.365,-40.64),xytext=(6.2,-39.4),arrowprops={'arrowstyle':'->'},fontsize=10)
ax.set_xlim(5.8,10.1);ax.set_ylim(-42.1,-38.9);ax.set_aspect('equal');ax.set_title('R4 100k: 5V pad, bottom copper viewed from top');ax.legend(loc='lower left',fontsize=8);ax.grid(alpha=.2)
fig.tight_layout();fig.savefig(P/'R4-connection.png',dpi=180)
