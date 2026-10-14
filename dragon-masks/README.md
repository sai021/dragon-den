# Dragon lightbox masks — revision 2

These are aligned design masks for a 65 × 65 mm face and PCB. They are not a finished divider STL, a validated PCB drawing, or a measured optical calibration. The masks supersede the earlier provisional LED allocation.

## Alignment and polarity

All numbered square PNG masks are 1950 × 1950 pixels: 30 pixels/mm, or approximately 0.0333 mm/pixel. Set physical width AND height to 65 mm when importing. Origin is the top-left PCB corner. Every layer is shown from the FRONT, looking toward the LEDs. Do not mirror one mask independently. If a CAD workflow needs a rear view, mirror the entire registered stack together. No labels or extra margins appear in the machine-input masks.

| File | Meaning |
|---|---|
| 01-led-package-mask.png / .svg | White = nominal 5 × 5 mm LED package footprints; black = remaining board. Centres inferred from the supplied photo, not measured. |
| 01-board-photo-reference.png | Cropped, approximately rectified original board photograph. Not a manufacturing mask. |
| 02-led-side-partition-mask.png / .svg | Black = proposed divider material; white = open chambers. 1.2 mm internal wall footprints; perimeter housing sits outside this canvas. |
| 03-lithophane-side-partition-mask.png / .svg | Black = divider contact footprints; white = openings. 0.8 mm internal contacts; perimeter housing sits outside this canvas. SVG is a dimensioned wrapper around the binary raster, not traced CAD contours. |
| 04-dragon-lithophane-input-white-is-thin.png | The actual grayscale input for a lithophane generator: white = 0.2 mm, black = 2.0 mm. |
| 05-minimum-0p2mm-highlight-mask.png | White selects the deliberately thinnest windows; black means not selected. |
| 06-black-eye-material-mask.png | White selects opaque black eye details, including dark outlines within the eye areas; black means not selected. Catchlights are excluded. This is a material/paint selection, not a thickness map. |
| 07-dragon-silhouette-mask.png | White selects the dragon; black selects background. Hand-traced silhouette. |
| 08-front-zone-reference.png | Colour zones for orientation; not lithophane input. |
| 09-thickness-test-strip.png | Separate 48 × 12 mm calibration input, six bands left to right: 0.2, 0.4, 0.6, 0.8, 1.2, 2.0 mm. Same grayscale conversion as file 04. |
| 10-shaded-art-reference.png | AI-shaded visual reference, registered to the square canvas; NOT the calibrated thickness input. Use file 04 for generation. |

## Lithophane generator settings

Use file 04 with a flat panel, 65 × 65 mm, minimum thickness 0.2 mm and maximum thickness 2.0 mm. White must be thinnest. Disable auto contrast, gamma adjustment, image enhancement and cropping. For a linear generator, thickness_mm = 2.0 - 1.8 × gray/255. The supplied CSV gives the full 8-bit lookup table. Check the generator preview: the white leading-edge windows must be 0.2 mm and black eyes 2.0 mm. A generator that imposes a higher minimum or nonlinear tonal mapping needs different settings; the PNG alone cannot guarantee dimensions.

The bright windows include wing leading edges, selected horn and forehead highlights, selected belly/claw highlights, eye catchlights and the tail-tip centre. The lithophane is at least 0.8 mm thick over divider contact strips. Thus the entire leading-edge band is not 0.2 mm: only its exposed windows are. Tapered tips may close where walls meet.

The black pixels in file 04 produce thick WHITE material; they do not print black automatically. For opaque eyes, use file 06 for black material assignment in a multi-material model, or paint the corresponding eye regions. A two-material model has not been generated here.

## P1S / 0.4 mm nozzle starting approach

Print the flat visible face against the bed, with thickness variation on the rear. This places the 0.2 mm dimension in Z, so it does not require a 0.2 mm nozzle. A 0.2 mm first layer makes a 0.2 mm window only ONE layer; verify that the slicer actually retains it. Use a smooth build surface and a calibrated first layer. A finer compatible nozzle can improve tiny XY details at this 65 mm scale; it does not solve weak diffusion by itself.

