# Connected sensors

| Part | Connection |
|---|---|
| TTP223 | 3.3 V, common GND, active-high momentary OUT → GPIO11 |
| LDR | 3.3 V → LDR → GPIO9 junction → 10 kΩ → GND |
| Supply divider | VBUS → 100 kΩ → GPIO10 junction → 20 kΩ → GND |
| Divider capacitor | 100 nF ceramic from GPIO10 junction to GND |
| LED matrix | DIN → GPIO12; VBUS/5 V and common GND |

The LDR is connected again. Automatic light control starts enabled. The INMP441 is no longer used; its former GPIO7 and GPIO8 wires may be removed with power disconnected. GPIO10 is the supply-voltage ADC and must remain connected to the 100 kΩ/20 kΩ divider junction.

The divider formula uses the installed 100 kΩ/20 kΩ ratio. Its 1.0135 correction factor is provisionally carried over from the previous ESP32 and should be checked against a simultaneous multimeter reading. It is sampled only during the startup load test. `power status` reads stored session statistics without sampling the ADC again.

Native USB host detection uses the ESP32-S3 USB D+/D− connection. A computer limits the session to 400 mA after the 300 and 400 mA voltage checks; `power status` and `status` show `computer_usb_cap=1`. Detection is session-latched, so disconnecting the computer cannot raise the ceiling without a restart. Power-only chargers continue through the normal capacity sweep.

LDR calibration uses a hybrid ambient mode: in the dark (at or below `dark`, default 600 or calibrated from covered reading) the LEDs dim to a gentle 10% floor. As ambient light increases towards normal room levels, output scales smoothly up through 10 steps (10% to 100%) so the dragon remains clear and vivid. Superbright light (e.g. direct sunlight/torch above `bright`, default 3400) switches output off after a 5-second dwell; when light drops back below the daylight threshold, output restores automatically. Sampling is four reads per second; `auto off` stops LDR ADC reads and fixes ambient gain at 100%. Do not leave auto on with a disconnected/floating sensor.

`light calibrate COVERED ROOM` (e.g. `light calibrate 0 2515`) derives the dark floor (`dark = 377`) and superbright daylight shutoff (`bright = 3305`). `light DARK BRIGHT` sets explicit thresholds. These settings are saved to NVS flash (`dragon-light` namespace) separately from the RAM-only power ceiling and brightness percentages.

Touch: single tap selects next/wakes; double tap toggles off/on; hold adjusts 10–100% in ten steps. It scales the light-controlled output and cannot override a daylight-off decision. See START-HERE.md for the full startup criteria and hierarchy.

## External-only startup diagnosis

Five slow flashes from one dim-blue face pixel mean the firmware is waiting for the power rail and bulk capacitor to settle. Voltage measurements begin only after the blue pixel turns off and the matrix remains fully dark for another 300 ms. Blue is progress, not an error.

If no power level passes, the bottom row gives a repeating dim red code: one blink = voltage below threshold (< 4.5 V); two = invalid divider reading; three = excessive downward instability; four = incomplete sample window; five = overvoltage (> 5.5 V). Each blink lasts 0.5 seconds, with 0.5 seconds between blinks and at least two seconds between groups. Wait ten seconds and count a full group. Low and unstable results receive one unloaded retry before this code appears. Invalid-divider and overvoltage results stop immediately. This diagnostic bypasses ambient/touch dimming, adds about 10 mA LED load in the estimate, and does not restart voltage testing. Successful startup and fallback to a usable level do not blink a code.

The four most recent failed sweeps are stored together in flash with a version and checksum. Each entry contains its failure code, fallback ceiling, last voltage, and count/min/max/mean/range/standard deviation for every attempted level. The history is written once after a failed level with the LEDs cleared, then read back and verified. Successful boots do not write or erase it. `power status` prints the current run and saved history oldest to newest, so a later PC-only invalid-divider boot cannot erase the external-start evidence. The record identifies what firmware measured; it does not by itself prove a charger fault. A steady meter reading of 5.1 V after LEDs shut down cannot exclude a brief startup dip. Check GPIO10-to-GND as well: with the documented divider and 5.1 V at its supply, it should be around 0.85 V.
