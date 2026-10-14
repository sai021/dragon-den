# Profiles and custom dragons — 15 October 2026

Dragon Den now supports four local profiles and eight custom dragons shared
across the device. The supplied 81 dragons remain unchanged and available to
the protected All profile. Custom dragons belong to their creator's active
profile and can also be chosen as favourites in another profile.

## Using the phone interface

Refresh the Dragon Den page after updating firmware. Use **My profile** to
switch. Open **My favourites & starting glow** to name a profile, create another,
choose startup glow, and select up to twelve favourites. Favourites retain the
order in which you check them. Uncheck and recheck a dragon to move it to the end.
Named profiles show only their saved favourites plus their own creations in
My dragon. Physical taps cycle through that same collection: favourites first,
followed by the profile's other creations. An empty named profile invites you
to add favourites or make a dragon; it does not show the whole catalog.
The editor's Start from list and favourite picker retain the complete catalog.

All includes every supplied and custom dragon, and cannot be renamed or deleted.
The previous Family profile becomes All, retaining creations and saved glow,
and clearing its old favourite restriction so it represents the full library.
The active profile and its startup preferences survive unplugging. Temporary
effect and brightness changes do not write profile preferences automatically.

Select a starting dragon and tap **Make a dragon**. Tap a region in the 8×8
picture, or select a part by name. Wing edges and interiors are separate. Choose
a colour, give that part an effect, and name the dragon. Regions you leave alone
retain their imported per-pixel colours, including stripes and off pixels.
Existing mixed effects are retained until explicitly changed for that region.

The preview shows the base colours at the actual 64 logical pixels. It is a
static preview; physical brightness also depends on power, ambient light and
the touch setting. Changes reach the physical dragon when you save. Cancel
discards the draft without changing the device. Editing a supplied dragon
always creates a custom copy. Editing a creation can replace it or save a new
copy. Delete asks for confirmation and removes it from favourites too. Supplied
dragons cannot be deleted. Switching profiles with a draft asks before discarding.

Delete this profile removes a named profile after confirmation. Its creations
move to All, the profile space becomes available, and deleting the active
profile selects All. The device API also rejects deletion of profile zero.
A creation's owner can edit/delete it; another profile can use it as a
favourite or save an edited copy.

Profile glow is saved in 10% steps from 10–100%. The 400 mA computer-USB ceiling,
ambient automation and channel limiting still apply. Colours and effects cannot
raise the startup power ceiling.

## Storage and limits

`DragonLibrary.h` stores pointer-free records in the separate `dragon-library`
NVS namespace. Two versioned snapshots include generations and checksums.
Explicit saves write and verify the alternate snapshot before updating RAM.
On boot, the latest valid snapshot is used; a damaged newest snapshot falls
back to the previous valid one. With neither valid, the built-in All profile
and supplied catalog remain available. Wi-Fi credentials, light calibration
and diagnostic history keep their existing namespaces.

Creation capacity is eight across all profiles. Existing creations can be
edited in place or deleted to make room. There is no export/import backup interface in this version. Snapshot recovery is not an
external backup. IDs depend on the supplied catalog order; catalog replacement
or reordering needs a migration before existing saved creations are carried over.

## Verification

Native tests check unchanged pixels, region colour overrides, region effects,
profile ownership, ordered favourites, saved-state reload, failed writes,
corrupted newest snapshots and deletion. Existing renderer, touch, startup,
power and connection-policy tests remain part of the checks.

Headless phone-browser tests use simulated device responses and cover editing,
saving, favourites, profile switching, reload and deletion in addition to the
Wi-Fi/play flows. They do not establish physical phone provisioning or actual
ESP32 NVS persistence. Check those by creating a dragon on the phone, choosing
it as the first favourite, unplugging/replugging using laptop USB alone, and
confirming the chosen profile/dragon returns. Keep external power disconnected
during this laptop test.
