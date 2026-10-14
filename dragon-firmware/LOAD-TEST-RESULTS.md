> Historical manual load tests. The current startup calibration and installed firmware results are in TEST-RESULTS.md.

# Supply load test — 2026-09-18

Loads below are firmware estimates (LED channel model plus 200 mA controller reserve), not measured current. No current sensor or electronic load was used.

| Estimated total load | Divider voltage | Multimeter voltage | Result |
| --- | --- | --- | --- |
| 500 mA | Mean 5.019 V; range 5.002–5.041 V | 5.00 V | Initial holding sample passed |
| 1 A | Initial mean 4.963 V; range 4.940–4.968 V | Not obtained | Subsequently aborted by latched invalid-voltage fault |
| 2 A | — | — | Deferred pending fault diagnosis |
| 3 A | — | — | Deferred pending fault diagnosis |

The fault means a median ADC-derived supply reading was nonfinite, below 3 V, or above 6 V. The triggering value was not retained, so this does not establish charger overload. At attempted restart, voltage was around 5.02 V but fault=1 and gain=0. The earlier timeout explanation was corrected after reading board status.

Diagnostic mode used steady white output, a two-second ramp, a 90-second timeout, and an abort for filtered voltage below 4.75 V or unhealthy voltage monitoring. It is compiled only with DRAGON_LOAD_TEST=1; saved normal current settings were not raised. Host tests cover target estimates, ramp, timeout, abort, and return to normal rendering.

Restored the normal calibrated firmware from build on COM17; upload hashes verified. Post-restore readings averaged 5.009 V (4.996–5.025 V), fault=0, sag=0, gain=100, fixed_limit=500mA. Diagnostic commands are absent from this normal binary.

Logs are in .tools/load-500-hold.log and .tools/load-0-hold.log. The original 1 A summary above was captured before the retry overwrote .tools/load-1000-hold.log; that file now records the rejected retry and latched fault.

## Repeat after user reported LDR disconnected

Disabled automatic light control via `auto off`: the disconnected input was floating and cannot provide useful ambient control. This can explain ambient shutoffs but does not explain the earlier separate voltage fault.

Added first-fault voltage and uptime retention to VoltageGuard plus serial diagnostics; host voltage tests passed, including preservation of the first fault through subsequent readings. Uploaded diagnostic build 393328 bytes, hash verified, and disabled automatic light control again after reset.

Repeated 1 A estimated step: initial divider mean 4.904 V, range 4.878–4.929 V. It completed its 90-second window without a voltage fault and returned to normal output. Filtered range across the holding period was 4.882–5.001 V. Meter reading is still pending. Current .tools/load-1000-hold.log now contains this successful repeat, with followup and final-status logs alongside it.

Current device state: diagnostic firmware installed, load inactive after timeout, normal estimated ceiling 500 mA, auto=0, fault=0. Auto off is session-only and must be reapplied after restart while the LDR remains disconnected. The 2 A and 3 A steps remain pending; restore normal firmware after completing testing.
