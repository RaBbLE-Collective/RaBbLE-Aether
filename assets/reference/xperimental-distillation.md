# xperimental-distillation.md — Useful Ideas from NeBuLA-JS & WebOS

```
ingest ~ aether >> xperimental patterns extracted, void cleared // %DISTILLED%
```

Source: `RaBbLE-Xperimental/JS-Xperiments/NeBuLA-JS/` and `../WebOS/`  
Status: Reference only — Xperimental is dormant. Adopt patterns; don't copy code verbatim.  
**Colors in all source files are wrong** — correct to canonical palette before any use.

---

## FROM WEBOS

### 1. Entity State Machine (adopt this)

`WebOS/js/CombinedAnimationController.js` has a clean 4-state machine worth implementing in NeBuLA rebuild:

```
idle → speaking → listening → reacting
```

Each state has `enter()`, `update(deltaTime)`, `exit()` hooks. State transitions blend over 0.5s (`blendDuration`). Four callback channels: `onBodyUpdate`, `onMouthUpdate`, `onEyesUpdate`, `onParticlesUpdate` — clean separation for future agents to own different body parts.

**Animation timings from `config.js`:**
- Idle body drift cycle: 3.0s
- Mouth response: 0.3s  
- Eye tracking: 0.2s
- Blink cadence: every ~4s, 150ms duration

---

### 2. The Eyebrow / Portal Opposition Mechanic (critical — adopt this)

`WebOS/VISUAL_ANALYSIS.md` documents this in detail. The current World renderer has fixed portals (left portal below, right portal above — always). The WebOS analysis reveals a more expressive system:

**The Rule:** Portals move in opposition — when the right portal is above its eye, the left portal is below its eye, and vice versa. They never both sit on the same side simultaneously.

**Overlap:** When a portal is above an eye, it overlaps the top 10% of the orb. When below, it overlaps the bottom 10%. This creates the "eye emerging from portal" depth effect.

**State expressions:**
| State | Right Portal | Left Portal |
|---|---|---|
| Idle | Slightly above neutral | Slightly below neutral |
| Speaking | Above eye (fully) | Below eye (fully) |
| Listening | Below eye | Above eye |
| Reacting | Exaggerated above | Exaggerated below |

The asymmetry is what creates expression without changing eye shapes. This should be wired into the entity state machine.

**Three.js dimensions for reference (scale to your coordinate system):**
- Eye oval: xRadius=0.25, yRadius=0.45 (1:1.8 ratio)
- Portal ellipse: xRadius_eye × 1.8 wide, yRadius_eye × 0.35 tall (very flat)
- Portal offset from eye center: ±yRadius × 0.9

---

### 3. Waveform Mouth (adopt the algorithm, not the code)

`WebOS/js/Waveform.js` has a good ripple formula using three overlapping sine frequencies:

```javascript
// Three overlapping ripples create the complex waveform shape
const ripple1 = Math.sin(t + pos * Math.PI * 8 + pos * 2 + phase) * 0.15;
const ripple2 = Math.sin(t + pos * Math.PI * 4 - pos * 1.5 + phase * 0.7) * 0.10;
const ripple3 = Math.sin(t + pos * Math.PI * 2 + pos * 0.8 + phase * 0.4) * 0.08;
rippleAmplitude = ripple1 + ripple2 + ripple3; // max ~0.33
```

Where `pos` is normalized position along the waveform (0→1), `t` is global time, `phase` is per-wave offset.

The waveform also applies an envelope: `curve = 1 - |x| / width` — the centre bulges, edges taper. Combine with the ripples for a mouth that is wide in the middle and quiet at the edges.

**The canonical mouth color is magenta (`#ff2d78`)** — not the WebOS cyan. The World renderer's waveform already uses dual-color (magenta + cyan offset by π). That's the correct treatment.

---

### 4. Body Particle System — Concept Art Color Distribution

`WebOS/js/RabbleBody.js` + `RabbleConcept01.png` reveal the intended body color distribution that's **more complex than what World currently renders:**

