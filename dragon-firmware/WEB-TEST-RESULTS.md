# Connection prototype validation — 14 October 2026

- Final Arduino-ESP32 build passed using the project's ESP32-S3 FQBN and bundled Arduino CLI.
- Final revised application: 1,041,698 bytes, below the custom 1,572,864-byte app partition.
- Static RAM: 49,492 bytes; compiler reports 278,188 bytes remaining before runtime allocations.
- All seven existing Python catalog/import/editor tests passed. These do not test Wi-Fi behaviour.
- JavaScript extracted from the final embedded page passed `node --check`.
- No firmware upload was performed. A board is enumerated on COM21.
- The user identified COM21 as a spare/unwired board. Its existing firmware reports an invalid divider reading and zero permitted lighting load. It was left unchanged; this does not validate the intended wired dragon.
- Touch gesture, actual network provisioning, iPhone/Android browser behaviour and Wi-Fi power draw remain unverified. Use the acceptance checklist in WEB-SETUP.md.

The build tool's generic flash percentage is not the custom application partition
percentage; the helper separately enforces the actual application size limit.

## Revised setup flow

- Eight native C++ suites compiled and passed: core, load, power, presets, sensors, startup, voltage and connection policy.
- Connection-policy tests cover first use, deliberately reopening setup, refusing to close while a client is joined or a connection is pending, the idle deadline, interrupted startup holds, late ordinary presses, and timer rollover.
- Native renderer tests retain actual lighting and touch code; the radio adapter is excluded from host builds.
- Headless Edge/Playwright at 390 × 844 passed UI checks for selection, glitter/fire, sleep/wake, asynchronous scan, password visibility, failed-password retry, clearing the submitted password, reconnect links and forgetting Wi-Fi. The API responses in this test are simulated, not ESP32 responses.
- The final page was visually inspected from `.tools/web-preview-phone.png`; no horizontal overflow was detected.
- The final revised firmware build passed after the last endpoint and page changes.
- Seven existing Python tests passed.
- Wi-Fi power measurements and physical iPhone/Android testing remain outstanding.

## Wired board, laptop USB-C only

The user connected COM21 to the circuit and confirmed that external/main power
remained disconnected. Laptop USB-C powered the circuit through the ESP32.
Deployment instead supplies the matrix directly from the external product rail.
This context is recorded in AGENTS.md and HARDWARE-WIRING.md.

- Existing firmware passed the 300/400 mA startup windows at about 5.11 V and selected `computer_usb_cap=1`, `session_max=400mA`.
- The first web upload reproduced a startup InstructionFetchError in the Arduino network event callback dispatcher. The trace was decoded against the uploaded ELF.
- Added `build_opt.h` with `-DNETWORK_EVENTS_MUTEX`, using the pinned Arduino core's built-in callback locking throughout the build. The reproduced startup crash ceased with this build.
- Serial checks observed uninterrupted uptime past 68 seconds, glitter mode, restoration to normal Blue and the retained 400 mA USB ceiling. This checked serial control, not HTTP control.
- Corrected the device-name suffix to skip the vendor MAC prefix in the little-endian eFuse value; a regression test checks two devices with the same vendor prefix produce different names.
- Final build after that correction: 1,093,318 bytes, static RAM 49,820 bytes. Uploaded to COM21; flash hashes verified. Final reboot observed through 30 seconds with no panic/restart.
- Final setup network: `Dragon-b05773`. Generated `.tools/dragon-setup-card.html` with its retained device password and parent login. Credential-containing files remain in the ignored `.tools` directory; serial logs redact the password.
- Normal Blue restored, brightness target 100%, automatic ambient dimming enabled. The session ceiling still limits LED output.

Physical phone login/provisioning, the power-on touch gesture and external-only
deployment power measurements are still pending. Startup rail readings are not
measurements of Wi-Fi peak current or proof of sustained supply capacity.

## Profiles and creations — 15 October 2026

- Implemented four profiles, up to twelve ordered favourites per profile, saved startup glow and active-profile selection, and eight owned custom dragons across the device.
- Custom editing supports all ten regions, preserves untouched imported pixels, stores per-region effects, and supports replacement, copying and confirmed deletion. Supplied dragons remain immutable.
- Ten native C++ suites passed, including new library and custom-renderer tests. The library suite covers recovery from a damaged newest snapshot and failed writes. The renderer suite exercises fully white custom dragons across all six effect modes and six power ceilings, plus favourites and sleep/wake.
- Headless 390 × 844 browser checks with simulated responses passed profile creation/selection, favourites, custom region editing, save, reload and confirmed deletion as well as the existing play/setup flow. Editor screenshots were visually inspected.
- Final firmware: 1,113,438 bytes, static RAM 50,908 bytes. Uploaded to COM21 with flash hash verification; observed uninterrupted uptime through 30 seconds after reboot.
- Live startup reports `library_ready=1`, Family profile, no creations yet, generation zero, `computer_usb_cap=1`, `session_max=400mA` and no panic/reboot. External/main power remained disconnected throughout testing.
- The setup network and password were retained. No sample profiles or creations were injected into the live device.
- Actual phone saves followed by unplug/replug are still required to verify physical NVS persistence end to end. The storage and browser simulations do not substitute for that check.

## Profile filtering and protected All — 15 October 2026

- Named-profile play lists now contain saved favourites plus their owned creations. The full catalog remains available for choosing favourites and starting an edited copy. Empty profiles show an add/create prompt and cannot wake a previous profile's lighting through touch or web controls.
- All replaces the former default Family profile, shows every supplied/custom dragon, and cannot be renamed or deleted. Existing creation records and glow are retained. The default profile's old favourite restriction is cleared.
- Profile deletion frees its slot, moves owned creations to All, and selects All when deleting the active profile. Deletion of profile zero is rejected by the library and API. Editing/deleting creations still checks ownership; other profiles can select shared creations as favourites or make copies.
- Native library, custom renderer, presets, sensors and startup suites passed. Added checks cover protected All, profile deletion/reload, retention of creations, empty-profile touch isolation and collection cycling.
- Simulated phone-browser checks passed filtered and empty lists, creation from an empty profile, profile deletion, retained creations in All and hiding All's delete control, as well as the prior play/setup/editor flows.
- Final build: 1,117,518 bytes, static RAM 50,908 bytes. Uploaded to COM21 and observed through 25 seconds without panic/reboot.
- Live state changed from Family to All while retaining one existing custom dragon and saved generation 8. `library_ready=1` and the 400 mA computer-USB ceiling remained in place.
