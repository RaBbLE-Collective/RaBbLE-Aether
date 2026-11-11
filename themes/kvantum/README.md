# Kvantum theme — moved

The RaBbLE-Aether Kvantum theme (kvconfig + SVG) lives in
**`RaBbLE-OS/config/kvantum/RaBbLE-Aether/`** and deploys via
`RaBbLE-OS-dotctl.sh apply kvantum` (Ansible's `qt-gtk-theme.yml` uses the
same source).

The copy that used to live here was a stale early Catppuccin re-skin. Ansible
kept deploying it over the maintained dotctl copy on every theming run, which
repeatedly regressed Qt text colors (S116–S199). Removed S201 — do not
resurrect a second source of truth here.

Upstream base attribution (Catppuccin/kvantum, MIT) is preserved at
`RaBbLE-OS/config/kvantum/RaBbLE-Aether/LICENSE.upstream`.
