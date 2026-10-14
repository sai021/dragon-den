# GPIO9 LDR / GPIO10 supply-divider circuit — 20 September 2026

- Swapped the analog inputs as installed: LDR divider on GPIO9 (ADC1_CH8), 100 kΩ/20 kΩ supply divider on GPIO10 (ADC1_CH9). Matrix remains GPIO13 and TTP223 remains GPIO12.
- PASS: all 7 C++ and all 7 Python suites. Built at 385,766 sketch bytes and 22,832 bytes static RAM; uploaded to COM21 with all flash hashes verified.
- Live PC-connected startup passed both permitted levels: 300 mA measured 5.126–5.138 V and 400 mA measured 5.114–5.138 V. Final state: `session_max=400mA`, `computer_usb_cap=1`, `startup_failure=0`.
- GPIO9 LDR readings changed plausibly around 2525–2804 in room light. GPIO12 remained `touch=0` with no false presses during the observation. The new board still has default, uncalibrated LDR thresholds (600/3400), so covered and room-light calibration can be repeated later.
- The three invalid-divider entries printed in saved history belong to earlier circuit boots; this successful boot did not add a failure. Live log: `.tools/gpio9-ldr-gpio10-voltage-live.log`.

---

# Replacement ESP32-S3 and revised pins — 19 September 2026

- Reconfigured the matrix to GPIO13, TTP223 to GPIO12, LDR to GPIO10, and supply divider to GPIO9.
- Changed the divider calculation from 100 kΩ/22 kΩ to the installed 100 kΩ/20 kΩ ratio. The previous 1.0135 ADC correction remains provisional until checked against a meter on this board.
- PASS: all 7 C++ and all 7 Python suites. Built at 385,766 sketch bytes and 22,832 bytes static RAM; uploaded to the replacement ESP32-S3 on COM21 with all flash hashes verified.
- Live startup correctly detected the computer USB connection but inhibited the matrix: GPIO9 reported 16.552–17.933 V after divider conversion, equivalent to roughly 2.72–2.95 V directly at GPIO9 instead of the expected 0.83–0.85 V. This indicates divider wiring/resistor orientation must be checked. GPIO12 also remained high (`touch=1`) throughout the captured status. Log: `.tools/new-board-com21-live.log`.

---

# Automatic computer USB cap — 19 September 2026

- The ESP32-S3 now checks the native USB Serial/JTAG host connection after the 2.8-second stabilization period. An enumerated computer stops the startup sweep after the tested 400 mA level.
- A computer connected later immediately lowers a larger operating ceiling to 400 mA. The cap stays latched for the session; a power-only charger does not trigger it.
- `status` and `power status` report `computer_usb_cap=0|1`.
- PASS: all 7 C++ and all 7 Python suites. The startup integration test verifies exactly two load levels, a 400 mA peak and a 400 mA final ceiling in simulated computer mode.
- Built and uploaded on COM17 with verified flash hashes: sketch 385,766 bytes, binary 385,904 bytes, static RAM 22,832 bytes.
- Live PC-connected boot tested only 300 and 400 mA, then reported `session_max=400mA result=computer USB cap computer_usb_cap=1`; both levels passed around 5.15–5.21 V. Log: `.tools/computer-usb-cap-live.log`.

---

# Asymmetric voltage test and confirmation retry — 19 September 2026

- Supply capacity now depends on low-side behavior only: absolute/relative minimum, relative mean, and `mean - minimum` compared with the 500 mA baseline. Higher readings remain in the recorded max/range/stddev statistics but no longer make a supply look weak.
- Added a separate 5.5 V overvoltage cutoff and five-blink red diagnostic. Invalid-divider and overvoltage faults stop immediately.
- A low or downward-unstable load level is unloaded for 300 ms and repeated once. Only a repeated failure reduces the session ceiling.
- PASS: all 7 C++ suites, including simulated upward spikes, overvoltage, first-window droop recovery and every fallback. PASS: all 7 Python tests.
- Built and uploaded on COM17 with verified flash hashes: sketch 385,542 bytes, binary 385,680 bytes, static RAM 22,824 bytes.
- Live sweep passed all six levels and selected 2400 mA. The largest measured value was 5.440 V at 1600 mA; it was retained in the statistics without causing a false capacity failure. Log: `.tools/asymmetric-live.log`.