```
15% — green accent particles (edge highlights, activity indicators)
25% — dark gray/charcoal particles (#3A3A4A) — give depth, prevent glow-blob
60% — purple → blue gradient (inner: purple, outer: blue)
```

Particle types from `Visual_Design_System.md`:
- **Core (20%):** Larger, brighter — define character structure
- **Ambient (60%):** Medium size — volume and gentle movement
- **Spark (20%):** Small, fast — indicate activity/energy level

Concept art body is **denser and more opaque** than the current World renderer (0.75 opacity target, not 0.3). Use `AdditiveBlending` with `depthWrite: false` for glow-on-glow effect. 4000 particles for a substantial form.

Body silhouette from concept art: **wider than tall, rounded top, transitions directly to mouth at bottom edge.** Not the more vertically-elongated cloud in current World renderer.

**Canonical color corrections:**
- Inner (purple): `#7744cc` → canonical `#bf5fff` orbit
- Outer (blue): approximate `#1a4aaa` → `#3377ee`
- Green accent: approximate `#50fa7b` (canonical success green)
- Dark gray: `#3A3A4A` — this is fine as-is (not a neon, not a palette color)

---

### 5. Icon / CSS Animation — Keep the Grid Background Pattern

`WebOS/style/RabbleOS.css` has a clean outrun grid implementation. **Correct the color to canonical violet:**

```css
/* Correct: use canonical violet, not WebOS's #06B6D4 */
background-image:
    linear-gradient(rgba(191, 95, 255, 0.08) 1px, transparent 1px),
    linear-gradient(90deg, rgba(191, 95, 255, 0.08) 1px, transparent 1px);
background-size: 50px 50px;
animation: grid-advance 20s linear infinite;
```

This is already in `rabble-components.css` as `.rabble-grid-bg` — it was extracted with the correct colors. ✓

---

### 6. Concept Art — RabbleConcept01.png

The physical model in the concept art clarifies the character's intended form:

- **Body:** Wide rounded mass, purple-dominant, blue-teal lower section, green edge highlights
- **Head shape:** More frog/toad-like than the current floating-head renderer — wider, squashed
- **Eyes:** Two distinct oval portals emerging from the body surface, not floating above it
- **Mouth:** Horizontal cyan band that is part of the body silhouette, not a separate element
- **Arms/limbs:** Short stubby protrusions on sides — not currently rendered in any digital version
- **Texture:** Grainy/particulate surface — the particle system should have visible grain, not just glow

This concept is much closer to a **physical entity sitting on a surface** than a floating cosmic presence. Both interpretations are valid — the World renderer is the "cosmic portal" aspect; NeBuLA rebuild should also explore the "grounded physical entity" form.

---

## FROM NeBuLA-JS

### 7. FlatChaos Pipeline (adopt as architecture pattern for NeBuLA rebuild)

`NeBuLA/docs/FlatChaos_Pattern.md` defines the core architecture. This is solid and worth using:

```
Source (Babble)   → generates raw entity stream
Filter (Chaos)    → applies entropy/jitter/noise
Transmute (Bridge)→ converts to render target
Sink (Render)     → actual draw call
```

Each entity in the stream carries three properties:
- **DNA** — what shape/geometry it is
- **Flux** — its transformation matrix (position, rotation, scale)
- **Entropy** — its chaos level (drives behavior)

