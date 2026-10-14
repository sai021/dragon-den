# Dragon PCB Gerber review — 20 September 2026

Verdict: No copper connectivity defect found. Conditional release only: finish component-value/physical-fit verification and resolve the close 5V edge clearance before V-scored panelisation. The submitted fabrication files were not modified.

## Files and method

Reviewed Gerber_PCB1_1_2026-09-20.zip: top/bottom copper, solder masks, silkscreens, board outline, plated drills and FlyingProbeTesting.json. Independently reconstructed Gerber C/R flashes and linear tracks as copper geometry, connected top/bottom copper through the 30 plated holes, compared resulting islands against the exported netlist, and compared component topology to DragonPrototype/Config.h and the agreed circuit. Duplicate test-point entries were deduplicated by named component pin; these are not extra physical holes. This is an independent geometric check, not native EasyEDA ERC/DRC or a powered test. No BOM or current schematic was supplied.

## Passed checks

- 30 physical plated holes and named component pins. Eight working nets plus one isolated unused GPIO13 net. No opens or shorts found in reconstructed copper.
- J1 pins 1–8: 5V, GND, 3V3, unused GPIO13, GPIO12, GPIO11, GPIO10, GPIO9. All 2.54 mm spacing; 1.10 mm drills. Matches supplied physical pin sequence and current source firmware.
- GPIO12 feeds R1 then the matrix DIN exit. No GPIO directly connected to 5V.
- R4 connects 5V to GPIO10; R5 connects GPIO10 to GND; C4 filters GPIO10 to GND.
- R3 connects GPIO9 to GND; C3 filters GPIO9 to GND. External LDR must connect 3V3 to GPIO9.
- TTP223 exits provide 3V3, GPIO11 and GND.
- Matrix 5V and GND links are 2.0 mm wide, entirely top copper, with no narrow routing vias. Approximate centreline lengths 10.10 mm (5V) and 12.70 mm (GND). On 1 oz copper these short tracks are reasonable for the agreed 3 A target. Pad barrels, off-board wires and contacts still require appropriate ratings.
- Other tracks are 0.254 mm (10 mil). The thin ESP32 branch does not carry the matrix current when power enters the external power pads.
- Minimum different-net copper gap approximately 0.230 mm bottom / 0.243 mm top. Minimum nominal annular ring approximately 0.300 mm. These exceed common PCBWay standard 1 oz track-spacing and annular-ring requirements; factory review remains authoritative.
- All 30 pad locations have solder-mask openings on both sides; no opening exposes another net's copper. No hidden copper pour.
- Board outline is a single closed rectangle: X=27.94 mm, Y=24.13 mm. The previous stated height/width were reversed relative to this Gerber orientation. No panel copies or V-score lines are included.

## Resolve before manufacture / assembly

1. The outer edge of the wide 5V U-shaped track is only 0.29972 mm from the adjacent board edge. Do not assume this is suitable for V-scoring. Ask PCBWay to approve that exact clearance for the intended thickness and scoring process, or increase it to about 0.6 mm. Extending that board edge outward by roughly 0.3 mm is one simple option if the enclosure permits; re-export and re-check dimensions/panel spacing afterward. This is a manufacturing margin concern, not an existing short. PCBWay's V-scoring reference: https://www.pcbway.com/pcb_prototype/PCB_V_Scoring.html
2. Gerbers/test netlist do NOT establish component values. Required values: R1=330 ohm, R3=10k, R4=100k, R5=20k, C3=100nF optional LDR filter, C4=100nF voltage filter. If R4/R5 are reversed, GPIO10 rises to about 4.17V at 5V input instead of 0.833V. Use the annotated map, not nearby text alone.
3. Silkscreen is misleading in places: R3 is printed near R4's body, the actual R3 position lacks a nearby clear label, and some references overlap mask openings and may be clipped by fabrication. No printed wire-function labels exist. Move references to the correct bodies and label the exit holes. The annotated assembly map gives the electrical assignments.
4. Footprints now have R1 pitch 10.30 mm; R3/R4/R5 approximately 10.50 mm. These are horizontal-resistor footprints, not the previously requested 2.54 mm upright footprints. They can work with the intended axial parts if leads reach; verify actual lead lengths/body clearance. C3/C4 pitch is 5.00 mm. Socket pitch is 2.54 mm but actual socket/body/ESP32 underside clearance and mounting orientation cannot be established from Gerbers. Place the real board over a 1:1 print to check fit.
5. No onboard C2 touch bypass is present. Retain 100nF across VCC/GND at the remote TTP223. The 1000uF bulk capacitor remains off-board on the USB-C power board as agreed; no capacitor footprint is expected here.
6. Matrix DIN remains a direct 3.3V GPIO signal through R1, with no 5V logic buffer. It follows the working prototype, but compatibility across different LED variants is not guaranteed by this PCB. Retest with the actual matrix/cable. The PCB does not contain power-source isolation or a hardware current limiter: avoid simultaneously feeding unisolated external 5V and PC USB.
7. Current firmware source still has DEFAULT_MAX_TOTAL_MA=2400. The discussion about 3 A did not change firmware. No firmware was modified in this review.

## External connection row J4 — viewed from TOP, square pad first

| Hole | Connection |
|---|---|
| 1 | External power +5V |
| 2 | External power GND |
| 3 | Matrix +5V |
| 4 | Matrix DIN, after R1 |
| 5 | Matrix GND |
| 6 | TTP223 3V3 |
| 7 | TTP223 OUT (GPIO11) |
| 8 | TTP223 GND |
| 9 | LDR 3V3 |
| 10 | LDR junction (GPIO9) |

J4 is marked bottom-side in the source export. Through-hole electrical connectivity works from either side, but its order reverses when viewed from below. GPIO13/J1.4 is intentionally isolated. An external LDR needs only holes 9 and 10; its pulldown R3 is already on this PCB.

## Remaining evidence needed for final release

Export the current EasyEDA project/schematic and BOM, or provide the schematic showing all values and the chosen part numbers. Run native EasyEDA DRC on the final board and panel; verify component fit with the actual ESP32/socket. This review does not certify a final panel or unprovided component values.

Artifacts: copper-review.png, manufactured-appearance.png, assembly-map.png and geometry-checks.txt. Visuals are reconstructed from the supplied Gerbers; the assembly map overlays required values, not verified BOM values. Bottom-layer images use top-view coordinates, not a flipped physical bottom view.
