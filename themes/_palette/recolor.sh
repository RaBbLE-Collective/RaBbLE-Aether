#!/usr/bin/env bash
# recolor.sh — regenerate RaBbLE-Aether Kvantum theme from Catppuccin Mocha (Lavender).
#
# Deterministic: clones the pinned Catppuccin commit, copies the lavender flavor
# as the structural base, then applies themes/_palette/aether-kvantum.map to recolor
# both the .svg (fills/strokes/gradient stops) and the .kvconfig surfaces.
#
# Usage:  bash themes/_palette/recolor.sh
# QA gate (must be a subset of the 13 Aether hexes):
#   grep -oE '#[0-9a-fA-F]{6}' themes/kvantum/RaBbLE-Aether.svg | tr 'A-F' 'a-f' | sort -u
set -euo pipefail

CPN_COMMIT="71105d224fef95dd023691303477ce3eea487457"
CPN_REPO="https://github.com/catppuccin/Kvantum"
FLAVOR="catppuccin-mocha-lavender"

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMES="$(dirname "$HERE")"
OUT="$THEMES/kvantum"
MAP="$HERE/aether-kvantum.map"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

git clone --quiet "$CPN_REPO" "$TMP/cpn"
git -C "$TMP/cpn" checkout --quiet "$CPN_COMMIT"
SRC="$TMP/cpn/themes/$FLAVOR"

cp "$SRC/$FLAVOR.svg" "$OUT/RaBbLE-Aether.svg"
cp "$SRC/$FLAVOR.kvconfig" "$OUT/RaBbLE-Aether.kvconfig"

# Build a single sed program from the map (case-insensitive hex replace).
SED_PROG="$(mktemp)"
while read -r src dst _; do
  [[ "$src" =~ ^#.*$ || -z "$src" ]] && continue
  printf 's/#%s/#%s/Ig\n' "$src" "$dst" >> "$SED_PROG"
done < "$MAP"

sed -i -f "$SED_PROG" "$OUT/RaBbLE-Aether.svg"
sed -i -f "$SED_PROG" "$OUT/RaBbLE-Aether.kvconfig"
rm -f "$SED_PROG"

# --- Post-pass: semantic accent overrides the deterministic map can't express ---
# Focus marquee dashes (the [Focus] element, originally text-colored) -> cyan ring.
# These four paths sit inside <g id="focus-top">; recolor #e8e6f0 only there.
perl -0pi -e 's{(<g id="focus-top".*?</g>)}{ my $b=$1; $b =~ s/fill:#e8e6f0/fill:#00f5ff/g; $b }gse' "$OUT/RaBbLE-Aether.svg"

# kvconfig link.color -> cyan (link semantics, not accent).
sed -i 's/^link\.color=.*/link.color=#00f5ff/' "$OUT/RaBbLE-Aether.kvconfig"

echo "Recolored. Run the QA gate to verify subset of Aether palette."
