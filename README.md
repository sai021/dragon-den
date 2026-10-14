# Dragon Den

A touch-controlled dragon lightbox with a phone interface for children and
their parents. An ESP32-S3 drives an 8×8 RGB LED matrix behind a dragon face.
Families can pick dragons, play lighting effects, save personal collections,
and make custom dragons without installing an app or writing code.

**Current state: working development prototype, documented 15 October 2026.**
The firmware is installed on the wired prototype. Phone workflows have been
tested with simulated responses, and hardware startup has been observed. PCB
manufacturing, optical fit, the complete physical-phone test matrix, and the
deployed external power supply have outstanding checks.

## What works

- Tap for the next dragon, double tap for sleep/wake, hold for brightness.
- 81 supplied dragon palettes, plus eight saved custom creations.
- Four profiles: protected **All** and three named collections.
- Named profiles show favourites plus their own creations; physical taps use
  the same collection. Empty profiles invite you to add or create dragons.
- Profile deletion preserves its creations by moving them into All.
- A phone editor for ten regions, including separate wing edges and interiors.
  Untouched regions retain imported pixel variations. Save, copy and delete
  creations, with rainbow, breathing, shimmer and glitter by region.
- One-button glitter, fire, breathing and rainbow, glow control and sleep/wake.
- On-device Wi-Fi setup, nearby network search and saved home-network details.
  Everyday play does not require internet or an account.
- Automatic ambient dimming and startup selection of an estimated power ceiling.

Weather animations, a parent PIN, firmware updates through the web interface,
and export/import backups are not implemented yet.

## Start here

| Reader | Guide |
| --- | --- |
| Parents testing a prepared device | [Phone and touch guide](docs/PARENT-GUIDE.md) |
| End users and families | [Printable user manual](output/pdf/dragon-den-user-manual.pdf) / [editable text](docs/USER-MANUAL.md) |
| Developers setting up another computer | [Build and test](docs/DEVELOPMENT.md) |
| Hardware assembly and power | [Hardware wiring](dragon-firmware/HARDWARE-WIRING.md) |
| Profiles and custom dragons | [Collections and editing](dragon-firmware/PROFILES-AND-CREATIONS.md) |
| Wi-Fi setup and recovery | [Web setup](dragon-firmware/WEB-SETUP.md) |
| Current evidence and unfinished checks | [Project status](docs/PROJECT-STATUS.md) |
| System design and API | [Architecture](docs/ARCHITECTURE.md) |
| Optical/CAD prototype | [Mechanical assets](docs/MECHANICAL-ASSETS.md) |

## Power arrangement

During development, laptop USB-C powers the connected circuit through the
ESP32 USB connector. **External/main power must remain disconnected.** When a
computer USB host is detected, firmware retains a 400 mA **estimated** session
ceiling. This is a model-based limit, not USB power negotiation or a current
measurement.

In the deployed product, the external product supply powers the matrix
directly through the shared 5 V rail. The ESP32 board/USB connector is not the
intended matrix power source. Disconnect laptop USB before external-only tests.
Never connect both powered inputs simultaneously with the current circuit.

## Repository map

```text
docs/                         consolidated project and parent guides
dragon-firmware/
  DragonPrototype/            Arduino sketch, renderer, storage, web API
  web/                        editable offline phone page and editor
  presets/                    editable supplied dragon catalog
  tools/                      build, import, desktop editor and test helpers
  tests/                      native C++, Python and browser checks
  hardware/                   CAD sources, exports and dated Gerber reviews
dragon-masks/                 registered optical masks and artwork references
  light-guide/                canonical mesh build/check scripts and reports
dragon-light-guide-prototype/ legacy delivery notes and validation reports
```

Local runtimes, firmware binaries, logs, device credentials, printable setup
cards, generated large STL meshes, and duplicate ZIP bundles are excluded
from Git. See [mechanical assets](docs/MECHANICAL-ASSETS.md) to rebuild the mesh.
Nothing is deleted from the local workspace by these exclusions.

## Reproduce the firmware

Install Python 3 and Arduino CLI, then run from `dragon-firmware`:

```sh
python tools/dev.py setup
python tools/dev.py build
python tools/dev.py ports
python tools/dev.py upload --port YOUR_PORT
```

Use the actual detected port, not a port copied from a test log. Close serial
monitors before uploading. Build uses Arduino-ESP32 3.2.1, Adafruit NeoPixel
1.12.5, 4 MB flash, 2 MB PSRAM and the supplied custom partitions.

The build regenerates palette and embedded-page headers. Keep
`DragonPrototype/build_opt.h`: its network-event locking fixed a reproduced
startup crash in this pinned core. Full instructions and tests are in
[DEVELOPMENT.md](docs/DEVELOPMENT.md).

## Provenance

See [asset and dependency notes](docs/PROVENANCE.md). No blanket licence is
being applied to supplied character palettes, artwork, or third-party CAD
symbols. Their existing notices and provenance are retained.
