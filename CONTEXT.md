# CONTEXT.md — RaBbLE-Aether

```
epoch: 0 | status: active, build system live
version: 0.1.0 (Genesis; CDN path /v0.1.0/)
last session: 2026-11-11 (S324)
```

RaBbLE-Aether is the visual design system and canonical asset library for the RaBbLE Collective. Ships as a CDN-distributed CSS bundle. All member repos consume it — no local copies.

---

## What We Are Building

A single source for all visual tokens, animations, component classes, and SVG assets used across the Collective. Members load one CSS file from CDN and get the full visual identity. Palette source of truth lives in Grimoire.

## What Good Looks Like

- One CDN import gives any page the complete visual system
- Palette variables are the only color interface — no hex values leak into member repos
- Component classes cover all UI needs — members never duplicate visual rules
- `dev-serve.sh` keeps `aether.css` in sync during development

## What to Avoid

- Hex values in component rules — always use `--rabble-*` vars with fallbacks
- Member-specific styles — Aether is Collective-wide identity
- Editing `dist/` files directly — always edit source, then rebuild
- Running builds outside the dev-serve.sh workflow (causes port conflicts)

## Structure

| Path | What |
|---|---|
| `src/entry.css` | esbuild entry point — imports fonts → base → palette → motion → components → theme (5 bundled CSS files, in that order) |
| `assets/base/rabble-base.css` | Base layer — resets, html/body defaults, prose elements, brand typography |
| `assets/palette/rabble-palette.css` | All `--rabble-*` design tokens |
| `assets/motion/rabble-motion.css` | `@keyframes`, `@property`, animation utility classes |
| `assets/components/rabble-components.css` | Full component library (buttons, cards, applet tiles, etc.) |
| `assets/theme/rabble-theme.css` | Theme variants (e.g. `[data-aether="muted"]` low-glow preset) — requires palette loaded first |
| `dist/aether.css` | Dev build (built by `build:dev`/`build:watch` — what HTML pages link to) |
| `dist/aether.min.css` | Production build (built by `npm run build` — CDN/Workers deploy target) |
| `assets/logos/` | SVG assets |
| `assets/entity/` | Entity visual reference images (doc-compare, reference) |
| `RaBbLE-Entity-Visual-Spec.md` | Canonical entity visual identity spec |

**Not yet reflected here (deferred, see audit):** `rabble.css` (root) is a second, hand-maintained entry point that drifts from `src/entry.css`; `assets/palette/` also carries `.json`/`.scss` mirrors of the token source.

## Build Scripts

```bash
bash RaBbLE-Grimoire/spells/dev-serve.sh   # ← always use this for dev
npm run build:dev                           # one-shot dev build → dist/aether.css
npm run build                              # production build → dist/aether.min.css
```

**Dev file is `aether.css`. Production file is `aether.min.css`. HTML pages must link to `aether.css` in dev.**

## Active Tracks

| Track | Status |
|---|---|
| Palette tokens | **Done** — `assets/palette/rabble-palette.css` |
| Motion / keyframe library | **Done** — `assets/motion/rabble-motion.css` |
| Component library | **Done** — `assets/components/rabble-components.css` · includes `.floor`, `.horizon`, all CRT overlays |
| esbuild build system | **Done** — `npm run build`, `build:dev`, `build:watch` |
| CDN delivery via dev-serve.sh | **Done** — all World pages loading from `/aether/v0.0.0.0/aether.css` |
| Portal glyph SVG | **Done** — `assets/logos/rabble-portal-glyphs.svg` |
| Production deploy to Cloudflare Workers | **Live**: `wrangler.jsonc` (Workers static-assets site `rabble-aether`, serves all of `dist/`, every version path included). Deploy locally with `bash RaBbLE-Grimoire/spells/cloudflare-ctl.sh deploy aether v<version>`. `.github/workflows/deploy.yml` is manual only (S324): a clean CI checkout holds only the root bundle, so an automatic deploy on push or tag would delete the versioned paths World pins. `v0.1.0` verified 200 on 2026-11-11. |
| Cache-busting strategy for version bumps | **Pending** |
| `prefers-reduced-motion` on harmony animations | **Pending** |
| Entity visual spec + reference images | **Done** — `RaBbLE-Entity-Visual-Spec.md`, `assets/entity/` |
| Icon assets populated | Future |
| OS theme substrate (`themes/`) | **Done** — GTK3 synthwave skeleton, GTK4 overrides, Kvantum SVG, Firefox chrome CSS. Ansible in RaBbLE-OS wired to `aether_repo_root`. |

## Known Behaviours

**`@property --harmony-angle` Firefox DevTools warning:** Firefox shows "Selector expected. Ruleset ignored due to bad selector." for `@property` at-rules in the Style Inspector. This is a DevTools cosmetic issue — the property IS registered and animations work. A `--harmony-angle: 0deg` fallback is also declared in the WM `:root` block for browsers that reject `@property`.

## Reading Order for a New Session

1. This file — you are here
2. `AGENT.md` — rules and workspace map
3. `../RaBbLE-Grimoire/RaBbLE-Aether/RaBbLE-Aether-Build-CDN.md` — build system, dev/prod file distinction, CDN usage
4. `../RaBbLE-Grimoire/RaBbLE-Aether/RaBbLE-Aether-Architecture.md` — design system spec
5. `../RaBbLE-Grimoire/RaBbLE-Agent/RaBbLE-Palette.md` — palette (canonical source)
