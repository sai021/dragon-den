#pragma once
#include "Arduino.h"
#include "../../DragonPrototype/Config.h"
#include <cassert>
constexpr int NEO_GRB=0,NEO_KHZ800=0;
struct Adafruit_NeoPixel {
 unsigned sum=0; unsigned char bytes[Config::MATRIX_COUNT*3]={};int pin;
 Adafruit_NeoPixel(int count,int p,int):pin(p){assert(count==Config::MATRIX_COUNT);}
 void begin(){} int getPin(){return pin;}
 void clear(){for(auto& b:bytes)b=0;}
 void setPixelColor(int i,unsigned char r,unsigned char g,unsigned char b){assert(i>=0 && i<Config::MATRIX_COUNT);bytes[i*3]=r;bytes[i*3+1]=g;bytes[i*3+2]=b;}
 void show(){sum=0;for(auto b:bytes)sum+=b;shownTotal=Config::PANEL_IDLE_MA+Config::ESP_RESERVE_MA+(sum*20+254)/255;peakTotal=std::max(peakTotal,shownTotal);if(shownTotal>unsigned(interruptAbove))throw std::runtime_error("power loss");}
};