---

# Power startup tolerance & 4.5 V floor — 18 September 2026

- Updated startup power sweep in `StartupPower.h` and `DragonPrototype.ino`:
  - Added **500 ms initial stabilization delay** before starting the load sweep to allow external power rails and bulk decoupling capacitors to settle.
  - Increased per-level load settling time from 100 ms to **150 ms**.
  - Lowered minimum voltage floor from 4.6 V to **4.5 V**.
  - Relaxed noise and variability thresholds: `rangeLimit = max(3x baseline range, 0.250 V)` (from 0.150 V), `deviationLimit = max(3x baseline stddev, 0.070 V)` (from 0.040 V) to tolerate consumer USB charger switching ripple.
- All 7 C++ test suites and Python tests passed.
- Flashed to ESP32-S3 on COM17; all flash segment hashes verified (sketch 382,422 bytes, binary 382,560 bytes, static RAM 21,984 bytes).
- Live verification on COM17: startup sweep passed all 6 levels (300 mA, 400 mA, 500 mA baseline, 800 mA, 1600 mA, 2400 mA), `session_max=2400mA result=all levels passed startup_failure=0`.

---

# Hybrid ambient light mode — 18 September 2026

- Updated LDR ambient light engine in `SensorControl.h`:
  - In darkness (at/below `dark` threshold), output dims to a gentle **10% floor** so the dragon remains softly visible.
  - As ambient lighting increases towards normal room light, output scales smoothly up through 10 discrete steps (10% to 100%) with 24-count boundary hysteresis and 1-second dwell.
  - Superbright light (direct sunlight/torch above `bright`) triggers daylight shutoff (`ambientGain = 0%`) after a 5-second dwell; recovers automatically when light drops below the daylight threshold.
  - Calibration formula updated: `dark = covered + span * 0.15`, `bright = uncovered + headroom * 0.50` (e.g. for covered=0, room=2515 -> dark=377, bright=3305).
- All 7 C++ test suites passed via Zig C++: `test_core`, `test_load`, `test_power`, `test_presets`, `test_sensors`, `test_startup`, `test_voltage`.
- All 7 Python tests passed: `test_matrix_import`, `test_palette_config`, `test_palette_editor`.
- Flashed to ESP32-S3 on COM17; all flash segment hashes verified (sketch 382,414 bytes, binary 382,560 bytes, static RAM 21,984 bytes).
- Live verification on COM17: NVS calibration updated to `thresholds=377/3305 calibrated=1`. Live room reading `ldr=2254` gives `night=1`, `light_step=6`, `light_gain=60%`, `touch_gain=100%`, dragon actively illuminated.

---

# Standalone blink diagnostics — 18 September 2026

Added repeating slow dim-red bottom-row codes only when no startup power level passes: 1 low voltage, 2 invalid divider reading, 3 variability, 4 incomplete window. Diagnostic load adds about 10 mA in the LED model, bypasses light/touch scaling, and makes no extra voltage measurements. Failure reason and last sampled voltage remain in RAM. Startup tests cover all four pulse patterns, off intervals and the diagnostic load bound; build and upload passed with hash verification. Binary 382496 bytes, static RAM 21984 bytes.

USB-attached check passed all six levels (session max 2400 mA, failure=0). However LDR was 2377, above the saved 1886 daylight-off threshold: night=0, light_gain=0, output at idle. This is confirmed ambient shutdown for this session, not proof of what happened on external-only power. User asked to repeat external-only with LDR covered for 15 seconds and report either normal lighting or red blink count. Log: `.tools/startup-blink-diagnostic-installed.log`.

---

# Low-power fallback and two-second indicator â€” 18 September 2026

Current firmware adds 300/400 mA estimated checks ahead of 500/800/1600/2400 mA. Both low levels use one logical bottom row. A rejected 500 mA baseline can now retain 300 or 400 mA rather than leaving the LEDs off. The 500 mA statistics remain the reference for higher levels. A failed 300 mA first check still leaves LEDs off. Final accepted pattern holds for 2000 ms.

