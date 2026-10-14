# Dragon hardware power context

User-confirmed on 14 October 2026:

- Development testing uses laptop USB-C into the ESP32 USB connector to power the connected circuit. External/main power is disconnected.
- Never connect laptop USB power and external/main power simultaneously in the current wiring.
- Retain the 400 mA estimated session ceiling when a computer USB host is detected. Do not increase it to demonstrate brighter web effects.
- In the deployed product, the ESP32 is inside the enclosure. The matrix receives power directly from the product's external supply and shared rail; the ESP32 board/USB connector is not its intended power source.
- Laptop-powered tests cannot validate deployed external-supply capacity. Disconnect laptop USB before any external-only power test.
- Check the current port and live device state before uploading; board wiring and connection can change between sessions.

See HARDWARE-WIRING.md and START-HERE.md for the wiring and existing power policy.
