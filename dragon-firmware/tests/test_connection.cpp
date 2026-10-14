#include "../DragonPrototype/ConnectionPolicy.h"
#include <cassert>
#include <cstdio>
using namespace DragonConnection;
int main(){
 assert(deviceSuffix(0xb0577372da90ULL)==0xb05773);
 assert(deviceSuffix(0xb0577472da90ULL)!=deviceSuffix(0xb0577372da90ULL));
 assert(openAtBoot(false,false));assert(openAtBoot(false,true));
 assert(!openAtBoot(true,false));assert(openAtBoot(true,true));
 assert(!closeAccessPoint(false,false,0,600000,0));
 assert(!closeAccessPoint(true,true,0,600000,0));
 assert(!closeAccessPoint(true,false,1,600000,0));
 assert(!closeAccessPoint(true,false,0,299999,0));
 assert(closeAccessPoint(true,false,0,300000,0));
 assert(elapsed(100,UINT32_MAX-99,200));
 assert(!elapsed(99,UINT32_MAX-99,200));
 StartupHold hold;
 hold.observe(true,500);hold.observe(true,2499);assert(!hold.requested);
 hold.observe(true,2500);assert(hold.requested);
 hold.observe(false,3000);assert(hold.requested); // stays latched for startup
 StartupHold ordinary;
 ordinary.observe(false,500);ordinary.observe(true,1000);ordinary.observe(true,4000);
 assert(!ordinary.requested); // a later press cannot become the setup gesture
 StartupHold interrupted;
 interrupted.observe(true,500);interrupted.observe(false,1000);interrupted.observe(true,1500);interrupted.observe(true,4000);
 assert(!interrupted.requested);
 StartupHold rollover;
 rollover.observe(true,UINT32_MAX-999);rollover.observe(true,1000);assert(rollover.requested);
 puts("PASS: first-use setup, deliberate recovery, AP inactivity, startup hold and timer rollover.");
}
