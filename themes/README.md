# RaBbLE-Aether — Platform Themes

Aether is the single source for the Collective's platform-level (OS/desktop/editor)
themes. Member repos and RaBbLE-OS Ansible deploy these artifacts; they do not keep
their own copies.

| Path | What |
|---|---|
| `kvantum/` | Qt theme (Kvantum engine) — `RaBbLE-Aether.kvconfig` + `RaBbLE-Aether.svg` |
| `vscodium/` | VSCodium color theme + workbench `custom.css` injection + manifest |
| `gtk3/`, `gtk4/` | GTK theme CSS |
| `firefox/` | Firefox `userChrome.css` / `userContent.css` |
| `_palette/` | Recolor map + script (reproducible re-skin pipeline) |

All colors trace to `../../RaBbLE-Grimoire/RaBbLE-Agent/RaBbLE-Palette.md` (13 hexes).

---

## Kvantum theme — provenance & recolor pipeline

The Kvantum theme is **not hand-authored**. It is a deterministic re-skin of an
upstream theme so structure stays clean and updatable.

- **Upstream:** [catppuccin/Kvantum](https://github.com/catppuccin/Kvantum) — **MIT License, (c) 2021 Catppuccin**.
- **Pinned source commit:** `71105d224fef95dd023691303477ce3eea487457` (2025-12-27).
- **Base flavor:** `themes/catppuccin-mocha-lavender/` (Mocha + lavender accent — Arc-Dark
  structural lineage). The accent choice is irrelevant: we override it entirely.
- **License obligation:** upstream MIT requires the copyright + permission notice be
  retained. It is preserved here and in this attribution block. Our recolor is a
  derivative work, redistributable under the Collective's terms with this notice intact.

### How it's recolored

`_palette/aether-kvantum.map` is an explicit `source-hex -> aether-hex` table
covering every unique color in the Catppuccin Mocha base (backgrounds, surfaces,
overlays, accent + rings, text, semantic red, shadow gradients, and the metallic
slider-sheen grays). `_palette/recolor.sh`:

1. Clones the pinned Catppuccin commit to a temp dir.
2. Copies the lavender flavor's `.svg` + `.kvconfig` into `kvantum/` as
   `RaBbLE-Aether.{svg,kvconfig}` (overwrites in place).
3. Applies the map case-insensitively to both surfaces via a generated `sed` program.
4. Post-pass: recolors the `[Focus]` marquee dashes to cyan and sets
   `link.color` to cyan (link semantics, not the magenta accent).
5. The `[GeneralColors]` block in the `.kvconfig` is then asserted to the exact
   Aether role mapping (see `_palette/aether-kvantum.map` header comments).

Regenerate the whole theme:

```bash
bash themes/_palette/recolor.sh
```

### QA gate (mandatory — run after any recolor)

Every `#rrggbb` in the SVG **must** be a subset of the 13 Aether palette hexes.
Any other hex is an orphan (this is the check the old KvArcDark-derived theme failed —
it leaked Arc grays like `#383c4a`, `#3176bf`, `#0582ff`).

```bash
grep -oE '#[0-9a-fA-F]{6}' kvantum/RaBbLE-Aether.svg | tr 'A-F' 'a-f' | sort -u
```

Expected output (10 of the 13 Aether hexes are used; the rest are reserved):

```
#00f5ff  #0a0010  #12132a  #1a1b2e  #2a2840
#6b6880  #bf5fff  #e05c6f  #e8e6f0  #ff2d78
```

The Aether palette (the only permitted colors):
`#ff2d78 #00f5ff #bf5fff #ff79c6 #e8e6f0 #e05c6f #50fa7b #f1fa8c #0a0010 #12132a #1a1b2e #2a2840 #6b6880`

---

## VSCodium theme

`vscodium/` holds the editor theme artifacts (migrated from RaBbLE-OS):
`package.json` (extension manifest), `themes/RaBbLE-Aether-color-theme.json`
(token colors), and `assets/custom.css` (workbench CSS injected by Ansible).
RaBbLE-OS keeps only `config/vscodium/User/settings.json` (the selector that
activates the theme). Deployment lives in
`RaBbLE-OS/ansible/roles/apps/tasks/vscode.yml`, sourcing from `aether_repo_root`.