- PASS: startup integration (all six levels and every fallback, exact two-second hold, no power NVS writes/runtime ADC), row-pattern tests and all preset limits including 300/400 mA. Earlier standalone Windows-blocked voltage test was not retried or counted as passed.
- Arduino build: sketch 382166 bytes, binary 382304 bytes, static RAM 21968 bytes. Uploaded COM17 and verified hashes.
- Live USB-attached startup passed all six levels, selecting 2400 mA estimated. Minimum/maximum volts: 300 mA 5.154/5.171; 400 mA 5.092/5.109; 500 mA 5.070/5.086; 800 mA 5.002/5.019; 1600 mA 4.811/4.862; 2400 mA 4.704/4.744. Log: `.tools/usb-a-fallback-installed.log`.
- **Power-path limitation:** user clarified the failure occurred with ESP32 USB disconnected and ESP32 powered from external 5 V. Attached-USB readings in this and earlier sections may include computer-supplied power and do not establish external-only capacity. External-only verification remains pending. Do not diagnose the original flash/off behavior solely as charger current limitation without its startup statistics.

---

# Session startup calibration and 81 dragons â€” 18 September 2026

This section describes the current firmware; sections below are historical.

- Uploaded to ESP32-S3 on COM17; all flash hashes verified. Sketch 382,150 bytes, binary 382,288 bytes, static RAM 21,936 bytes. Binary SHA256: 77FAF0188122AD6DC60201772DFE74574C043A40313D95CA151893F22F5BD48D.
- All four startup levels passed on the connected supply. Session ceiling selected: **2400 mA estimated total**, not measured current. Thirty median-of-five samples at each level, following 100 ms settling. Voltage sampling stops after startup. Log: `.tools/session-startup-live.log`.

| Estimated level | Min V | Max V | Mean V | Range V | Stddev V |
|---|---:|---:|---:|---:|---:|
| 500 mA | 4.991 | 4.996 | 4.995 | 0.006 | 0.003 |
| 800 mA | 4.935 | 4.940 | 4.935 | 0.006 | 0.001 |
| 1600 mA | 4.794 | 4.805 | 4.799 | 0.011 | 0.005 |
| 2400 mA | 4.721 | 4.744 | 4.731 | 0.022 | 0.004 |

Values are independently rounded to three decimals, so printed max minus min may differ by 1 mV from the printed range.

- PASS: six C++ host suites: core, power limiter, bottom-up load patterns, actual startup integration, light/touch hierarchy, and presets. They cover all wiring transforms, exact model loads, baseline failure and fallback at each level, no power-record writes, no runtime voltage ADC reads, ten-step targets and fades, LDR four reads/second, gestures, and 3564 limited preset frames.
- **Not executed:** the separate `test_voltage.exe` statistics/relative-threshold unit suite compiled but Windows Application Control blocked execution. No bypass attempted. Its source remains available; do not count it as passed. The actual startup integration suite and hardware startup both executed successfully.
- PASS: seven Python tests, including editor save/preview, validation, all 5184 imported source pixels (with deliberate edge tint), separate edge editing, and per-effect region masks. The import resource-close fix was followed by rerunning its two tests successfully. Generated header check passed.
- Live selections confirmed Glory, Moonwatcher, Winter, Sundew, Mightyclaws and Blue; Blue restored. Session max remained 2400 mA and startup statistics stayed unchanged. Log: `.tools/session-presets-live.log`. The Python live helper lacked pyserial in this runtime, so equivalent serial checks were completed using PowerShell SerialPort.
- LDR reconnected, auto=1, calibration 1006/1886 retained. Touch/light percentages and ceiling are session-local. Sound/I2S/speech code, commands and model upload support removed; active-source search found none remaining. Legacy model partition is unused/reserved.
- Startup row patterns are load-limited, not unrestricted full-white rows. Wing edges remain separate from wings. Source CSV and Markdown preserved. Pre-change backup: `.tools/before-session-power-20260918`.

---

# Voltage divider and fixed-ceiling startup â€” 18 September 2026

