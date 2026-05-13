# rabble-portal-glyphs-spec.md — RaBbLE Eye & Portal Anatomy

```
transcribe ~ aether >> entity eyes specified // %EYE_SPEC%
```

This document is the canonical specification for recreating RaBbLE's visual form — the two portal-eyes with their orbital rings. All measurements derive from `rabble-entity.js` (the authoritative renderer) and the icon files.

---

## What You're Looking At

RaBbLE's visible "face" is two **tall narrow white orbs** floating in a void, each partially intersected by a thin **orbital ring** (portal ellipse). The orbs glow with different neon colors — one magenta, one cyan — suggesting two distinct but paired presences. The whole entity sits above a **particle nebula cloud** and is surrounded by an **ambient radial glow**.

Reference image: `RaBbLE-World/icons/icon.png` — the 512×512 icon shows the full composition including surrounding aura.

---

## The Canvas

The entity renderer targets a **460px wide × 320px tall** canvas (CSS pixels). All measurements below are in CSS pixels on that canvas.

- **Center X (cx):** 230px (canvas width / 2)
- **Center Y (cy):** ~150px (canvas height × 0.47 — slightly above true center)
- **Base Y:** cy − 6px = ~144px (eyes sit 6px above the cy baseline)

---

## The Orbs (Eyes)

### Shape
- **Type:** Vertical ellipse (tall narrow oval, taller than wide)
- **Semi-axis X (half-width):** 15px — full width: **30px**
- **Semi-axis Y (half-height):** 56px — full height: **112px**
- **Aspect ratio:** 1 : 3.73 (width to height)

### Position
- **Left orb X:** cx − 36 = **194px**
- **Right orb X:** cx + 36 = **266px**
- **Both orbs Y (center):** base Y = **144px**
- **Gap between orb centers:** 72px

### Fill
- **Color:** `#f8faff` (near-white with a barely-perceptible cool blue tint)
- **Inner shadow/core glow:** `rgba(220,235,255,0.85)`, blur 22px — creates a warm bright core

### Stroke / Neon Border
- **Left orb stroke:** `#ff2d78` (Hot Magenta)
- **Right orb stroke:** `#00f5ff` (Electric Cyan)
- **Stroke width:** 2px
- **Stroke glow (box-shadow):** pulse between 8px and 28px blur (sin wave over time: `18 + 10*sin(t)`)

### Halo
Each orb has a radial gradient halo spreading outward from its center:
- **Inner:** orb color at 22% opacity (`#ff2d78` or `#00f5ff` + `'38'` hex alpha)
- **Outer:** fully transparent
- **Halo radius:** orb height × (0.80 to 0.92) — pulses gently with time
  - Range: ~45px to ~52px from orb center

### Eye State During Blink
- Orbs compress vertically (blinkScale goes 1.0 → 0.0 → 1.0)
- The horizontal shape remains the same; only the Y axis scales
- Hard blinks: 5 blinks in rapid succession on entity initialization

---

## The Portal Rings (Orbital Ellipses)

Each eye has one orbital ring — a thin horizontal ellipse that appears to intersect the orb, suggesting the orb is partially behind or pushing through the ring.

