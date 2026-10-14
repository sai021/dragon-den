# Project checkpoint — 15 October 2026

This is the consolidated handover state for the initial GitHub repository.
Detailed historical logs remain in the firmware's dated test/review documents.

## Implemented

Touch control, 81 supplied palettes, local phone controls, Wi-Fi provisioning,
setup recovery, protected All, three named profiles, ordered favourites,
per-profile play lists, eight custom creations, region editing/effects,
creation copying/deletion, profile deletion with retained creations, ambient
dimming and startup power diagnostics are implemented.

The latest installed build is 1,117,518 bytes within the 1,572,864-byte custom
app partition. Static RAM reported by the compiler is 50,908 bytes. These
figures describe this checkpoint and will change with later work.

## Evidence

| Area | Evidence and limit |
| --- | --- |
| Supplied catalog | Existing Python import/config/editor checks passed |
| Firmware core | Native C++ suites cover layout, power, effects, sensors, startup and connection timing |
| Library | Native tests cover ownership/membership, region overrides, save/reload, checksum fallback, failed writes, deletion and protected All |
| Custom rendering | Maximum-white creations remain capped across six effects and six power ceilings; empty-profile touch isolation checked |
| Phone workflows | Headless 390×844 browser checks with simulated API responses passed play, Wi-Fi, editing, filtering and deletion flows |
| Wired prototype | USB startup windows passed at about 5.11 V; 400 mA estimated ceiling remained active; no observed panic after the fixes |
| Latest migration | Live Family became All, retaining one custom creation and generation 8 after upload |
| User feedback | User confirmed profile creation and identified the collection-filtering/deletion changes incorporated in this checkpoint |

Browser simulations do not verify the real ESP32 HTTP/NVS stack. Brief live
uptime observations do not constitute a long-duration reliability test.

## Before a family trial

1. Verify actual iPhone and Android setup, authentication, Wi-Fi scanning,
   wrong-password retry and reconnecting through home Wi-Fi.
2. Save a profile/creation through a phone; unplug/replug and verify persistence.
   Test profile deletion, shared favourites and preserved creations in All.
3. Verify the TTP223 power-on setup gesture on the actual assembled product.
4. Exercise touch while web requests and saves are in progress.
5. Measure Wi-Fi supply behaviour and validate the provisional controller budget.
6. Test the deployed supply with laptop USB disconnected, including sustained
   brightness and the intended cable. No runtime voltage sampling exists.
7. Prepare per-device setup cards; implement lost-card/reset recovery and
   parent settings protection before unsupervised distribution.

## Hardware and mechanical status

The September PCB/CAD and optical files are earlier prototypes, not the final
manufacturing release. The 21 September Gerber review retains a required R4
pad-entry routing correction and outstanding native DRC/physical-fit checks.
See its original review rather than interpreting a preview as manufacturing
approval.

The user is printing newer STL files. New meshes, making-of photographs and
updated/final Gerbers will be supplied later. They are not present in this
checkpoint and must not be inferred from the older files.

Firmware and older optical masks use different pixel-to-zone allocations.
Reconcile them against the final physical design before claiming calibrated
colour isolation. This checkpoint deliberately preserves each source.

## Development backlog

| Priority | Work |
| --- | --- |
| Next | Physical phone/persistence tests; incorporate user's finished print/CAD/photos/Gerbers |
| Before family release | Parent protection, lost-card recovery, power measurements, final assembly validation |
| Next feature | Export/import profile and creation backups with schema migration |
| Optional | Weather dragon mode, selected town/postcode, cached data and offline fallback |
| Later | Firmware update strategy, product instructions and longer reliability testing |

Weather, cloud accounts, remote control, voice/audio and OTA are not implemented.
