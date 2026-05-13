# CONTEXT.md — RaBbLE-Aether

```
epoch: 0 | status: stub
```

RaBbLE-Aether is the visual design system and canonical asset library for the RaBbLE Collective.

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

## Active Tracks

| Track | Status |
|---|---|
| Repo structure established | **Done** — `assets/{palette,logos,icons,ansi,motion,components}/` |
| Palette tokens published from Grimoire | **Done** — CSS, JSON, SCSS in `assets/palette/` |
| Motion / keyframe library | **Done** — `assets/motion/rabble-motion.css` |
| Unified component library | **Done** — `assets/components/rabble-components.css` |
| Portal glyph SVG (neon) | **Done** — `assets/logos/rabble-portal-glyphs.svg` |
| Eye anatomy specification | **Done** — `assets/logos/rabble-portal-glyphs-spec.md` |
| Claude Design guide | **Done** — `CLAUDE-DESIGN-GUIDE.md` |
| Xperimental distillation | **Done** — `assets/reference/xperimental-distillation.md` |
| Eye spec — portal expression system | **Done** — eyebrow opposition mechanic added |
| Icon assets populated | Pending — icons/, ansi/ stubs exist |
| Member repos updated to reference Aether | Pending |

## Reading Order for a New Session

1. This file — you are here
2. `AGENT.md` — rules and workspace map
3. `../RaBbLE-Grimoire/common/RaBbLE-Palette.md` — the palette
4. `../RaBbLE-Grimoire/RaBbLE-Aether/RaBbLE-Aether-Architecture.md` — design system spec
5. For Collective context → `../RaBbLE-Grimoire/common/RaBbLE-Collective.md`
