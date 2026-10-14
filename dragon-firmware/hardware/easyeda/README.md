# Dragon lamp schematic for EasyEDA

Import `Dragon-Lamp.sch` using the EAGLE import option. EasyEDA Standard supports EAGLE 6+ XML via File > Open > Eagle. EasyEDA Pro also provides EAGLE under its Import menu.

This file contains embedded module symbols and 8 electrically connected named nets, not an image. Matching net labels join the short wires at the component terminals. All 33 terminals are connected and checked by `tools/export_schematic.py`. XML parsing and terminal/net consistency were verified; an actual EasyEDA import has not been performed here.

Current firmware mapping: matrix GPIO12, TTP223 OUT GPIO11, LDR junction GPIO9, voltage divider GPIO10. LDR upper element connects to 3.3V, lower resistor is 10k to GND. Supply divider upper resistor is 100k, lower resistor 20k, with 100nF to GND. TTP223 shares the ESP32 3.3V supply with the LDR and has its own 100nF supply bypass. C3 is an optional LDR ADC filter; R1 is the recommended 330-ohm matrix data resistor. C1 is polarized: 1000uF, 10V, positive terminal to 5V.

U1 represents the labelled terminals of the ESP32 development board; it is not a bare ESP32 chip or a verified physical board footprint. U2 and M1 likewise represent complete modules. J1 represents the existing USB-C breakout, including its onboard CC resistors; do not add duplicate CC resistors. No PCB footprints or board layout are supplied. Assign and verify actual module/header footprints before converting to PCB. Resistor/capacitor symbols are functional terminal blocks for this wiring schematic.

External 5V enters J1; PC USB instead enters the ESP32's existing USB connector. Use one powered source at a time unless you add verified source isolation. In external mode, branch matrix power directly from the supply rather than routing matrix current through the ESP32 board. In PC mode, verify that the board's 5V/VBUS terminal supplies the shared rail. Ground is common throughout.

USB host detection works through the ESP32 native USB data connection. A PC plugged into the power-only breakout (D+/D- unconnected), or through a charge-only cable, cannot be automatically identified. The firmware's 400mA value is an estimated total budget, not a hardware current limiter.

Direct GPIO12 to DIN matches the prototype. The exact LED variant is unverified; add a suitable 5V-powered 74AHCT125 level shifter if required for reliable 3.3V logic reception. No level shifter is included as an installed component in this schematic.

Supply junction check: 5.00V / 6 = 0.833V at GPIO10. Existing firmware ADC correction 1.0135 remains provisional for the new board.

Official import instructions:
- https://docs.easyeda.com/en/Import/Import-Eagle/
- https://prodocs.easyeda.com/en/import-export/import-eagle/