- GPIO1 voltage divider enabled: 100 kohm / 22 kohm, 100 nF ceramic. LDR remains GPIO10.
- Removed high-load startup sweep and restart-based capacity search. Fixed 500 mA total estimated ceiling preserves the existing limit; old pending/retest flags cannot increase it. Gentle approximately 2.5-second startup fade.
- Voltage samples every 50 ms: median of five ADC readings, then smoothing. Below 4.65 V for 300 ms derates LEDs 5 points per 100 ms; recovery above 4.85 V stops reductions but never increases gain during the session. Invalid/out-of-range voltage inhibits LEDs until restart.
- PASS: divider conversion, median spike rejection, sag dwell, retained reduction, invalid readings, timer wrap and actual renderer limiting. Startup, sensors, audio, 2,700 preset frames, core and power helper tests also passed before the median-only follow-up; focused voltage tests passed after it.
- Initial upload verified all flash hashes. Live GPIO1 readings approximately 5.17â€“5.22 V; user multimeter reported 5.24 V. A subsequent observed restart was followed by approximately 4.96 V, so no calibration factor was applied pending confirmation of the current connection. Logs: .tools/voltage-divider-live.log and .tools/voltage-calibration-samples.log.
- User confirmed the later meter reading was 5.03 V. Median-filtered uncorrected ADC estimate was 4.963 V; applied factor 1.0135 and verified conversion with a focused unit test. Log: .tools/voltage-median-calibration.log.
- Final calibrated build uploaded and all written hashes verified. Sketch 392,134 bytes; binary 392,272 bytes; static RAM 22,312 bytes. Live filtered voltage 5.02-5.03 V matches the 5.03 V meter reference; sag=0, fault=0, voltage gain=100. No startup load test. Log: .tools/voltage-calibrated-final.log.
- No deliberate supply overload was performed; sag behaviour was tested with simulated readings. Divider measures voltage, not actual current or advertised USB capability.
- Source/tests backed up in .tools/before-voltage-20260918-020932.

# Reliable sound bands and light-control fix â€” 17 September 2026

- User confirmed physical touch and basic sound response work.
- User identified LDR wiring on GPIO10; corrected Config::LIGHT_PIN from GPIO1. The earlier covered/uncovered readings on GPIO1 were from the wrong input and are not calibration data.
- Palette taps, holds and lighting commands now preserve automatic light control. Explicit off remains off. A deliberate touch previews the dragon for 30 seconds in daylight; auto off remains available.
- Added persistent, validated LDR thresholds in the separate dragon-light namespace, with write/readback checking and a two-point calibration command. The power record is preserved.
- Sound uses three Butterworth filter bands and fixed 256-sample blocks: bass body/tail pulses, midrange wing waves and treble soft sparkles. Loudness has attack/release smoothing and a shared peak reference with a noise floor. No pitch guessing, beat prediction or clap toggles.
- PASS: 125, 800 and 4000 Hz tones each dominate the intended band by more than 3x; louder input increases response, quiet noise stays inactive, input chunk sizes do not affect analysis, DC settles, stream stalls expire effects, clipping and timer wrap remain bounded.
- PASS: all existing core, power, startup and preset checks plus updated sensor integration (auto survives taps/holds, manual off, daylight preview expiry, persistent calibration, invalid calibration and failed writes, power-record isolation).
- Production compile PASS: 392,602 bytes reported sketch size, 22,288 bytes static RAM. Binary 392,752 bytes fits the actual custom partition.
- Uploaded on COM17; all written flash hashes verified. Successful five-second startup at the existing 500 mA ceiling, microphone streaming at approximately 16 kHz, quiet RMS around 3â€“5, no clipping. Torch-lit GPIO10 reads 4095; automatic fade reaches zero. Log: .tools/bands-lit-live.log.
- GPIO10 calibration completed with user: covered approximately 0; normal room approximately 2,515; torch 4,095. Saved thresholds 1,006 / 1,886, verified with calibrated=1 and successful NVS write/readback. Calibration logs: .tools/ldr-gpio10-covered.log, .tools/ldr-gpio10-room.log, .tools/bands-calibrated-final.log.
- Live taps retained auto=1 and changed presets. User double-tap OFF remained dark with automatic mode active. New sound appearance with music remains a user aesthetic check; synthetic tone separation and quiet live operation passed.
- Previous source/tests preserved in .tools/before-audio-bands-20260917-230938.

