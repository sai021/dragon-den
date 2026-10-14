# Build and upload on another computer

Copy the whole `dragon-firmware` folder. This is custom Arduino firmware, not WLED.

Install Python 3 and Arduino CLI, open a terminal in this folder, then run:

```sh
python tools/dev.py setup
python tools/dev.py ports
python tools/dev.py build
python tools/dev.py upload --port COM5
python tools/dev.py monitor --port COM5
```

On Windows the Python command may be `py`; on macOS/Linux use `python3`. Replace `COM5` with the port reported by `ports`. Close other serial monitors before uploading.

`setup` pins Arduino-ESP32 3.2.1 and Adafruit NeoPixel 1.12.5. The default FQBN selects the ESP32-S3, hardware USB CDC, 4 MB flash, QSPI PSRAM and custom partitions. Upload compiles and writes the application; there is no speech model. Each reset runs the startup voltage sweep described in START-HERE.md.

If automatic upload cannot enter download mode, hold BOOT, press and release RESET, then release BOOT and retry. The firmware monitor uses 115200 baud.

## Hardware

| Part | ESP32-S3 connection |
|---|---|
| WS2812B DIN | GPIO12, preferably through a 74AHCT125 and 330–470 ohm series resistor |
| TTP223 OUT | GPIO11; `DRAGON_USE_TTP223` defaults to 1 |
| LDR divider junction | GPIO9; junction of LDR and 10 kohm resistor |


GPIO9 reads the LDR divider. GPIO10 reads the supply-voltage divider (100 kohm / 20 kohm with 100 nF).
