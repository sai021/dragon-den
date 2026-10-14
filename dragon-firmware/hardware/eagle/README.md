# Dragon lamp PCB interface schematic

J1 is an eight-pin 2.54 mm female socket for the ESP32 row, following the supplied order. The square pad is pin 1 (5V). Check socket orientation against the board before soldering.

| Connector | Pin order |
| --- | --- |
| J1 ESP32 socket | 1=5V, 2=GND, 3=3V3, 4=GPIO13 (unused), 5=GPIO12 matrix, 6=GPIO11 touch, 7=GPIO10 voltage, 8=GPIO9 LDR |
| J2 remote matrix | 1=5V, 2=GND, 3=DIN |
| J3 remote TTP223 | 1=3V3, 2=GND, 3=OUT |
| J4 remote USB-C power board | 1=VBUS/5V, 2=GND |
| J5 remote LDR | 1=3V3, 2=GPIO9 |

The LDR, touch sensor, LED matrix, USB-C board and electrolytic capacitor are off the PCB. The 1000uF electrolytic is installed across VBUS/GND at the USB-C board, with correct polarity; no PCB footprint is reserved for it. Its supplied dimensions are 8 mm diameter and 16.5 mm height.

R1=330R LED data series resistor. R3=10k LDR pulldown. R4=100k and R5=20k form the supply divider. All four use upright resistor footprints with 2.54 mm lead spacing and an assumed 2.5 mm body diameter. This is lead spacing, not total occupied width; allow body and bent-lead clearance in layout.

C2=100nF PCB touch-supply bypass. Keep a 100nF bypass near the remote TTP223 supply pins as well. C3=optional 100nF LDR filter. C4=100nF voltage-divider filter. Ceramic footprints use 5.00 mm lead spacing and an assumed 5 x 2.5 mm body envelope. Check the actual capacitor bodies before placement.

EAGLE packages are embedded with explicit pin-to-pad mappings. All module interfaces use 2.54 mm through-hole connectors; J1 accepts a matching single-row female socket. Header holes are 1.0 mm, discrete holes 0.9 mm, pad diameters 1.8 mm. J2-J5 pin order defines the wiring harness, not the physical module pin order.

Validation: 12 parts, 32 physical pins/pads, 31 connected pins and one intentionally unused GPIO13 pad; eight nets checked for continuity and unintended endpoint contacts. All EAGLE pin coordinates and net memberships match the KiCad source. Native application import/ERC/DRC has not been run. Preview.svg is generated from the source symbol geometry, not a native CAD screenshot. This is a schematic with packages, not a routed or fabrication-ready PCB. KiCad source symbols remain without footprint assignments; packages are assigned in the EAGLE export.

Use PC USB OR external 5V unless powered sources are isolated. All grounds are common. The USB-C breakout retains its existing CC resistors. Direct 3.3V LED data follows the prototype; logic-level requirements depend on the matrix variant.

Symbol geometry is from official KiCad 8 libraries; see LICENSE.txt.

Import compatibility revision: import hardware/Dragon-Lamp-EasyEDA-Import.zip as an EAGLE project. It contains matching Dragon-Lamp.sch and Dragon-Lamp.brd; the board includes all physical packages and identical signal assignments. Device variants now have explicit -THT names and proper R/C/J prefixes. Dragon-Parts.lbr is also supplied separately in the full archive. The PCB is an unrouted, spaced collection of components without a board outline, not a finished layout. This revision is a compatibility workaround; EasyEDA import is not yet verified. The J1.4 X in EAGLE is graphical only: in EasyEDA place a native No Connect flag on J1.4 (unused GPIO13). Do not connect that pad to ground. If missing-footprint errors persist, export the imported EasyEDA project so its internal IDs and footprint bindings can be inspected.
