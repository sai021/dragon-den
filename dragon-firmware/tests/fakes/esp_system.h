#pragma once
enum {ESP_RST_POWERON,ESP_RST_BROWNOUT,ESP_RST_TASK_WDT,ESP_RST_INT_WDT,ESP_RST_WDT};
inline int fakeReset=ESP_RST_POWERON;
inline int esp_reset_reason(){return fakeReset;}
