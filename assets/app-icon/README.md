# Lightbox app icon

The High Turtle mark (a smiling turtle) in paper white, centred on a full-bleed ink tile.

## Palette (exactly two colours)

| Colour | Hex | Used for |
|---|---|---|
| Ink | `#17181a` | the full-bleed tile |
| Paper | `#f6f6f5` | the turtle |

## Geometry

`viewBox="0 0 512 512"`, a rounded-square tile with `rx=112`, clipped; the colour fills the whole tile. The mark
is scaled to 84.5 % of the mark's native 426 x 225 box and centred. macOS files (`.icns`, `lightbox-macos-512.png`)
add Apple's transparent margin (an 824/1024 body); Windows and Linux files use the full-bleed tile.

## Provenance

The turtle mark comes from the High Turtle design system (`logo.md`, asset `mark`), the project owner's own brand.
`lightbox.svg` here is the canonical artwork; the mark's path is embedded unchanged apart from the fill and
placement. Licence: `LICENSE.txt` (MIT OR Apache-2.0, like the repo).

## Files

| File | What |
|---|---|
| `lightbox.svg` | canonical vector |
| `lightbox-small.svg` | same artwork (the mark is already light, so no lighter trace is needed) |
| `lightbox-1024.png` | 1024 px render (store listings, docs) |
| `lightbox-macos-512.png` | runtime window/Dock icon on macOS (embedded by `apps/lightbox/src/main.rs`) |
| `lightbox.icns` | macOS bundle icon (`CFBundleIconFile`) |
| `lightbox.ico` | Windows icon, 16-256 px, embedded in `lightbox.exe` by `apps/lightbox/build.rs` |
| `hicolor/<n>x<n>/apps/ai.storyteller.lightbox.png` | Linux icon theme, 16-512 px; the 256 px one is also the runtime window icon on Windows and Linux |
| `hicolor/scalable/apps/ai.storyteller.lightbox.svg` | Linux scalable icon |

The app id is `ai.storyteller.lightbox`: the Wayland app id, the `.desktop` file
(`packaging/linux/ai.storyteller.lightbox.desktop`, `Icon=ai.storyteller.lightbox`) and the hicolor icon
name. To install on Linux, copy `hicolor/` into `/usr/share/icons/hicolor/` (or `~/.local/share/icons/hicolor/`)
and the `.desktop` file into `applications/`.

## Regenerate

Edit `lightbox.svg`, then run `packaging/icons.sh` (needs `resvg`; `iconutil` on macOS for the `.icns`; the `.ico`
is packed by `cargo xtask ico`). Every output is committed.
