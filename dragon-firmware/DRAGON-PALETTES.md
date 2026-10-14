# Dragon catalog and editor

The active library contains all **81 dragons** from `DragonPrototype/wings_of_fire_lightbox_matrix.csv`, in file order, with Blue as the startup default. The supplied CSV and Markdown are preserved unchanged. The CSV's 64 `#RRGGBB|intensity` values are imported as row-major pixel colours, with intensity multiplied into RGB; striped and split-colour regions retain individual pixels.

The Markdown calls for purple replacements for dark pixels, but the CSV explicitly contains off pixels as well as purple ones. The import follows the explicit CSV values: zeros stay off in the base image and supplied purple pixels are retained. Animated regions may change from their base colours.

At the user's request, wing edges remain separate from wing interiors. LE/RE are edge IDs (not eyes). Four pixels per edge use a 20% lighter tint of their wing colour, respecting the source intensity. The remaining layout follows the supplied grid: 6 background, 4 left edge, 4 right edge, 1 left horn, 1 right horn, 10 face, 10 body, 5 tail, 11 left wing and 12 right wing pixels.

Natural-language effect descriptions are interpreted using the existing bounded animation engine: breathing/pulse/fade → breathe; shimmer/flicker/flare/glare/wave → shimmer; sparkle → glitter; other colour shifts → cycle. Fast descriptions use a two-second period; others six seconds. These are visual interpretations, not literal simulations of each narrative effect. Mixed descriptions preserve separate masks per effect (for example Sunny's face/body breathe while wings glitter). Wing effects include the corresponding edges; colour editing remains independent.

`presets/dragons.json` is the editable source. `tools/palettes.py generate` generates `DragonPrototype/DragonPresets.h`. `tools/dev.py build` and `upload` regenerate automatically. To import a replacement CSV, run `python tools/import_matrix.py`; this deliberately replaces the editable catalog, so back up manual edits first.

Open `Edit-Dragon-Colours.cmd` or `python tools/palettes.py gui`. Edit **Edges** separately from **Wings**, select effects, preview the actual 64-pixel base pattern, save, then build/upload. Changing a group colour overrides imported pixel variations for that group; unchanged groups retain their striped maps. `reference_zones` keeps the original group colours for this comparison. `effect_zones` preserves per-effect region selection; the editor's animation checkboxes apply an additional shared mask.

CLI commands remain available: `python tools/palettes.py list`, `edit ID`, `clone ID NEW_ID`, `default ID`, `generate`, `check`. The catalog supports up to 255 presets. Serial commands `dragons`, `dragon ID`, and `palette INDEX` select installed dragons; a single tap advances through them.

Every effect and pixel adjustment is followed by channel and session current limiting, then light and touch percentages. Startup uses the white row indicator rather than a dragon palette.