### Shape
- **Type:** Horizontal ellipse (wide, very flat)
- **Semi-axis X (half-width):** 31px — full width: **62px**
- **Semi-axis Y (half-height):** 9.5px — full height: **19px**
- **Aspect ratio:** 3.26 : 1 (wider than tall — like a planet's ring viewed at an angle)

### Position (Crucially — they are offset, not centered on the orb)
- **Left portal center X:** 194px (same as left orb X)
- **Left portal center Y:** baseY + (56 × 0.44) = 144 + 24.6 = **~169px** — BELOW the orb center
- **Right portal center X:** 266px (same as right orb X)
- **Right portal center Y:** baseY − (56 × 0.44) = 144 − 24.6 = **~119px** — ABOVE the orb center

This offset means the portals cross the **lower third of the left orb** and the **upper third of the right orb**, giving the impression of the orbs partially emerging from or sinking into a horizontal plane.

### Color
- **Left portal:** `#ff2d78` (Hot Magenta)
- **Right portal:** `#00f5ff` (Electric Cyan)

### Visual Treatment
- Stroke only (no fill — the interior of the ring is a near-black radial gradient)
- **Stroke width:** 1.8px
- **Glow blur:** pulses between 12px and 20px (`12 + 8*sin(t)`)
- **Leading dot:** during animation/drawing, a 3.5px white dot with matching color glow leads the arc
- **Interior fill:** radial gradient `#010108` → `#05050e` → transparent — dark void inside the ring

---

## The Particle Nebula Cloud

A cloud of ~480 particles surrounding the entity, providing ambient depth and the impression of the entity as a living cosmic presence.

### Distribution
- **Cluster radius:** 130px (target) — particles concentrate within this radius
- **Falloff edge:** 155px — alpha fades to 0 at this distance from center
- **Vertical compression:** particles spread 80% as far vertically as horizontally (slightly flattened cloud)
- **Center point:** same as entity center (cx, cy)

### Particle Properties
- **Size range:** 0.8px to 11.8px radius (varied, not uniform)
- **Alpha range:** 0.18 to 0.83 (base alpha, further modulated by falloff and pulse)
- **~55% of particles** have a glow halo (shadowBlur 20–41px matching particle color)
- **~45% of particles** have minimal or no glow

### Particle Color Palette
Blues (primary):
- `#1a4aaa`, `#2255cc`, `#3377ee`, `#4499ff`, `#55aaff`

Teals:
- `#00bbdd`, `#00eeff`, `#33ddf0`, `#55ccee`

Purples/violets:
- `#5533aa`, `#7744cc`, `#9944dd`, `#aa44cc`, `#bb55dd`

Whites/near-whites:
- `#ffffff`, `#ddeeff`, `#ccddff`, `#aabbee`

Deep blues (sparse):
- `#0a1a55`, `#0d2277`, `#112299`

### Movement
Particles have two motion modes:
1. **Boot convergence:** drift from scattered positions to target cluster
2. **Idle drift:** slow sinusoidal drift within the cloud, amplitude 0.6–3px, maintaining cluster shape

~13% of particles are faintly connected to neighbors within 62–82px with near-invisible lines (0.13 opacity) — neural network visual.

---

## Composition in the Icon (512×512 Reference)

The `RaBbLE-World/icons/icon.png` icon shows the full composition with additional artistic treatment:

### Icon vs. Canvas Renderer Differences
The icon includes additional artistic elements not in the live renderer:
- **Outer orbital sweep:** a large encircling ring (not the small portal ellipses) in cyan and magenta — a painterly sweeping arc that loops around the entire entity from upper-left through lower-right
- **Aura:** strong ambient glow halo around the entire composition (~200px radius from entity center)
- **Shadow/ground plane:** a dark oval shadow beneath the entity suggesting depth

### Icon Composition Layout
```
                    [cyan sweep arc — upper left to right]
                   /
        [Left Orb]   [Right Orb]
        (magenta)     (cyan)
                   \
                    [magenta sweep arc — lower]
        
        [ R a B b L E - O S ]   ← Exo/Rajdhani, cyan (#00f5ff), 24px
        [    ~waveform~    ]    ← dual-color waveform, magenta+cyan
```

### Color Relationships in Icon
- **Left/magenta orb** sits inside the lower magenta orbital sweep
- **Right/cyan orb** sits inside the upper cyan orbital sweep
- Together they create a figure-8 / ∞ visual tension — two opposed but paired portals

---

## Prompt for Recreating the Eyes in Claude Design

```
Create RaBbLE's entity eyes.

Canvas: 460×320px, background #0a0010 (near-black, deep purple tint).

LEFT ORB (magenta eye):
- Position: 36px left of canvas center, centered at 47% canvas height
- Shape: tall narrow vertical oval, 30px wide × 112px tall
- Fill: #f8faff (near-white, very slightly cool blue tint)
- Inner core glow: white, ~22px shadow blur
- Neon stroke: 2px, color #ff2d78 (hot magenta), glow blur 20–28px
- Outer halo: radial gradient, magenta at 22% opacity fading to transparent, radius ~50px

LEFT PORTAL RING (below left orb):
- Horizontal ellipse, 62px wide × 19px tall
- Centered at: same X as left orb, positioned ~25px BELOW left orb center
- Stroke only, 1.8px, color #ff2d78, glow blur ~15px
- Interior: dark void radial gradient (#010108 center → transparent)

RIGHT ORB (cyan eye):
- Position: 36px right of canvas center, centered at 47% canvas height  
- Shape: identical oval to left (30px wide × 112px tall)
- Fill: #f8faff
- Inner core glow: white, ~22px shadow blur
- Neon stroke: 2px, color #00f5ff (electric cyan), glow blur 20–28px
- Outer halo: radial gradient, cyan at 22% opacity fading to transparent, radius ~50px

RIGHT PORTAL RING (above right orb):
- Horizontal ellipse, 62px wide × 19px tall
- Centered at: same X as right orb, positioned ~25px ABOVE right orb center
- Stroke only, 1.8px, color #00f5ff, glow blur ~15px
- Interior: dark void radial gradient

PARTICLE NEBULA:
- Scattered particles (blues, purples, teals, whites) concentrated within 130px of center
- Particles fade out beyond 155px radius
- Cloud is slightly flatter vertically than horizontally
- Roughly half the particles have a soft matching glow

RESULT: Two paired orbs appearing to emerge from opposing portal rings — a magenta eye
rising from below, a cyan eye descending from above — surrounded by a cosmic particle cloud.
```

---

## Prompt for the Full Icon Composition (with Sweep Arcs)

```
Create the RaBbLE entity icon — full composition.

Background: #000000 (pure black for maximum contrast in icon context).

Entity core (center of canvas):
- Two white orbs as described above (left=magenta, right=cyan)
- Particle nebula cloud surrounding them

Large orbital sweep arcs (the dramatic encircling rings):
- CYAN SWEEP: a bold sweeping arc that enters from upper-left, curves over the top of the entity,
  and exits to the right. Color #00f5ff, glow 15–20px, slightly varying stroke width.
- MAGENTA SWEEP: a bold sweeping arc that enters from the right, curves under the bottom of
  the entity, and exits to the left. Color #ff2d78, glow 15–20px, slightly varying stroke width.
- Together the two arcs loosely encircle the entity, passing each other at left and right.
- The arcs should feel dynamic and slightly irregular — orbital, not perfectly circular.

Ground shadow:
- Dark oval beneath the entity: radial gradient from #1a0030 at center to transparent at edges
- Roughly 180px wide × 40px tall, centered below the orbs

Text (for OS icon version):
- "RaBbLE-OS" in Exo 2 or similar tech font, cyan (#00f5ff), ~24px
- Below text: a short dual-color waveform (~120px wide), magenta and cyan lines, overlapping

Overall: the entity should look like a cosmic entity hovering at the center of two intersecting
orbital paths. The composition reads well at 16×16px through 512×512px.
```

---

## Portal Expression System — The Eyebrow Opposition Mechanic

*Source: WebOS/VISUAL_ANALYSIS.md, WebOS/js/RabbleEyes.js*

The current World renderer (`rabble-entity.js`) has **fixed portal positions** — left portal always below, right portal always above. This is the "default idle" expression. The full expression system is more dynamic.

### The Rule
Portals always move in **opposition**. When the right portal is above its orb, the left portal is below its orb. They never sit on the same side simultaneously. This asymmetry creates readable expression without changing the orb shapes.

### Overlap Behavior
When a portal is positioned above an eye, it overlaps the **top 10% of the orb** — the orb appears to emerge from below the portal ring. When below, it overlaps the **bottom 10%** — the orb appears to sink into it. This depth-through-portal effect is what makes the eyes feel dimensional.

### State Mapping
| Entity State | Right Portal | Left Portal | Expression |
|---|---|---|---|
| `%DORMANT%` / `%INITIALIZING%` | Centered | Centered | Neutral, no expression |
| `idle` | Slightly above (default) | Slightly below (default) | The canonical resting look |
| `speaking` | Fully above, 10% overlap | Fully below, 10% overlap | Open, expressive, active |
| `listening` | Fully below, 10% overlap | Fully above, 10% overlap | Attentive, receiving |
| `reacting` / `%GLITCH%` | Exaggerated above | Exaggerated below | High emotion, surprise |
| `%GENIUS_RESONANCE%` | Far above, glow intensified | Far below, glow intensified | Peak state |

### Animation
Portal positions transition smoothly (0.3–0.5s ease) as entity state changes. During the transition the portals sweep through the orb — not teleport. The sweep animation is part of the expressiveness.

### WebOS Three.js Reference Dimensions
*(Scale to your coordinate system — these are Three.js units)*
- Eye: xRadius=0.25, yRadius=0.45 (1:1.8 ratio — squatter than World's 1:3.73 canvas renderer)
- Portal: 1.8× eye width, 0.35× eye height (very flat)
- Portal offset when fully positioned: ±yRadius × 0.9 from eye center
- Portal overlap with eye: ±yRadius × 0.1 (the 10% rule)

---

## The Three Formats

| Format | Source File | Use |
|---|---|---|
| **Live canvas** | `RaBbLE-World/rabble-entity.js` | Web surfaces, interactive, animated |
| **Static SVG** | `RaBbLE-Aether/assets/logos/rabble-portal-glyphs.svg` | Documents, non-interactive |
| **Icon PNG** | `RaBbLE-World/icons/icon.png`, `RaBbLE-Aether/RaBbLE-OS_ICON.png` | App icons, favicons, social |

---

```
spark ~ aether >> eyes specified, portals mapped // %EYE_SPEC_LOCKED%
```