# Connected-sensor firmware â€” 17 September 2026

- Enabled TTP223 momentary active-high input on GPIO2; single/double tap and alternating hold-to-dim. Power retest is now serial-only.
- Added GPIO1 LDR filtering, hysteresis, five-second dwell and fading. Defaults need physical covered/uncovered calibration. Manual commands/touch override automation.
- Added INMP441 16 kHz/32-bit left-channel PCM capture on GPIO7/8/9, nonblocking RMS processing and optional wing effects. Speech recognition defaults off; no recorded or transmitted audio.
- Fixed brightness adjustment at the saved minimum power ceiling by applying dimming after current limiting. OFF also suppresses acknowledgement flashes.
- PASS: core mapping, power-policy, startup/serial power reset, preset suite (2,700 frames), and sensor integration tests: debounce, single/double/hold, timer wrap, manual-off protection, LDR hysteresis/dwell/fade, invalid commands, DC/zero audio, stream stalls and power limits.
- Production compile PASS: 390,414 bytes reported sketch size, 22,008 bytes static RAM. Actual binary 390,560 bytes fits the 1,572,864-byte app partition.
- Final upload also verified all flash hashes; successful five-second startup and microphone capture confirmed in .tools/sensors-final-live.log. No physical touch presses observed yet.
- Initial live upload: all flash hashes verified; stable startup, TTP223 mode active, LDR readings approximately 1,600â€“2,000, microphone sample counter advancing near 16,000 samples/second with nonzero PCM. Quiet RMS approximately 3â€“10. No touch presses captured in the observation window; user gesture, light covering and acoustic stimulus tests remain pending.
- Preserved the board's existing 500 mA ceiling; did not request a power retest. Logs: .tools/sensors-live.log and .tools/sensors-interaction.log.
- Previous source/tests saved in .tools/before-sensors-20260917-221745. See SENSORS.md for current behaviour; older records below describe earlier firmware.

# 8Ã—8 matrix update â€” 17 September 2026

- Firmware now drives exactly 64 WS2812B-compatible LEDs with 8Ã—8 serpentine addressing; rotation, mirroring and column wiring remain supported. Nonzero offsets are rejected.
- Panel idle estimate changed from 256 to 64 mA; total idle reserve is 264 mA. Existing 2,872 mA ceiling and startup recovery records are preserved.
- PASS: 32 wiring configurations, exact row endpoints, invalid coordinates/offsets, current limiting, zone counts and touch-filter regression tests.
- PASS: power policy, actual-sketch startup/effects/commands tests with native touch and TTP223 configurations, and 2,700 preset frames.
- The NeoPixel test double now uses exactly 64 pixels and rejects out-of-range writes.
- PASS: ESP32-S3 production compile, 703,270-byte application and 32,504-byte static RAM. Application fits the actual 1,572,864-byte custom partition.
- Uploaded to ESP32-S3 on COM17 on 17 September 2026; all written flash hashes verified. Existing speech model was retained. Live serial confirms successful five-second startup, startup_pending=0, ceiling 2,872 mA, requested 1,436 mA, estimated 1,435 mA, Classic preset at brightness 44. Log: .tools/matrix-8x8-live.log. Physical appearance/orientation and sensor tests remain pending; touch configuration is unchanged.

Earlier records below describe the previous 16Ã—16 hardware configuration.
# Firmware test record â€” 10 September 2026

## Current build

- Arduino-ESP32 3.2.1 and Adafruit NeoPixel 1.12.5.
- Application binary: 701,552 bytes in a 1,572,864-byte partition; about 871 KB spare.
- ESP-SR model: 2,468,362 bytes in a 2,490,368-byte partition; 22,006 bytes spare.
- Static RAM: 33,080 bytes; build reports 294,600 bytes available before runtime allocations.
- Board confirmed by uploader: ESP32-S3 QFN56 revision 0.2, 4 MB embedded XMC flash and 2 MB embedded PSRAM.
- Model and application uploaded to COM17; every written flash-region hash verified.

## Automated tests