Use solid material through the face (sufficient solid layers / 100% infill), no ironing for the first thin-window test, and a PLA profile appropriate to the chosen filament. First try a supported sample and let it cool before removal. The 0.2 mm windows are deliberately experimental: they may show lines, pinholes, LED hotspots, or tear during removal. The mask follows the requested minimum; it is not a claim that 0.2 mm is optically or mechanically optimal.

## Partitions and optical gap

Rear walls are 1.2 mm footprints; front contacts narrow to 0.8 mm to leave room in the leading-edge chambers. The external housing perimeter is omitted from both masks: it must sit outside the 65 mm board footprint because an inward 1.2 mm rim would overlap edge LED packages. The final enclosure therefore needs additional width and board clearance; do not interpret the mask edge as a wall footprint. CAD must connect these footprints over a nominal 12 mm optical gap without walls crossing LEDs or each other. Wall height must follow the actual rear thickness surface. These two end masks cannot simply be extruded independently or automatically lofted as whole images.

The rear mask deliberately does NOT cut around capacitors, resistors, mounting holes or connectors: their heights and exact positions have not been measured. Add component reliefs or a standoff/sealing arrangement in CAD. The front zones are hand-traced from the artwork. Small source-to-front discrepancies and narrow openings need review before fabrication.

Revision 2 assigns top-row columns 4 and 5 to the central background pocket instead of the horns. Each horn now has one LED (row 2, columns 3 and 6). Background = 10 LEDs, left leading edge = 4, right leading edge = 4, left wing membrane = 9, right wing membrane = 10, face = 10, body = 10, tail = 5, left horn = 1, right horn = 1. Total = 64. Physical row/column positions are not WS2812 electrical indices. Background pockets may be separate chambers with shared software colour control; each pocket's actual light access still needs checking.

## Filament choice

My first prototype choice is **Bambu Lab PLA Basic Jade White, 1.75 mm**. Bambu explicitly lists it in its lithophane workflow, making it a practical supported starting material for this P1S. Only the white spool is needed; colour comes from the RGB LEDs, not printed CMY layers. This is a recommendation for testing, not evidence that it has the best measured RGB diffusion. [Bambu lithophane product/workflow](https://bambulab-us.myshopify.com/products/pla-cmyk-lithophane)

A purpose-made alternative is **AzureFilm PLA Lumos Litho White, 1.75 mm**. The manufacturer identifies it specifically as a light-transmitting white for lithophanes and specifies 200–230°C printing with a 60°C bed as general starting guidance. Choose **Litho White**, not the separate glow-in-the-dark white in the same range. [AzureFilm product](https://azurefilm.com/product/pla-lumos-filament-litho-white/)

**eSUN PLA+ CMYK White** is another candidate. eSUN identifies white as one of the four filaments in its optical colour-layering system. That supports its use for backlit work, but does not establish its spectral neutrality or RGB diffusion at 0.2 mm. [eSUN product](https://www.esun3d.com/cmyk-product)

I did not find comparable manufacturer measurements of haze and red/green/blue transmission versus thickness for these exact products. More transmission is not the same as more diffusion: a very thin film can be bright yet reveal LED hotspots. Do not select by a white colour name or a displayed colour hex code alone. Natural/clear filament is not my first choice for the desired white appearance and softened light. Avoid tinted, silk, glitter or glow materials for this initial colour-calibration test.

Print file 09 in the same orientation as the face and test it 12 mm above this matrix under red, green, blue and white at fixed brightness. Compare hotspot visibility, transmitted colour and handling strength. Choose the thinnest sample with acceptable diffusion; if that is above 0.2 mm, increase only the highlight thickness or use additional local diffusion inside the corresponding chamber.

Research checked 8 September 2026. Product availability and prices were not used to rank optical performance.

## How the artwork was made

The built-in image-generation tool supplied a soft grayscale tonal reference. The final generator input preserves the original drawing's line positions, uses the existing registered zone shapes, and applies the explicit thickness mapping and highlight masks. The generated reference only contributes a small tonal variation; it does not define mask boundaries. Its prompt is saved in image-generation-prompt.txt.
