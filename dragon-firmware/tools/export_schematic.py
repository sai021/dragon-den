"""Generate an EAGLE 6+ XML wiring schematic for EasyEDA import."""
from pathlib import Path
import xml.etree.ElementTree as E
import csv

OUT=Path(__file__).resolve().parents[1]/'hardware'/'easyeda'
OUT.mkdir(parents=True,exist_ok=True)
def sub(p,t,**a): return E.SubElement(p,t,{k:str(v) for k,v in a.items()})
root=E.Element('eagle',version='9.6.2'); d=sub(root,'drawing')
s=sub(d,'settings');sub(s,'setting',alwaysvectorfont='no');sub(s,'setting',verticaltext='up')
sub(d,'grid',distance='0.1',unitdist='inch',unit='inch',style='lines',multiple=1,display='no',altdistance='0.01',altunitdist='inch',altunit='inch')
layers=sub(d,'layers')
for n,name,col in [(91,'Nets',2),(92,'Busses',1),(93,'Pins',2),(94,'Symbols',4),(95,'Names',7),(96,'Values',7),(97,'Info',7),(98,'Guide',6)]:sub(layers,'layer',number=n,name=name,color=col,fill=1,visible='yes',active='yes')
sch=sub(d,'schematic',xreflabel='%F%N/%S.%C%R',xrefpart='/ %S.%C%R')
libs=sub(sch,'libraries'); lib=sub(libs,'library',name='DragonModules');sub(lib,'description').text='Logical module terminals; assign verified footprints before PCB layout.'
sub(lib,'packages');syms=sub(lib,'symbols');devs=sub(lib,'devicesets')
models={
 'ESP32_S3':['5V','3V3','GND','GPIO12','GPIO11','GPIO9','GPIO10'],
 'MATRIX':['5V','GND','DIN'], 'TTP223':['VCC','GND','OUT'],
 'USB_C_BREAKOUT':['VBUS','GND'], 'RESISTOR':['1','2'],
 'CAPACITOR':['1','2'], 'ELECTROLYTIC':['PLUS','MINUS'], 'LDR':['1','2']}
pincoords={}
for model,pins in models.items():
 sym=sub(syms,'symbol',name=model);h=(len(pins)+1)*2.54
 for x1,y1,x2,y2 in [(0,0,30.48,0),(30.48,0,30.48,h),(30.48,h,0,h),(0,h,0,0)]:sub(sym,'wire',x1=x1,y1=y1,x2=x2,y2=y2,width=.254,layer=94)
 sub(sym,'text',x=0,y=h+2.54,size=1.778,layer=95).text='>NAME'
 sub(sym,'text',x=0,y=-3.81,size=1.27,layer=96).text='>VALUE'
 for i,p in enumerate(pins):
  y=h-(i+1)*2.54;pincoords[model,p]=(-5.08,y)
  sub(sym,'pin',name=p,x=-5.08,y=y,visible='pin',length='middle',direction='pas',rot='R0')
 ds=sub(devs,'deviceset',name=model,prefix='X',uservalue='yes');g=sub(ds,'gates');sub(g,'gate',name='G$1',symbol=model,x=0,y=0)
 devices=sub(ds,'devices');device=sub(devices,'device',name='');tech=sub(device,'technologies');sub(tech,'technology',name='')
sub(sch,'attributes');sub(sch,'variantdefs');classes=sub(sch,'classes');cl=sub(classes,'class',number=0,name='default',width=0,drill=0);sub(cl,'clearance',**{'class':0,'value':.254})
parts=sub(sch,'parts');sheets=sub(sch,'sheets');sheet=sub(sheets,'sheet');plain=sub(sheet,'plain')
for y,txt in [(195,'DRAGON LAMP | GPIO12 MATRIX / GPIO11 TOUCH / GPIO9 LDR / GPIO10 VOLTAGE'),(188,'Module wiring schematic. Named nets join every matching label. No PCB footprints assigned.'),(15,'J1 represents the existing USB-C breakout: onboard CC1/CC2 each have 5.1k to GND; D+/D- unused.'),(10,'Use external J1 power OR ESP32 USB power. Do not connect both powered sources without isolation.'),(5,'1000uF polarity: PLUS to +5V, MINUS to GND. Divider: 100k upper / 20k lower; 5V gives 0.833V.'),(0,'PC detection requires a data cable to ESP32 native USB. A power-only breakout cannot signal a PC host.')]:sub(plain,'text',x=0,y=y,size=1.778,layer=97).text=txt
sub(sheet,'moduleinsts');instances=sub(sheet,'instances');sub(sheet,'busses');nets=sub(sheet,'nets')
items=[
 ('U1','ESP32_S3','ESP32-S3 module',25,145,['+5V','+3V3','GND','LED_DATA','TOUCH_OUT','LDR_ADC','VBUS_ADC']),
 ('J1','USB_C_BREAKOUT','External 5V breakout',25,95,['+5V','GND']),
 ('M1','MATRIX','WS2812B 8x8',100,150,['+5V','GND','LED_DIN']),
 ('R1','RESISTOR','330R recommended',100,110,['LED_DATA','LED_DIN']),
 ('C1','ELECTROLYTIC','1000uF / 10V',100,65,['+5V','GND']),
 ('U2','TTP223','TTP223 / active-high momentary',175,150,['+3V3','GND','TOUCH_OUT']),
 ('C2','CAPACITOR','100nF near TTP223',175,110,['+3V3','GND']),
 ('LDR1','LDR','Photosensitive resistor',250,150,['+3V3','LDR_ADC']),
 ('R2','RESISTOR','10k',250,110,['LDR_ADC','GND']),
 ('C3','CAPACITOR','100nF optional LDR filter',250,65,['LDR_ADC','GND']),
 ('R3','RESISTOR','100k / 1%',325,150,['+5V','VBUS_ADC']),
 ('R4','RESISTOR','20k / 1%',325,110,['VBUS_ADC','GND']),
 ('C4','CAPACITOR','100nF near GPIO10',325,65,['VBUS_ADC','GND'])]