- Core PASS: 2,592 layout/offset combinations, 64 active plus 192 black pixels, zone counts, current estimate, divider helper, native-touch debounce/hold/timer wrap.
- Power policy PASS: version-4 record validation, 20% blackout reduction, 500 mA floor, 2,872 mA full ceiling and RGB current limiting.
- Actual-sketch host test PASS: five-second startup checkpoint, interrupted-start recovery, repeated reduction to the floor, five taps in three seconds, rolling window and timer wrap, all nine voice actions, one-step undo, all effects and current cap.
- The same actual-sketch suite PASS with `DRAGON_USE_TTP223=1`, including digital taps and hold.
- ESP32-S3 production build PASS with ESP-SR and ESP-I2S linked.

## Live result

ESP-SR's I2S/GDMA problem in Arduino core 3.1.3 was fixed by pinning core 3.2.1. Runtime testing then found a hardware capacity limit: MultiNet5 cannot allocate its model in this board's 2 MB PSRAM, even with command-only, mono, reduced-buffer experiments. The final firmware checks PSRAM size before initialization, so it stays stable and reports voice/I2S disabled instead of entering a reboot loop. Temporary changes to the installed ESP-SR library were reverted; the project builds against the stock pinned core.

With that guard active, the board ran continuously. Live serial simulation successfully changed to Patronus glitter, Incendio, Wingardium Leviosa, Revelio, and Mischief Managed while telemetry continued. Reported frame estimates stayed within the saved ceiling. Intentional development reboot loops correctly reduced the ceiling to 500 mA; `power retest` plus a restart then restored 2,872 mA. Final live status is `startup_pending=0`, `max=2872mA`, `requested=1436mA`, `estimate=1436mA`, classic mode, brightness 40, palette 0.

The TTP223 and INMP441 are not physically present, so electrical touch performance, audio capture and spoken-command accuracy are not claimed as tested. The INMP441 code uses mono left-channel I2S at 16 kHz/16 bit. Voice recognition requires an ESP32-S3 variant with at least 4 MB PSRAM.

The blackout flag can detect only an ESP32 restart during the first five seconds. A separately USB-powered ESP32 cannot detect an LED-only supply blackout from that flag.

Live log: `.tools/voice-effects-live.log`.

## Named Wings of Fire presets and colour editor â€” 10 September 2026

Added 11 researched character inspirations (Glory, Tsunami, Moonwatcher, Winter, Peril, Sunny, Clay, Blue, Luna, Cricket, Sundew), retaining the four original palette IDs. Sources, colour choices and distinctions between described appearances and decorative movement are in DRAGON-PALETTES.md and presets/dragons.json. Hex values are authored lighting choices, not official specifications.

The preset library now generates DragonPresets.h before dev.py builds. The menu/CLI and Tk colour-picker editor support region colours, layered movement, timing, animation masks and default preset; cloning is available through the CLI. Edit-Dragon-Colours.cmd launches the GUI on Windows. The static preview reads the actual 64-pixel zone map. JSON validation blocks invalid colours/IDs/effects/ranges and stale generated data. Saves keep a .json.bak backup. Named serial selection and touch/voice palette cycling use the complete catalogue. Startup power testing uses index 0 as its reference, followed by the configured default dragon. All final RGB channels are capped after gain corrections.

Verification PASS:
- Existing core and blackout/current-policy tests.
- Existing actual-sketch tests for native touch AND TTP223: five taps/holds/wrap, nine voice commands, undo and power limits.
- Preset sketch tests: 15 names, unchanged original IDs/colours, animation-zone isolation and actual movement, 2,700 frames across three load budgets, inactive pixels black, malformed names/IDs, palette wrap/undo, gain and channel caps.
- Four Python configuration tests: invalid data, duplicate IDs, overrides, regeneration and stale detection.
- Tk editor test using temporary files: 64 preview cells, colour/effect change, default selection, backup/save, generated-header consistency, preview swatch and invalid timing. Window was constructed hidden for automated testing; no visual comparison against real diffused LEDs was performed.
- Production ESP32-S3 build: application binary 703,424 bytes, static RAM 33,080 bytes. Within the actual 0x180000-byte custom application partition (the Arduino console's 16 MB percentage denominator is not this board's physical capacity). Existing voice model binary is unchanged in purpose and still fits its custom partition.
- Uploaded application on COM17, all written hashes verified. No voice-model changes were needed for presets. Live named commands confirmed Glory, Moonwatcher, Winter, Blue, Sundew and Classic. Current saved maximum 2,872 mA estimate; requested 1,436 mA; startup pending and retest flags clear. Classic restored after smoke test. Log: .tools/dragon-presets-live.log.

