#pragma once
#include <cstdint>
#include <cstdio>
#include <cstdarg>
#include <algorithm>
#include <cmath>
#include <stdexcept>
using std::min;
inline uint32_t fakeTime=0;
inline float fakeVoltage=5.05f;
inline int sagAbove=10000, interruptAbove=10000;
inline unsigned shownTotal=456, peakTotal=456;
inline float (*voltageHook)()=nullptr;
inline uint32_t millis(){return fakeTime;}
inline void delay(unsigned n){fakeTime+=n;}
inline unsigned voltageReads=0,lightReads=0;
inline unsigned analogReadMilliVolts(int){voltageReads++;return unsigned((voltageHook?voltageHook():shownTotal>unsigned(sagAbove)?4.6f:fakeVoltage)*1000*20/120);}
inline unsigned fakeLight=1200;
inline unsigned analogRead(int){lightReads++;return fakeLight;}
inline unsigned fakeTouch=40000;
inline unsigned touchRead(int){return fakeTouch;}
inline int fakeDigital=0;
inline int digitalRead(int){return fakeDigital;}
inline void pinMode(int,int){}
constexpr int INPUT_PULLDOWN=0;
inline void analogReadResolution(int){}
inline void analogSetPinAttenuation(int,int){}
constexpr int ADC_11db=0;
struct FakeSerial {
 void begin(int){} int available(){return 0;} int read(){return 0;}
 void println(const char*){} void flush(){} explicit operator bool(){return true;}
 void printf(const char*,...){}
};
inline FakeSerial Serial;
inline bool psramFound(){return true;}
struct FakeESP{
 void restart(){throw std::runtime_error("restart");}
 unsigned getPsramSize(){return 2*1024*1024;}
 unsigned getFreePsram(){return 1024*1024;}
};
inline FakeESP ESP;
