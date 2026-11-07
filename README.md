# Mahonemotes – Emote Wheel

Radial emote menu for World of Warcraft: Forever. Hold a key, flick the mouse, release to emote.
12 slots per page, rotate clockwise past 12 o'clock (or use the mouse wheel) for the next page.

Download: CurseForge (link follows after approval).

## Development
- `lua5.1 tests/spiral_test.lua` – tests for the wheel logic
- `./package.sh` – local zip in `dist/`
- Release: bump `CHANGELOG.md`, then `git tag vX.Y.Z && git push --tags` – GitHub Actions builds and uploads via the BigWigs packager.

License: MIT
