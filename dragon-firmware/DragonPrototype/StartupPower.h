#pragma once
#include "PowerPolicy.h"
#include <math.h>
#include <stddef.h>
#include <string.h>
namespace Dragon {
struct VoltageStats {
 uint16_t count=0;
 float minimum=100,maximum=0,mean=0,m2=0;
 void add(float v){
  count++;if(v<minimum)minimum=v;if(v>maximum)maximum=v;
  float d=v-mean;mean+=d/count;m2+=d*(v-mean);
 }
 float range() const{return count?maximum-minimum:0;}
 float deviation() const{return count?sqrtf(m2/count):0;}
};
struct StartupPower {
 static constexpr uint8_t LEVEL_COUNT=6,BASELINE_LEVEL=2;
 static constexpr float LOW_VOLTAGE=4.5f,OVERVOLTAGE=5.5f;
 static constexpr uint16_t levels[LEVEL_COUNT]={300,400,500,800,1600,2400};
 static constexpr uint8_t rows[LEVEL_COUNT]={1,1,2,4,6,8};
 VoltageStats stats[LEVEL_COUNT];
 uint16_t maximum=0;
 uint8_t tested=0;
 // Slow visual code only when no usable level passed:
 // low / invalid / downward instability / incomplete / overvoltage.
 uint8_t failure=0;
 float lastVolts=0;
 const char* result="not tested";
 // Gentle levels establish a usable fallback before attempting the 500 mA baseline.
 // Capacity decisions are deliberately asymmetric: voltage rising under load cannot
 // indicate a weak supply. Full range/stddev remain available for diagnostics.
 bool accept(uint8_t level){
  tested=level+1;const auto& s=stats[level];const auto& b=stats[BASELINE_LEVEL];
  const bool compareBaseline=level>BASELINE_LEVEL;
  if(s.count<30){failure=4;result="insufficient/invalid samples";return false;}
  if(s.maximum>OVERVOLTAGE){failure=5;result="voltage above 5.5 V";return false;}
  if(s.minimum<LOW_VOLTAGE||
     (compareBaseline&&(s.minimum<b.minimum*.9f||s.mean<b.mean*.9f))){
   failure=1;result="voltage drop";return false;
  }
  const float downside=s.mean-s.minimum;
  const float baselineDownside=b.mean-b.minimum;
  const float downsideLimit=fmaxf(.150f,3*baselineDownside);
  if(compareBaseline&&downside>downsideLimit){failure=3;result="downward voltage instability";return false;}
  maximum=levels[level];result=level==LEVEL_COUNT-1?"all levels passed":"level passed";return true;
 }
 void pattern(RGB* frame,uint8_t level,const Wiring& wiring) const {
  clear(frame);
  const uint16_t litRows=rows[level],channels=litRows*8*3;
  const uint32_t sum=uint32_t(levels[level]-BASE_TOTAL_MA)*255/20;
  const uint16_t value=sum/channels,extra=sum%channels;
  for(int y=8-litRows;y<8;y++)for(int x=0;x<8;x++){
   const int channel=((y-(8-litRows))*8+x)*3;
   RGB c={uint8_t(value+(channel<extra)),uint8_t(value+(channel+1<extra)),uint8_t(value+(channel+2<extra))};
   frame[logicalIndex(x,y,wiring)]=c;
  }
 }
};

// Stored only after a failed level. Successful boots never erase this record,
// so connecting USB later cannot destroy the external-power evidence.
struct SavedVoltageStats {
 uint16_t count=0,reserved=0;
 float minimum=0,maximum=0,mean=0,range=0,deviation=0;
};
struct SavedPowerFailure {
 static constexpr uint32_t MAGIC=0x44504631u; // "DPF1"
 static constexpr uint16_t VERSION=1;
 uint32_t magic=MAGIC;
 uint16_t version=VERSION;
 uint8_t failure=0,tested=0;
 uint16_t maximum=0,reserved=0;
 float lastVolts=0;
 SavedVoltageStats stats[StartupPower::LEVEL_COUNT]{};
 uint32_t checksum=0;
};
inline uint32_t failureChecksum(const SavedPowerFailure& record){
 const uint8_t* bytes=reinterpret_cast<const uint8_t*>(&record);
 uint32_t hash=2166136261u;
 for(size_t i=0;i<offsetof(SavedPowerFailure,checksum);i++)hash=(hash^bytes[i])*16777619u;
 return hash;
}
inline SavedPowerFailure makeFailureRecord(const StartupPower& startup){
 SavedPowerFailure record{};
 record.failure=startup.failure;record.tested=startup.tested;
 record.maximum=startup.maximum;record.lastVolts=startup.lastVolts;
 for(uint8_t i=0;i<StartupPower::LEVEL_COUNT;i++){
  const auto& source=startup.stats[i];auto& saved=record.stats[i];
  saved.count=source.count;
  if(source.count){
   saved.minimum=source.minimum;saved.maximum=source.maximum;saved.mean=source.mean;
   saved.range=source.range();saved.deviation=source.deviation();
  }
 }
 record.checksum=failureChecksum(record);return record;
}
inline bool validFailureRecord(const SavedPowerFailure& record){
 if(record.magic!=SavedPowerFailure::MAGIC||record.version!=SavedPowerFailure::VERSION||
    record.failure<1||record.failure>5||record.tested<1||
    record.tested>StartupPower::LEVEL_COUNT||record.maximum>Config::DEFAULT_MAX_TOTAL_MA||
    record.checksum!=failureChecksum(record))return false;
 for(uint8_t i=0;i<StartupPower::LEVEL_COUNT;i++){
  const auto& s=record.stats[i];
  if(s.count>30||!isfinite(s.minimum)||!isfinite(s.maximum)||!isfinite(s.mean)||
     !isfinite(s.range)||!isfinite(s.deviation)||s.range<0||s.deviation<0)return false;
 }
 return isfinite(record.lastVolts);
}
struct SavedFailureHistory {
 static constexpr uint32_t MAGIC=0x44504831u; // "DPH1"
 static constexpr uint16_t VERSION=1;
 static constexpr uint8_t CAPACITY=4;
 uint32_t magic=MAGIC;
 uint16_t version=VERSION;
 uint8_t count=0,next=0;
 SavedPowerFailure records[CAPACITY]{};
 uint32_t checksum=0;
};
inline uint32_t historyChecksum(const SavedFailureHistory& history){
 const uint8_t* bytes=reinterpret_cast<const uint8_t*>(&history);
 uint32_t hash=2166136261u;
 for(size_t i=0;i<offsetof(SavedFailureHistory,checksum);i++)hash=(hash^bytes[i])*16777619u;
 return hash;
}
inline bool validFailureHistory(const SavedFailureHistory& history){
 if(history.magic!=SavedFailureHistory::MAGIC||history.version!=SavedFailureHistory::VERSION||
    history.count>SavedFailureHistory::CAPACITY||history.next>=SavedFailureHistory::CAPACITY||
    history.checksum!=historyChecksum(history))return false;
 for(uint8_t i=0;i<history.count;i++)if(!validFailureRecord(history.records[i]))return false;
 return true;
}
inline void appendFailure(SavedFailureHistory& history,const SavedPowerFailure& record){
 history.records[history.next]=record;
 history.next=(history.next+1)%SavedFailureHistory::CAPACITY;
 if(history.count<SavedFailureHistory::CAPACITY)history.count++;
 history.checksum=historyChecksum(history);
}
}