The AliExpress item page could not be retrieved; no exact module variant, pin order or mode-pad layout is claimed verified. TTP223 family requirements were checked against Tontek documentation. The hardware is not fitted, and native touch remains enabled. Physical TTP223 performance and aesthetic animation review remain user/hardware checks.
# Persistent startup-failure diagnostics — 19 September 2026

- Added checksum-validated `dragon-diag` NVS storage for the most recent failed startup sweep. It stores the failure reason, attempted-level count, fallback ceiling, last voltage, and count/min/max/mean/range/standard deviation for all attempted levels.
- Failure records are written once after clearing the LEDs, then read back and verified. Successful boots neither write nor erase the saved failure. `power status` prints current and saved results.
- PASS: seven C++ suites and seven Python tests. Startup coverage verifies failed-level persistence, corruption rejection, retention across a successful boot, no flash writes on success, all fallbacks and no runtime voltage sampling.
- Arduino build: sketch 383998 bytes, binary 384144 bytes, static RAM 22152 bytes. Uploaded on COM17; all flash hashes verified.
- The first installed run captured a real failure at the 300 mA estimated level: 30 samples, min 4.648 V, max 5.025 V, mean 4.924 V, range 0.377 V, standard deviation 0.093 V, last sample 4.940 V. Failure code 3 (voltage variability), no fallback level passed. The record was read back successfully from NVS. Log: `.tools/persistent-diagnostic-installed.log`.

---
# Four-entry persistent failure history — 19 September 2026

- Replaced the single saved failure with a checksum-protected four-entry ring, printed oldest to newest. This prevents a predictable PC-only invalid-divider boot from replacing the external-power failure being diagnosed. The prior one-record format is imported in RAM for migration.
- PASS: focused voltage, startup, sensor and 81-preset suites. Tests cover ring wraparound, checksum corruption, failed-level writes and preservation across successful boots.
- Arduino build: sketch 385350 bytes, binary 385488 bytes, static RAM 22824 bytes. Uploaded on COM17; all flash hashes verified.
- Installed PC-only check currently shows the monitored external/matrix rail is not powered by ESP32 USB: divider-equivalent voltage 0.141 V. History contains the two expected PC-only invalid-divider records; capacity remains for the external-only failure and the following PC diagnostic boot. Log: `.tools/failure-history-installed.log`.

---
# External-only startup captured — 19 September 2026

- Persistent entry 2 is the external-only startup: failure code 3 at the first 300 mA estimated step; 30 samples, min 4.659 V, max 5.030 V, mean 4.980 V, range 0.371 V, standard deviation 0.099 V, last sample 5.008 V. No level passed.
- Entries 1, 3 and 4 are expected PC-only invalid-divider boots because GPIO1 monitors the disconnected external/matrix rail (equivalent readings 0.141, 0.736 and 0.601 V).
- This reproduces the earlier variability failure independently. The mean and final voltage are normal, while the transient spread is excessive. The evidence points to the external power path during simultaneous matrix/ESP startup rather than a sustained low-voltage charger output. Log: `.tools/external-power-history-final.log`.

---
# Visible stabilization wait — 19 September 2026

- Replaced the 500 ms silent startup delay with five flashes of one dim-blue face pixel: 200 ms on / 300 ms off, followed by 300 ms fully dark before voltage sampling. No voltage measurements occur during the indication. The modeled incremental LED load is about 1 mA above matrix/controller idle.
- PASS: startup timing, final-dark state, zero ADC reads during indication, indicator load, six load levels, fallbacks and persistent history. Arduino build: sketch 385474 bytes, binary 385616 bytes, static RAM 22824 bytes. Uploaded on COM17; all flash hashes verified.

---
