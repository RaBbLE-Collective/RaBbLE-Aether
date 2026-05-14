# CONTEXT.md — RaBbLE-Aether

```
epoch: 0 | evolution: 0 | echo: 0 | status: scaffold → build system
version: v0.0.0 (pre-Episode-1)
```

RaBbLE-Aether is the visual design system and canonical asset library for the RaBbLE Collective. Ships as a CDN-distributed CSS bundle alongside NeBuLA.

---

## What We Are Building

A single source for all visual tokens, SVG assets, logos, and icons used across the Collective. Members import from Aether rather than maintaining their own copies. The palette lives in Grimoire's `common/RaBbLE-Palette.md`; Aether is where rendered assets (SVGs, icons) live.

## What Good Looks Like

- One import path for any visual asset — no searching across repos
- Palette variables are the only color interface; no hex values leak into member repos
- Every asset is named, versioned, and documented in the architecture doc
- A new member repo can get the full visual identity with one reference

## What to Avoid

- Copying assets into member repos — reference Aether, don't copy
- Redefining palette values — `../RaBbLE-Grimoire/common/RaBbLE-Palette.md` is the only source
- Member-specific branding here — Aether is shared Collective identity, not per-member customization
- Accumulating assets without documentation in the architecture doc

## Structure

| Path | What |
|---|---|
| `assets/` | SVGs, logos, icons — canonical visual assets |
| `../RaBbLE-Grimoire/common/RaBbLE-Palette.md` | Color palette source of truth |
| `../RaBbLE-Grimoire/RaBbLE-Aether/RaBbLE-Aether-Architecture.md` | Design system spec |

## Active Tracks (Episode 1 — build + CDN)

| Track | Status |
|---|---|
| Architecture & design spec | **Done** — `RaBbLE-Aether-Architecture.md` in Grimoire |
| Build system & CDN spec | **Done** — `RaBbLE-Aether-Build-CDN.md` documented |
| Repo structure established | **Done** — `assets/{palette,logos,icons,ansi,motion,components}/` |
| Palette tokens published from Grimoire | **Done** — CSS, JSON, SCSS in `assets/palette/` |
| Motion / keyframe library | **Done** — `assets/motion/rabble-motion.css` |
| Unified component library | **Done** — `assets/components/rabble-components.css` |
| Portal glyph SVG (neon) | **Done** — `assets/logos/rabble-portal-glyphs.svg` |
| Eye anatomy specification | **Done** — `assets/logos/rabble-portal-glyphs-spec.md` |
| Claude Design guide | **Done** — `CLAUDE-DESIGN-GUIDE.md` |
| **[Episode 1] esbuild + npm scripts** | **In Progress** — adding build system to package.json |
| **[Episode 1] dist/ output & CDN ready** | **Pending** — `npm run build` → `dist/aether.min.css` |
| **[Episode 1] Five-Es versioning** | **Ready** — v0.0.0 locked, tagged for CDN paths |
| Icon assets populated | Future |
| Member repos updated to reference Aether CDN | After Episode 1 air |

## Reading Order for a New Session

1. This file — you are here
2. `AGENT.md` — rules and workspace map
3. `../RaBbLE-Grimoire/RaBbLE-Aether/RaBbLE-Aether-Architecture.md` — design system spec
4. `../RaBbLE-Grimoire/RaBbLE-Aether/RaBbLE-Aether-Build-CDN.md` — build system + CDN usage
5. `../RaBbLE-Grimoire/common/RaBbLE-Palette.md` — the palette (canonical source)
6. For Collective context → `../RaBbLE-Grimoire/common/RaBbLE-Collective.md`

## Build & Distribution

**Build system:** esbuild (CSS bundler)  
**Output:** `dist/aether.min.css` + sourcemap  
**CDN versioning:** Five-Es (`v0.0.0` pre-Episode-1, `v0.0.0.1` after air)  
**See:** `../RaBbLE-Grimoire/RaBbLE-Aether/RaBbLE-Aether-Build-CDN.md`

## Scripts

```bash
npm run build         # Minified production build
npm run build:dev    # With sourcemaps, unminified
npm run build:watch  # Watch mode for development
```
