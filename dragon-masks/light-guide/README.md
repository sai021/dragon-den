# Dragon light-guide prototype

Open `dragon-light-guide-prototype.stl` in millimetres, at 100% scale. This is the opaque chamber divider between the LED board and the lithophane, with an external perimeter wall. It does not include the lithophane, PCB holder, lid, fasteners, or electronics.

## Geometry

- Registered to the supplied 65 × 65 mm masks. The dragon is viewed from the front, matching the source files.
- Rear partition footprint comes from mask 02; front contact footprint comes from mask 03. Tiny raster pores smaller than 0.3 mm² are filled.
- Ten named lighting zones. Background can occupy more than one connected pocket.
- Straight 1.5 mm rear collar, then a transition between corresponding zone distance fields. Interior wall targets taper from 1.2 mm to 0.8 mm in horizontal sections. This does not guarantee the same thickness measured normal to sloped walls.
- The lithophane visible face is nominally at z=14 mm. Its back is `14 - thickness_mm`, using the supplied linear 0.2–2.0 mm grayscale mapping. Thus 12 mm is the nominal minimum PCB-plane-to-lithophane-back distance, not a measured distance above the LED lens.
- Top contacts follow that back surface. The outer wall continues the edge height outside the 65 mm face and is approximately 1.2 mm thick. It is an optical perimeter, not a dimensioned enclosure fit or face-retaining lip.
- Geometry is sampled at 0.1 mm. Marching-cubes surfaces have approximately half-sample edge offsets. The exported base is translated to z=0; consult `validation.json` for exact bounds. Keep all parts registered if making a matching lithophane in CAD.

## Checks and limits

`validation.json` records mesh closure, solid count, nominal LED clearance and per-zone passage reachability. `chamber-check.json` independently flood-fills the air volume to check whether a rear zone opens into a different front zone. Checks describe the sampled geometry; they are not an optical simulation or a guarantee of printed light isolation.

The source PCB positions were inferred from a photograph. The current model assumes its base can meet the PCB plane. Capacitor/resistor heights, LED height, board tolerances, connectors and mounting holes have not been measured. Check these before printing a fitted assembly; add local relief or a measured sealing arrangement where required. Raising the entire divider without sealing beneath its walls will connect the lighting zones.

Use opaque material for this divider and white transmitting material for the separate lithophane. Keep the broad LED-side base on the bed when reviewing the initial print orientation. Inspect the layer preview for unsupported wall slopes, narrow passages and support removal access before committing to a print. No slicer or physical print validation has been performed. Thin front contacts may need a compliant opaque seal to accommodate real print tolerances.

## Files

- `dragon-light-guide-prototype.stl`: full-resolution closed-surface mesh; intentionally large to preserve the contacts.
- `preview.png`: illustrative views from the dragon and LED sides; display mesh is simplified.
- `sections.png`: aligned cross sections through the transition.
- `geometry-grid.npz`: sampled geometry for reproducible passage checks.
- `build_light_guide.py`: regenerate geometry from the original masks.
- `check_and_preview.py`: passage isolation checks and preview generation.

Rebuild with Python plus numpy, Pillow, scipy, scikit-image, trimesh, fast-simplification and matplotlib. Run the build script first and wait for it to finish, then run the check/preview script. The latter's simplified geometry is used only for illustration, never for the delivered STL.
