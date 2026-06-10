# RaBbLE-Aether

> The unified visual identity and design system for the RaBbLE Collective.

**Version:** `v0.0.0.1-rc.1` (Release Candidate for Episode 1)

---

## What Is Aether

Aether is the canonical design system for RaBbLE — color palette, typography, motion, and component styles. It is the single source of truth for visual identity across all Collective members.

Every RaBbLE surface — NeBuLA, World, OS, BaBbLE — derives from Aether. Consistency is not a design choice; it is an expression of the entity's coherence.

## Installation

### As a CDN Link (Recommended)

```html
<link rel="stylesheet" href="https://cdn.joinrabble.world/aether/v0.0.0.1-rc.1/aether.min.css">
```

Or load via JavaScript loader (see `src/entry.css` for the pattern):

```html
<script src="world/js/RaBbLE-aether.js"></script>
```

The loader injects Aether CSS and monitors for load failures.

### As an npm Package

```bash
npm install rabble-aether
```

Then in your CSS:

```css
@import 'rabble-aether/dist/aether.min.css';
```

## What's Included

| File | Purpose |
|---|---|
| `aether.min.css` | Production bundle (minified, sourcemap linked) |
| `aether.css` | Development bundle (unminified, sourcemap) |
| `rabble-palette.json` | Color tokens in JSON format |
| `rabble-palette.scss` | SCSS variables (for future consumers) |
| `rabble-motion.css` | Motion keyframes (standalone, reusable) |
| `rabble-components.css` | Component classes (standalone, reusable) |
| `rabble-portal-glyphs.svg` | Logo and glyph assets |

## Color Palette

Aether defines the RaBbLE visual language through a curated synthwave outrun palette:

| Token | Color | CSS Variable |
|---|---|---|
| Primary (Magenta) | `#ff2d78` | `--rabble-magenta` |
| Secondary (Cyan) | `#00f5ff` | `--rabble-cyan` |
| Tertiary (Violet) | `#bf5fff` | `--rabble-violet` |
| Grid (Pink) | `#ff79c6` | `--rabble-grid` |
| Surface | `#12132a` | `--rabble-surface` |
| Text | `#e8e6f0` | `--rabble-text` |
| Error | `#e05c6f` | `--rabble-error` |
| Success | `#50fa7b` | `--rabble-success` |
| Warning | `#f1fa8c` | `--rabble-warning` |

See [RaBbLE-Palette.md](../RaBbLE-Grimoire/RaBbLE-Agent/RaBbLE-Palette.md) for the canonical reference and design principles.

## Using CSS Variables

All Aether colors are exposed as CSS custom properties. Use them in your stylesheets:

```css
.my-element {
  color: var(--rabble-magenta);
  background: var(--rabble-surface);
  border: 1px solid var(--rabble-border);
}
```

## Motion Primitives

Aether includes a suite of motion keyframes for consistent animation:

```css
.portal {
  animation: portal-glow 2s ease-in-out infinite;
}

.entity-drift {
  animation: entity-sway 8s ease-in-out infinite;
}
```

See `src/motion.css` for the full library.

## Development

### Build

```bash
npm install
npm run build          # Production (minified, sourcemap)
npm run build:dev     # Development (unminified)
npm run build:watch   # Watch mode for local development
```

### Local Testing

The bundled CSS lands in `dist/aether.min.css`. Use it in a local dev server:

```bash
npm run build:watch
# Serve dist/ at http://localhost:8000/aether/v0.0.0.1-rc.1/
```

World and other members can load from the local CDN mock.

## Deployment

Aether deploys to Cloudflare R2 CDN on git tag:

```bash
git tag v0.0.0.1-rc.1
git push --tags
# GitHub Actions builds and uploads to:
# https://cdn.joinrabble.world/aether/v0.0.0.1-rc.1/aether.min.css
```

See [EP1-DEPLOYMENT-RUNBOOK.md](../EP1-DEPLOYMENT-RUNBOOK.md) for full CI/CD setup.

## Versioning

Aether uses [Five-Es Versioning](../RaBbLE-Grimoire/RaBbLE-Versioning.md):

- **v0.0.0.0** — Pre-Episode-1 (Epoch 0, Evolution 0, Echo 0, Episode 0)
- **v0.0.0.1** — Episode 1 (published alongside World and NeBuLA)
- **v0.1.0.1** — Evolution 1, Episode 1 (incremental improvements)

All three Collective members (Aether, NeBuLA, World) tag simultaneously on episode air.

## Architecture

Aether is built with esbuild to a single CSS bundle. The source is organized:

```
src/
  ├── entry.css          # Main bundle entry
  ├── palette.css        # Color tokens, CSS variables
  ├── motion.css         # Animation keyframes
  ├── typography.css     # Font stack, scales
  ├── components/        # UI component styles
  └── utilities/         # Helper classes
```

No JavaScript. Pure CSS. Portable everywhere.

## License

RaBbLE-Aether is licensed under the **RaBbLE Sovereign Accord**.

- **Personal use:** Encouraged. Modify, fork, create.
- **Attribution:** Keep the lineage intact. Mention RaBbLE.
- **Commercial use:** Reserved. Contact the Copyright Holder for a pact.

See [LICENSE](LICENSE) for the full text.

---

**Questions?** Open an issue or reach out to the Copyright Holder.

**Ready to use?** Start with the CDN link above.

**Part of the Collective?** See [RaBbLE-Collective.md](../RaBbLE-Grimoire/RaBbLE-Agent/RaBbLE-Collective.md) for the full ecosystem.
