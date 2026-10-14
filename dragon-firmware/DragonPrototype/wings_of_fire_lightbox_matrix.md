# Wings of Fire - 8x8 Lightbox Matrix Hardware Specification Blueprint

This technical handbook guides the deployment of the Antigravity GUI configuration loop layer over physical addressable WS2812B pixel arrays.

# Wings of Fire - 8x8 Lightbox Matrix Hardware Specification Blueprint

This technical handbook guides the deployment of the Antigravity GUI configuration loop layer over physical addressable WS2812B pixel arrays.

## 📐 Corrected 8-Zone Physical Layout Grid Topography
```
Row 1 -> [ LW,  LW,  LW,  LW,  RW,  RW,  RW,  RW ]
Row 2 -> [ LW,  LW,  LH,  FA,  FA,  RH,  RW,  RW ]
Row 3 -> [ LW,  LW,  FA,  FA,  FA,  FA,  RW,  RW ]
Row 4 -> [ LW,  LW,  FA,  FA,  FA,  FA,  RW,  RW ]
Row 5 -> [ LW,  LW,  LW,  BO,  BO,  RW,  RW,  RW ]
Row 6 -> [ LW,  LW,  BO,  BO,  BO,  BO,  RW,  RW ]
Row 7 -> [ BG,  TA,  BO,  BO,  BO,  BO,  RW,  BG ]
Row 8 -> [ BG,  TA,  TA,  TA,  TA,  BG,  BG,  BG ]
```

## 📋 Physical Allocation Ratios Per Controller Channel (64 Total Pixels)
* **LW (Left Wing Unified Edge & Membrane):** 15 Addressable Pixels (Row 1 Pixels 0-3, Row 2 Pixels 8-9, Rows 3-4 Pixels 16-17 & 24-25, Row 5 Pixels 32-34, Row 6 Pixels 40-41)
* **RW (Right Wing Unified Edge & Membrane):** 16 Addressable Pixels (Row 1 Pixels 4-7, Row 2 Pixels 14-15, Rows 3-4 Pixels 22-23 & 30-31, Row 5 Pixels 37-39, Row 6 Pixels 46-47, Row 7 Pixel 54)
* **LH (Left Horn):** 1 Addressable Pixel (Located precisely at flat array index 10)
* **RH (Right Horn):** 1 Addressable Pixel (Located precisely at flat array index 13)
* **FA (Central Face Plate Area):** 10 Addressable Pixels (Row 2 Pixels 11-12, Rows 3-4 Pixels 18-21 & 26-29)
* **BO (Internal Body Main Core):** 10 Addressable Pixels (Row 5 Pixels 35-36, Row 6 Pixels 42-45, Row 7 Pixels 50-53)
* **TA (Prehensile Tail Strip Section):** 5 Addressable Pixels (Row 7 Pixel 49, Row 8 Pixels 57-60)
* **BG (Ambient Lighting Background):** 6 Addressable Pixels (Row 7 Pixels 48 & 55, Row 8 Pixels 56 & 61-63)

## 🛠️ Low-Brightness Purple Guard Specification
To maximize physical panel clarity, true zero-voltage dark parameters across scales are compiled as low-brightness dark violet (`#3A0F5C|75`). This maintains clean artistic definition without dead grid sectors.