net_elements={};expected={};terminals={}
# A single row leaves every terminal a clear route down to explicit net rails.
items=[(r,m,v,30+i*65,50,c) for i,(r,m,v,x,y,c) in enumerate(items)]
for t in list(plain):plain.remove(t)
for y,txt in [(100,'DRAGON LAMP - EXPLICIT WIRES - GPIO12 MATRIX / GPIO11 TOUCH / GPIO9 LDR / GPIO10 VOLTAGE'),(94,'Junction dots mean connected. Crossings without dots are not connected. Module symbols have no PCB footprints.'),(-50,'Use external J1 power OR ESP32 USB power; no simultaneous supplies without isolation. J1 has onboard CC resistors.'),(-56,'C1: PLUS to +5V, MINUS to GND. R3=100k upper; R4=20k lower. Supply sense is VBUS/6.'),(-62,'C2 bypasses touch supply; C3 is optional LDR filtering. PC detection requires native ESP32 USB data.')]:
 sub(plain,'text',x=0,y=y,size=2,layer=97).text=txt
for ref,model,value,x,y,connections in items:
 sub(parts,'part',name=ref,library='DragonModules',deviceset=model,device='',value=value)
 sub(instances,'instance',part=ref,gate='G$1',x=x,y=y,smashed='no')
 for pin,net in zip(models[model],connections):
  px,py=pincoords[model,pin];px+=x;py+=y
  i=models[model].index(pin)
  tx=round(x-7.62-(len(connections)-i)*2.54,4)
  terminals.setdefault(net,[]).append((ref,pin,round(px,4),round(py,4),tx))
  expected[ref,pin]=net
for index,(net,terms) in enumerate(terminals.items()):
 net_elements[net]=sub(nets,'net',name=net,**{'class':0})
 seg=sub(net_elements[net],'segment');rail=-index*5.08
 xs=sorted(t[4] for t in terms)
 for a,b in zip(xs,xs[1:]):sub(seg,'wire',x1=a,y1=rail,x2=b,y2=rail,width=.254,layer=91)
 for ref,pin,px,py,tx in terms:
  sub(seg,'pinref',part=ref,gate='G$1',pin=pin)
  sub(seg,'wire',x1=px,y1=py,x2=tx,y2=py,width=.1524,layer=91)
  sub(seg,'wire',x1=tx,y1=py,x2=tx,y2=rail,width=.1524,layer=91)
  sub(seg,'junction',x=tx,y=rail)
 sub(seg,'label',x=xs[0],y=rail,size=1.778,layer=95)
sub(sch,'errors')
E.indent(root)
path=OUT/'Dragon-Lamp-Wired.sch'
path.write_text('<?xml version="1.0" encoding="utf-8"?>\n<!DOCTYPE eagle SYSTEM "eagle.dtd">\n'+E.tostring(root,encoding='unicode'),encoding='utf-8')
# Validate every terminal appears exactly once and every reference resolves.
parsed=E.parse(path);actual={}
for net in parsed.findall('.//sheet/nets/net'):
 for p in net.findall('./segment/pinref'):
  key=(p.attrib['part'],p.attrib['pin']);assert key not in actual;actual[key]=net.attrib['name']
assert actual==expected
# Geometric continuity: every pin must be reachable through wire endpoints.
for net in parsed.findall('.//sheet/nets/net'):
 graph={}
 for w in net.findall('./segment/wire'):
  a=(round(float(w.get('x1')),4),round(float(w.get('y1')),4))
  b=(round(float(w.get('x2')),4),round(float(w.get('y2')),4))
  graph.setdefault(a,set()).add(b);graph.setdefault(b,set()).add(a)
 seen=set();todo=[next(iter(graph))]
 while todo:
  a=todo.pop()
  if a in seen:continue
  seen.add(a);todo.extend(graph[a]-seen)
 assert len(seen)==len(graph),net.get('name')
 for _,_,px,py,_ in terminals[net.get('name')]:assert (px,py) in seen
assert len(actual)==sum(len(models[i[1]]) for i in items)
assert expected['U1','GPIO12']=='LED_DATA' and expected['U1','GPIO11']=='TOUCH_OUT'
assert expected['U1','GPIO9']=='LDR_ADC' and expected['U1','GPIO10']=='VBUS_ADC'
assert expected['R3','1']=='+5V' and expected['R3','2']=='VBUS_ADC'
assert expected['R4','1']=='VBUS_ADC' and expected['R4','2']=='GND'
with (OUT/'connections.csv').open('w',newline='',encoding='utf-8') as f:
 w=csv.writer(f);w.writerow(['Part','Terminal','Net']);w.writerows((p,pin,n) for (p,pin),n in expected.items())
print(f'Validated {len(items)} components, {len(actual)} terminals, {len(net_elements)} nets: {path}')
