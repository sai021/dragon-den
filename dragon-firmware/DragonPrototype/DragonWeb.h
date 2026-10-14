#pragma once
#include <WiFi.h>
#include <WebServer.h>
#include <DNSServer.h>
#include <ESPmDNS.h>
#include <esp_system.h>
#include "ConnectionPolicy.h"

// Included after lighting functions so web and touch share the same state.
namespace DragonWeb {
WebServer server(80);
DNSServer dns;
Preferences store;
struct Credentials { char ssid[33]; char password[65]; } saved{}, pending{};
String deviceName, password, message="Ready to play";
bool ap=false, connecting=false, configured=false, ready=false;
bool scanRequested=false;
uint32_t started=0, retryAt=0, apActivity=0;
#include "DragonWebPage.h"
String quote(const String& value){String out="\"";for(size_t i=0;i<value.length();i++){char c=value[i];if(c=='"'||c=='\\'){out+='\\';out+=c;}else if(uint8_t(c)<32){char escape[7];snprintf(escape,sizeof(escape),"\\u%04x",uint8_t(c));out+=escape;}else out+=c;}return out+'"';}
bool authorize(){if(!server.authenticate("parent",password.c_str())){server.requestAuthentication();return false;}if(server.method()==HTTP_POST&&server.header("X-Dragon-Request")!="1"){server.send(403,"text/plain","Open the Dragon Den to make changes.");return false;}apActivity=millis();server.sendHeader("Cache-Control","no-store");return true;}
void reply(int code,const String& text){server.send(code,"application/json",text);}
bool openAP(){if(ap)return true;WiFi.mode(WIFI_AP_STA);if(!WiFi.softAP(deviceName.c_str(),password.c_str())){message="Could not start setup Wi-Fi. Restart your dragon.";return false;}ap=true;apActivity=millis();dns.start(53,"*",WiFi.softAPIP());return true;}
void connect(const Credentials& credentials){WiFi.begin(credentials.ssid,credentials.password);started=millis();connecting=true;}
#include "LibraryWeb.h"
void begin(bool requested){
 ready=store.begin("dragon-wifi",false);if(!ready){Serial.println("Wi-Fi storage unavailable; networking disabled");return;}
 char suffix[7];snprintf(suffix,sizeof(suffix),"%06lx",(unsigned long)DragonConnection::deviceSuffix(ESP.getEfuseMac()));deviceName=String("Dragon-")+suffix;
 password=store.getString("access","");if(password.length()!=16){char key[17];snprintf(key,sizeof(key),"%08lx%08lx",(unsigned long)esp_random(),(unsigned long)esp_random());password=key;if(store.putString("access",password)!=password.length()){ready=false;return;}}
 if(store.getBytesLength("home")==sizeof(saved)&&store.getBytes("home",&saved,sizeof(saved))==sizeof(saved)&&memchr(saved.ssid,0,sizeof(saved.ssid))&&memchr(saved.password,0,sizeof(saved.password))&&saved.ssid[0])configured=true;
 WiFi.persistent(false);WiFi.mode(WIFI_STA);WiFi.setHostname(deviceName.c_str());WiFi.setAutoReconnect(true);
 if(configured)connect(saved);if(DragonConnection::openAtBoot(configured,requested))openAP();
 Serial.printf("Dragon web: network=%s password=%s login=parent setup=http://192.168.4.1 home=http://%s.local\n",deviceName.c_str(),password.c_str(),deviceName.c_str());
 server.on("/",HTTP_GET,[]{if(authorize())server.send_P(200,"text/html",page);});
 server.on("/api/state",HTTP_GET,[]{if(!authorize())return;bool online=WiFi.status()==WL_CONNECTED;reply(200,String("{\"connected\":")+(online?"true":"false")+",\"accessPoint\":"+(ap?"true":"false")+",\"connecting\":"+(connecting?"true":"false")+",\"mode\":"+String(unsigned(mode))+",\"hostname\":"+quote(deviceName)+",\"ip\":"+quote(WiFi.localIP().toString())+",\"message\":"+quote(message)+",\"dragon\":"+String(palette)+",\"profile\":"+String(library.data.active)+",\"brightness\":"+String(brightness)+"}");});
 server.on("/api/dragons",HTTP_GET,[]{if(!authorize())return;String out="[";unsigned added=0;for(int i=0;i<PRESET_COUNT+DragonLibrary::CUSTOM_LIMIT;i++){if(!(server.arg("catalog")=="1"?DragonLibrary::available(library.data,i,library.data.active):DragonLibrary::contains(library.data,i,library.data.active)))continue;if(added++)out+=',';auto p=library.resolve(i);out+="{\"id\":"+String(i)+",\"name\":"+quote(p.name)+",\"custom\":"+(i>=PRESET_COUNT?"true":"false")+",\"owned\":"+(i>=PRESET_COUNT&&library.data.customs[i-PRESET_COUNT].owner==library.data.active?"true":"false")+"}";}reply(200,out+"]");});
 registerLibraryRoutes();
 server.on("/api/scan",HTTP_POST,[]{
  if(!authorize())return;
  if(connecting){server.send(409,"text/plain","Wait for the Wi-Fi connection attempt to finish.");return;}
  if(WiFi.scanComplete()==WIFI_SCAN_RUNNING){reply(202,"{}");return;}
  WiFi.scanDelete();scanRequested=true;
  int result=WiFi.scanNetworks(true);
  if(result==WIFI_SCAN_FAILED){scanRequested=false;server.send(503,"text/plain","Could not look for networks. You can enter the name yourself.");return;}
  reply(202,"{}");
 });
 server.on("/api/scan",HTTP_GET,[]{
  if(!authorize())return;
  int count=WiFi.scanComplete();
  if(!scanRequested){reply(200,"{\"scanning\":false,\"networks\":[]}");return;}
  if(count==WIFI_SCAN_RUNNING){reply(200,"{\"scanning\":true,\"networks\":[]}");return;}
  if(count<0){server.send(503,"text/plain","Could not look for networks. You can enter the name yourself.");return;}
  String data="{\"scanning\":false,\"networks\":[";unsigned added=0;
  for(int i=0;i<count&&added<32;i++){
   String name=WiFi.SSID(i);if(!name.length()||name==deviceName)continue;
   bool duplicate=false;for(int j=0;j<i;j++)if(WiFi.SSID(j)==name){duplicate=true;break;}
   if(duplicate)continue;if(added++)data+=',';
   data+="{\"name\":"+quote(name)+",\"open\":"+(WiFi.encryptionType(i)==WIFI_AUTH_OPEN?"true":"false")+"}";
  }
  reply(200,data+"]}");
 });
 server.on("/api/wifi",HTTP_POST,[]{if(!authorize())return;if(WiFi.scanComplete()==WIFI_SCAN_RUNNING){server.send(409,"text/plain","Wait for the Wi-Fi search to finish.");return;}if(connecting){server.send(409,"text/plain","Already trying Wi-Fi. Please wait.");return;}String ssid=server.arg("ssid"),key=server.arg("password");bool validKey=key.length()==0||(key.length()>=8&&key.length()<=63);if(key.length()==64){validKey=true;for(size_t i=0;i<64;i++)if(!isxdigit(key[i]))validKey=false;}if(!ssid.length()||ssid.length()>32||!validKey){server.send(400,"text/plain","Check the Wi-Fi name and password length.");return;}pending={};ssid.toCharArray(pending.ssid,sizeof(pending.ssid));key.toCharArray(pending.password,sizeof(pending.password));message="Trying home Wi-Fi…";reply(202,"{}");WiFi.disconnect();connect(pending);});
 server.on("/api/play",HTTP_POST,[]{if(!authorize())return;if(!DragonLibrary::contains(library.data,library.next(255),library.data.active)){server.send(409,"text/plain","Add favourites or make a dragon for this profile first.");return;}String action=server.arg("action"),value=server.arg("value");bool ok=false;int number=0;char buffer[16];value.toCharArray(buffer,sizeof(buffer));if(action=="dragon"&&value.length()<sizeof(buffer)&&readNumber(buffer,0,PRESET_COUNT+DragonLibrary::CUSTOM_LIMIT-1,number)&&DragonLibrary::contains(library.data,number,library.data.active)){if(mode==OFF||!brightness)wakeLighting();setPalette(number);mode=ZONE_VIEW;ok=true;}else if(action=="brightness"&&value.length()<sizeof(buffer)&&readNumber(buffer,0,100,number)){if(number&&mode==OFF)wakeLighting();setBrightness(number);ok=true;}else if(action=="toggle"){toggleLighting();ok=true;}else if(action=="effect"){const char* names[]={"zones","breathe","colorcycle","glitter","incendio","leviosa"};for(int i=0;i<6;i++)if(value==names[i]){if(mode==OFF||!brightness)wakeLighting();mode=Mode(i);ok=true;}}if(ok){rememberLighting();reply(200,"{}");}else server.send(400,"text/plain","Unknown dragon control.");});
 server.on("/api/forget-wifi",HTTP_POST,[]{
  if(!authorize())return;
  if(!openAP()){server.send(503,"text/plain","Could not open setup Wi-Fi. Saved settings were kept.");return;}
  if(store.isKey("home")&&!store.remove("home")){server.send(500,"text/plain","Could not forget Wi-Fi. Try again.");return;}
  configured=false;connecting=false;saved={};pending={};
  message="Home Wi-Fi forgotten. Join the dragon network to continue playing.";
  reply(200,"{}");WiFi.disconnect();MDNS.end();
 });
 const char* headers[]={"X-Dragon-Request"};server.collectHeaders(headers,1);
 server.onNotFound([]{server.sendHeader("Location",ap?"http://192.168.4.1/":"/");server.send(302,"text/plain","");});server.begin();
}
void update(uint32_t now){if(!ready)return;server.handleClient();if(ap)dns.processNextRequest();
 if(connecting&&WiFi.status()==WL_CONNECTED){connecting=false;if(pending.ssid[0]){if(store.putBytes("home",&pending,sizeof(pending))==sizeof(pending)){saved=pending;configured=true;message="Home Wi-Fi saved";}else message="Connected, but settings could not be saved. Try again.";pending={};}else message="Ready to play";MDNS.end();MDNS.begin(deviceName.c_str());MDNS.addService("http","tcp",80);retryAt=now;}
 if(connecting&&DragonConnection::elapsed(now,started,DragonConnection::CONNECT_TIMEOUT_MS)){WiFi.disconnect();connecting=false;pending={};message="Could not join home Wi-Fi. Check the name and password, then try again.";retryAt=now;}
 if(!connecting&&configured&&WiFi.status()!=WL_CONNECTED&&DragonConnection::elapsed(now,retryAt,DragonConnection::RETRY_MS)){retryAt=now;connect(saved);}
 if(ap&&DragonConnection::closeAccessPoint(configured,connecting,WiFi.softAPgetStationNum(),now,apActivity)){dns.stop();WiFi.softAPdisconnect(true);WiFi.mode(WIFI_STA);ap=false;}
}
}
