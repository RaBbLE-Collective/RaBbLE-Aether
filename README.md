# RaBbLE-Aether

> The design system of the RaBbLE Collective: palette tokens, typography, motion and components in one CSS bundle.

**Version:** `0.1.0` (Genesis) · **Live:** [aether.joinrabble.world](https://aether.joinrabble.world/v0.1.0/aether.min.css) · **Versioning:** [semver, per member](https://github.com/RaBbLE-Collective/RaBbLE-Grimoire/blob/main/RaBbLE-Versioning.md)

---

## What Aether is

Aether is the skin of RaBbLE. Every web surface in the Collective (World, NeBuLA, ScRiBbLE) loads one stylesheet from Aether and gets the whole visual identity: the `--rabble-*` tokens, the fonts, the motion keyframes and the component classes. Members do not keep their own copies of colours or shared styles.

The palette itself is defined in the Grimoire, in [RaBbLE-Palette.md](https://github.com/RaBbLE-Collective/RaBbLE-Grimoire/blob/main/RaBbLE-Agent/RaBbLE-Palette.md). Aether publishes it and does not invent values.

Aether also holds the desktop themes RaBbLE-OS installs (`themes/`: GTK 3 and 4, Kvantum, Firefox, VSCodium).

## Quickstart

Link the versioned bundle:

```html
<link rel="stylesheet" href="https://aether.joinrabble.world/v0.1.0/aether.min.css">
```

Then style with tokens, never with hex values:

```css
.my-panel {
  color: var(--rabble-text);
  background: var(--rabble-surface);
  border: 1px solid var(--rabble-border);
  box-shadow: var(--rabble-glow-cyan-sm);
}
```

Each bundle's first line names its version and commit, for example `/*! Aether 0.1.0+253dd63 */`.

CDN paths are immutable per version. `aether.css` (unminified) sits beside `aether.min.css` at each version path.

## What is in the bundle

`src/entry.css` is the entry point. esbuild bundles it in this order:

| Layer | Source | What |
|---|---|---|
| Fonts | Google Fonts import | Orbitron, Exo 2, Share Tech Mono |
| Base | `assets/base/rabble-base.css` | Resets, body defaults, prose, brand typography |
| Palette | `assets/palette/rabble-palette.css` | Every `--rabble-*` token: colour, glow, gradient, type scale, easing, breakpoints |
| Motion | `assets/motion/rabble-motion.css` | `@keyframes`, `@property`, animation classes |
| Components | `assets/components/rabble-components.css` | Buttons, cards, tiles, floor, horizon, CRT overlays |
| Theme | `assets/theme/rabble-theme.css` | Variants such as the muted preset |

`assets/palette/` also carries `rabble-palette.json` and `rabble-palette.scss` mirrors of the tokens, and `assets/logos/rabble-portal-glyphs.svg` holds the portal glyphs.

## Tuning the look

Three tokens re-skin the signature look without touching any member:

| Token | Purpose |
|---|---|
| `--aether-grad-a` | First gradient stop; re-skins every signature gradient |
| `--aether-grad-b` | Second gradient stop |
| `--aether-neon` | Glow intensity from `0` to `1`; scales the blur and opacity of every glow token. Registered with `@property`, so it transitions |

```js
document.documentElement.style.setProperty('--aether-neon', '0.5');
```

For a calm, low-glow look, set `data-aether="muted"` on `:root` (or any ancestor), or add the class `.aether-lights-off` to a wrapper. The muted preset sets `--aether-neon: 0.2` and mutes the neons without losing the fingerprint.

## Development

```bash
npm install
npm run build            # dist/aether.min.css (production, sourcemap)
npm run build:dev        # dist/aether.css (development)
npm run build:versioned  # both, copied to dist/v<package version>/
```

Inside the Collective, use the Grimoire's `spells/dev-serve.sh` to serve Aether to World locally. Do not run watch builds by hand.

## Deployment

Deploys run from a local checkout. They do not run on push:

```bash
# from the Collective root
bash RaBbLE-Grimoire/spells/cloudflare-ctl.sh deploy aether v0.1.0
```

The `rabble-aether` Worker serves the whole `dist/` folder, including every earlier version path, so a deploy has to come from a checkout whose `dist/` holds them all. The GitHub workflow can only be started by hand for that reason (see the note in `.github/workflows/deploy.yml`).

## Licence

RaBbLE-Aether is under the **RaBbLE Sovereign Accord**: source-available, personal use encouraged, commercial use reserved, the name and the face reserved. See [LICENSE](LICENSE).

---

Part of the [RaBbLE Collective](https://github.com/RaBbLE-Collective/RaBbLE-Collective). Docs: [Grimoire, Aether section](https://github.com/RaBbLE-Collective/RaBbLE-Grimoire/tree/main/RaBbLE-Aether).
