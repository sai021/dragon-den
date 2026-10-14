#include "../DragonPrototype/StartupPower.h"
#include <cassert>
#include <cstdio>
using namespace Dragon;
int main(){
 StartupPower p;Wiring w;RGB frame[64];
 for(int rotation=0;rotation<4;rotation++)for(int mirror=0;mirror<2;mirror++){
  w.quarterTurns=rotation;w.mirror=mirror;
  for(int level=0;level<StartupPower::LEVEL_COUNT;level++){
   p.pattern(frame,level,w);assert(estimatedMilliAmps(frame)+Config::ESP_RESERVE_MA==p.levels[level]);
   int count=0;
   for(int y=0;y<8;y++)for(int x=0;x<8;x++){
    auto c=frame[logicalIndex(x,y,w)];bool lit=c.r||c.g||c.b;
    assert(lit==(y>=8-StartupPower::rows[level]));count+=lit;
    assert(c.r<=204&&c.g<=204&&c.b<=204);
   }
   assert(count==8*StartupPower::rows[level]);
  }
 }
 puts("PASS: bottom 1/1/2/4/6/8 rows, exact estimated loads, channel caps and wiring transforms.");
}