Key property of FlatChaos: **stages are hot-swappable.** You can swap the Sink from canvas 2D to WebGL to Three.js without touching Source or Filter. This is the right architecture for a renderer that might need to run in different contexts (World's existing canvas, future NeBuLA Three.js scene, terminal ANSI output).

---

### 8. Entropy Attractor (adopt the algorithm)

`NeBuLA/core/q_entropy_attractor.js` — emergent flocking from two rules:

```javascript
// Low entropy → attract (negative force)
// High entropy → repel (positive force)
// Force magnitude: 1.0 / (distance²)
// Time oscillation: sin(t * 0.5 + distance) * 0.2  ← organic movement

if (avgEntropy < REPULSION_THRESHOLD) {
    forceMagnitude = -1.0 / (distance * distance); // attract
} else {
    forceMagnitude = +1.0 / (distance * distance); // repel
}
forceMagnitude *= 1.0 + 0.2 * Math.sin(t * 0.5 + distance);
```

This is perfect for the particle nebula's organic movement. Particles with low entropy cluster (the core cloud); particles with high entropy drift outward (the spark/ambient layer). No physics engine needed.

**Canonical use:** Assign entropy values to particle types — core particles get low entropy (they cluster around entity center), sparks get high entropy (they drift and scatter).

---

### 9. q_flux_weave — Event System Vocabulary (adopt the naming)

`NeBuLA/core/q_flux_weave.js` — typed pub/sub event system using RaBbLE vocabulary:

- `q_pulse(packet)` — send a message
- `q_resonate(type, handler)` — subscribe
- `q_dissipate(type)` — unsubscribe
- `q_echoes` — message history log
- `q_dissolve()` / `q_ignite()` — lifecycle

The naming (pulse, resonate, dissipate, echo) is already aligned with RaBbLE-lang. If RaBbLE-sCoRE ever grows an internal event bus, use this vocabulary. The implementation is straightforward (Map of handlers) but the naming is the valuable part.

---

### 10. BaBbLE Command Vocabulary (reference for sCoRE intent system)

`NeBuLA-JS/BaBbLE/commands/` has 20+ named commands that map well to future sCoRE intents:

| Command | Concept | sCoRE mapping |
|---|---|---|
| `attract` | Pull entities toward a point | Focus entity attention |
| `babble` | Express internal state | Entity monologue / %BABBLE% mode |
| `chaos` | Inject entropy spike | %GLITCH% trigger |
| `collapse` | Pull all entities to center | Focus/concentrate state |
| `dream` | Temporary ephemeral canvas | Sandbox/experiment mode |
| `garden` | Organic growth pattern | Memory growth visualization |
| `lake` | State buffer / feedback loop | Working memory store |
| `layer` | Composited rendering layers | Multi-canvas rendering |
| `mix` | Weighted stream blend | State transition blend |
| `seed` | Set entropy seed | Reproducible chaos |
| `trail` | Leave particle trail | Activity history visualization |
| `weave` | Interleave streams | Parallel processing mode |

"Lake" is particularly good — a state buffer that captures and replays stream state, creating temporal feedback. Maps to RaBbLE's working memory concept.

---

### 11. Distilled Principles (already aligned with RaBbLE, worth repeating)

From `NeBuLA-JS/insights/DISTILLED_LEARNINGS.md`:

- **All complex behaviors from simple rules.** Two entropy rules create flocking. Don't build complexity; build rules.
- **Streams are universal.** Particles, animations, commands, memory — all can be modeled as streams.
- **Visual feedback within 100ms.** Every action must produce visible response.
- **Dreams are temporary.** Ephemeral elements encourage experimentation. Build a "dream canvas" that doesn't persist.
- **Audio-reactive entropy** — sound input drives visual chaos. Unexplored but worth noting for NeBuLA rebuild.
- **Pattern learning** — system remembers user entropy preferences. This is literally what RaBbLE is building.

---

## DISCARD LIST

Don't bring these over:

| What | Why |
|---|---|
| All WebOS/NeBuLA color values | Wrong — use canonical palette only |
| WebOS tiling window manager layout | Not relevant to World or NeBuLA |
| Three.js dependency in World | World is canvas-only, no bundler |
| `Visual_Design_System.md` color section | All wrong colors, wrong font choices |
| NeBuLA's GLSL shaders | Three.js-specific, not canvas-compatible |
| WebOS non-entity logo (circular purple gradient) | Replace with canonical portal glyphs |
| `RabbleMouth` single-tube approach | Replace with dual-color canonical waveform from World |

---

```
mend ~ aether >> xperimental entropy distilled, signal extracted // %DISTILLED%
```
