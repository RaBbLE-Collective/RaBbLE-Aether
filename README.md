# RaBbLE-Aether

One stylesheet that makes a plain web page look like RaBbLE: the neon palette, the fonts, the glow, the motion and a set of ready-made components.

**Genesis release `0.1.0`** · See every component live in the [Catalog](https://joinrabble.world/world/RaBbLE-Catalog)

## Quickstart

Save this as `index.html` and open it in a browser. Nothing to install.

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" href="https://aether.joinrabble.world/v0.1.0/aether.min.css">
</head>
<body class="rabble-grid-bg">
  <main class="rabble-container">
    <p class="rabble-eyebrow">Genesis</p>
    <h1 class="rabble-display">Hello, world</h1>
    <div class="rabble-card rabble-card-cyan">
      <div class="rabble-card-title">A card</div>
      <div class="rabble-card-body">Styled by one stylesheet. No build step.</div>
    </div>
    <button class="rabble-btn rabble-btn-cyan">Wake</button>
    <button class="rabble-btn rabble-btn-ghost">Later</button>
  </main>
</body>
</html>
```

## Style your own elements

Use the `--rabble-*` variables instead of colour values, so your page follows the palette:

```css
.panel {
  color: var(--rabble-text);
  background: var(--rabble-surface);
  border: 1px solid var(--rabble-border);
  box-shadow: var(--rabble-glow-cyan-sm);
}
```

The full list of variables is in `assets/palette/rabble-palette.css`. The colours themselves are defined in the [RaBbLE palette](https://github.com/RaBbLE-Collective/RaBbLE-Grimoire/blob/main/RaBbLE-Agent/RaBbLE-Palette.md).

## Turn the glow down

```html
<html data-aether="muted">
```

Or set the intensity yourself, anywhere from `0` to `1`:

```css
:root { --aether-neon: 0.5; }
```

## Build from source

```bash
npm install
npm run build        # writes dist/aether.min.css
```

## Licence

Source-available under the RaBbLE Sovereign Accord: free for personal use, commercial use by agreement. See [LICENSE](LICENSE).
