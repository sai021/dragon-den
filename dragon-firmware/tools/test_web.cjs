// Headless phone-size UI checks against simulated device responses.
// Usage: node tools/test_web.cjs PATH_TO_PLAYWRIGHT [PATH_TO_BROWSER]
const assert=require('node:assert/strict');
const fs=require('node:fs');
const path=require('node:path');
const {chromium}=require(process.argv[2]||'playwright');
const root=path.resolve(__dirname,'..');
const presets=JSON.parse(fs.readFileSync(path.join(root,'presets/dragons.json'),'utf8')).presets;
const zoneMap=[[8,1,1,8,9,2,2,9],[1,8,3,5,5,4,9,2],[1,8,5,5,5,5,9,2],[8,8,5,5,5,5,9,9],[8,8,8,6,6,9,9,9],[8,8,6,6,6,6,9,9],[0,7,6,6,6,6,9,0],[0,7,7,7,7,0,0,0]].flat();

(async()=>{
 const browser=await chromium.launch({headless:true,...(process.argv[3]?{executablePath:process.argv[3]}:{})});
 try{
  const page=await browser.newPage({viewport:{width:390,height:844},deviceScaleFactor:1});
  const errors=[];page.on('pageerror',error=>errors.push(error.message));
  let state={connected:false,accessPoint:true,connecting:false,mode:0,hostname:'Dragon-test',ip:'192.168.1.23',message:'Ready to play',dragon:0,brightness:100,profile:0};
  let profiles=[{id:0,name:"All",brightness:100,favorites:[]}],customs=[];
  let scanReads=0,scanWrites=0,forgot=false;
  await page.route('http://dragon.test/**',async route=>{
   const request=route.request(),url=new URL(request.url()),data=new URLSearchParams(request.postData()||'');
   const json=body=>route.fulfill({status:200,contentType:'application/json',body:JSON.stringify(body)});
   if(url.pathname==='/')return route.fulfill({contentType:'text/html',body:fs.readFileSync(path.join(root,'web/dragon-den.html'),'utf8').replace('<script src="/library.js"></script>','<script>'+fs.readFileSync(path.join(root,'web/library.js'),'utf8')+'</script>')});
   if(request.method()==='POST')assert.equal(request.headers()['x-dragon-request'],'1');
   if(url.pathname==='/api/dragons')return json([{id:0,name:'Blue'},{id:1,name:'Sundew'},...customs.map(d=>({...d,owned:d.owner===state.profile}))]);
   if(url.pathname==='/api/library')return json({active:state.profile,profiles:profiles.filter(Boolean),customLimit:8});
   if(url.pathname==='/api/dragon-detail'){const id=Number(url.searchParams.get('id')),custom=customs.find(d=>d.id===id);return json({id,base:custom?.base??id,name:custom?.name??'Blue',canEdit:Boolean(custom&&custom.owner===state.profile),colorMask:custom?.colorMask??0,colors:custom?.colors??Array(10).fill('#123456'),pixels:presets[custom?.base??id].pixels,zones:zoneMap,effectZones:custom?.effectZones??[0,0,0,0]})}
   if(url.pathname==='/api/custom'){const id=Number(data.get('id'))<0?81+customs.length:Number(data.get('id'));const custom={id,owner:state.profile,custom:true,name:data.get('name'),base:Number(data.get('base')),colorMask:Number(data.get('colorMask')),colors:data.get('colors').match(/.{6}/g).map(c=>'#'+c),effectZones:data.get('effectZones').split(',').map(Number)};customs=customs.filter(d=>d.id!==id);customs.push(custom);state.dragon=id;state.mode=0;return json({id})}
   if(url.pathname==='/api/delete-profile'){const id=Number(data.get('id'));assert.notEqual(id,0);for(const custom of customs)if(custom.owner===id)custom.owner=0;profiles[id]=null;state.profile=0;state.dragon=0;return json({})}
   if(url.pathname==='/api/delete-custom'){const id=Number(data.get('id'));customs=customs.filter(d=>d.id!==id);for(const p of profiles)if(p)p.favorites=p.favorites.filter(value=>value!==id);if(state.dragon===id)state.dragon=0;return json({})}
   if(url.pathname==='/api/profile'){const action=data.get('action');if(action==='create'){state.profile=profiles.length;profiles.push({id:state.profile,name:data.get('name'),brightness:100,favorites:[]})}else if(action==='select')state.profile=Number(data.get('id'));else{Object.assign(profiles[state.profile],{name:data.get('name'),brightness:Number(data.get('brightness')),favorites:data.get('favorites')?data.get('favorites').split(',').map(Number):[]})}state.dragon=profiles[state.profile].favorites[0]??0;state.brightness=profiles[state.profile].brightness;state.mode=0;return json({})}
   if(url.pathname==='/api/state')return json(state);
   if(url.pathname==='/api/play'){
    if(data.get('action')==='dragon'){state.dragon=Number(data.get('value'));state.mode=0}
    if(data.get('action')==='effect')state.mode=['zones','breathe','colorcycle','glitter','incendio','leviosa'].indexOf(data.get('value'));
    if(data.get('action')==='toggle'){state.mode=state.mode===9?0:9}
    if(data.get('action')==='brightness')state.brightness=Number(data.get('value'));
    return json({});
   }
   if(url.pathname==='/api/scan'){
    if(request.method()==='POST'){scanWrites++;return json({})}
    scanReads++;return json({scanning:scanReads===1,networks:scanReads===1?[]:[{name:'Family Wi-Fi',open:false}]});
   }
   if(url.pathname==='/api/wifi'){
    if(data.get('password')==='wrong-pass'){state.message='Could not join home Wi-Fi. Check the name and password, then try again.';return json({})}
    assert.equal(data.get('ssid'),'Family Wi-Fi');state.connected=true;state.message='Home Wi-Fi saved';return json({});
   }
   if(url.pathname==='/api/forget-wifi'){forgot=true;state.connected=false;return json({})}
   return route.fulfill({status:404,body:'Missing mock endpoint'});
  });
  await page.goto('http://dragon.test/');
  await page.locator('#dragon:not([disabled])').waitFor();
  await page.selectOption('#dragon','1');
  await page.waitForFunction(()=>document.querySelector('#dragon').value==='1');
  await page.click('[data-effect="glitter"]');
  await page.locator('[data-effect="glitter"][aria-pressed="true"]').waitFor();
  await page.click('[data-effect="incendio"]');
  await page.locator('[data-effect="incendio"][aria-pressed="true"]').waitFor();
  await page.click('#sleep');await page.getByRole('button',{name:'Wake my dragon',exact:true}).waitFor();
  await page.click('#sleep');await page.getByRole('button',{name:'Put dragon to sleep',exact:true}).waitFor();
  await page.click('#profile-settings summary');assert.equal(await page.locator('#delete-profile').isVisible(),false);await page.fill('#new-profile-name','Test');await page.click('#new-profile');await page.waitForFunction(()=>document.querySelector('#feedback').textContent==='Your new profile is ready.');assert.equal(await page.locator('#dragon').isDisabled(),true);
  await page.click('#create-dragon');await page.locator('#editor:not([hidden])').waitFor();
  await page.fill('#custom-name','My Spark');await page.selectOption('#region','5');
  await page.locator('#region-color').evaluate(input=>{input.value='#ff6600';input.dispatchEvent(new Event('input',{bubbles:true}))});
  await page.selectOption('#region-effect','3');
  await page.locator('#editor').screenshot({path:path.join(root,'.tools/custom-editor-phone.png')});
  await page.click('#save-custom');await page.waitForFunction(()=>document.querySelector('#feedback').textContent==='Your dragon is saved!');
  assert.equal(customs[0].name,'My Spark');assert.equal(customs[0].colorMask,1<<5);assert.equal(customs[0].effectZones[3],1<<5);
  await page.check('#favorite-81');await page.selectOption('#profile-glow','40');await page.click('#save-profile');
  await page.waitForFunction(()=>document.querySelector('#feedback').textContent==='Profile saved.');assert.deepEqual(profiles[1].favorites,[81]);assert.equal(state.brightness,40);assert.equal(await page.locator('#dragon option').count(),1);assert.equal(await page.locator('#dragon option[value="0"]').count(),0);
  await page.fill('#new-profile-name','Alex');await page.click('#new-profile');await page.waitForFunction(()=>document.querySelector('#feedback').textContent==='Your new profile is ready.');
  assert.equal(state.profile,2);assert.equal(await page.locator('#dragon option[value="81"]').count(),0);
  await page.selectOption('#profile','1');await page.waitForFunction(()=>document.querySelector('#feedback').textContent==='Profile selected.');
  assert.equal(await page.locator('#dragon option[value="81"]').count(),1);
  await page.reload();await page.locator('#profile:not([disabled])').waitFor();assert.equal(await page.inputValue('#profile'),'1');
  assert.equal(await page.locator('#dragon option[value="81"]').count(),1);
  await page.click('#profile-settings summary');page.once('dialog',dialog=>dialog.accept());await page.click('#delete-profile');await page.waitForFunction(()=>document.querySelector('#feedback').textContent==='Profile deleted. Its creations are in All.');assert.equal(state.profile,0);assert.equal(customs[0].owner,0);assert.equal(await page.locator('#dragon option').count(),3);assert.equal(await page.locator('#delete-profile').isVisible(),false);assert.equal(await page.locator('#dragon option[value="81"]').count(),1);
  await page.selectOption('#dragon','81');await page.click('#create-dragon');await page.locator('#editor:not([hidden])').waitFor();page.once('dialog',dialog=>dialog.accept());await page.click('#delete-custom');await page.waitForFunction(()=>document.querySelector('#feedback').textContent==='Custom dragon deleted.');assert.equal(customs.length,0);assert.deepEqual(profiles[0].favorites,[]);
  await page.click('#parents summary');await page.click('#scan');
  await page.waitForFunction(()=>document.querySelector('#networks').children.length===1);
  assert.equal(scanWrites,1);assert.equal(scanReads,2);
  await page.fill('#ssid','Family Wi-Fi');await page.fill('#wifi-password','wrong-pass');
  await page.check('#show-password');assert.equal(await page.getAttribute('#wifi-password','type'),'text');
  await page.click('#connect');await page.getByText('Could not join home Wi-Fi.',{exact:false}).waitFor();
  await page.fill('#wifi-password','correct-pass');await page.click('#connect');
  await page.locator('#home-address:not([hidden])').waitFor();
  assert.equal(await page.locator('#home-address a').first().getAttribute('href'),'http://Dragon-test.local/');
  assert.equal(await page.inputValue('#wifi-password'),'');
  assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth),true);
  await page.locator('#parents').evaluate(element=>element.open=false);
  await page.screenshot({path:path.join(root,'.tools/web-preview-phone.png'),fullPage:true});
  await page.locator('#parents').evaluate(element=>element.open=true);
  page.once('dialog',dialog=>dialog.accept());await page.click('#forget');
  await page.waitForFunction(()=>document.querySelector('#feedback').textContent.startsWith('Home Wi-Fi forgotten'));
  assert.equal(forgot,true);assert.deepEqual(errors,[]);
  console.log('PASS: phone layout, selection, effects, sleep/wake, Wi-Fi scanning, password visibility, error/retry, reconnect links forgetting Wi-Fi, custom region editing, saving, profile favourites, switching and page reload.');
 }finally{await browser.close()}
})().catch(error=>{console.error(error);process.exitCode=1});
