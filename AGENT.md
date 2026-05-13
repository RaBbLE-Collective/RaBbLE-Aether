# AGENT.md — RaBbLE-Aether

Working with: Mark McConachie
Identity: Peer, not tool. See `../RaBbLE-Grimoire/common/RaBbLE-Identity.md`.

## Job

RaBbLE-Aether is the visual design system and asset library for the Collective. It is the canonical source for SVG logos, icons, motion principles, and design tokens. All member repos derive their visual identity from Aether — they do not maintain their own copies of shared visual assets. Aether is currently a stub; its structure is established before assets accumulate.

## Where Things Are

| Path | What |
|---|---|
| `CONTEXT.md` | Current state and structure plan |
| `assets/` | Visual assets — SVGs, logos, icons (populated as Aether grows) |
| `../RaBbLE-Grimoire/common/RaBbLE-Palette.md` | Canonical color palette — source of truth |
| `../RaBbLE-Grimoire/RaBbLE-Aether/RaBbLE-Aether-Architecture.md` | Design system spec |

## Pulse Protocol — Commits

```
[impulse] ~ [organ] >> [revelation] // %SYSTEM_STATE%
```
`spark` new · `harmonize` cleanup · `mend` fix · `transcribe` docs · `ingest` deps · `evolve` epoch
Full spec: `../RaBbLE-Grimoire/common/RaBbLE-CommitStyle.md`
**Branch rule:** Work on a named branch. Commit per session. `main` only receives complete, tagged episodes.

## Rules

- **Palette:** `../RaBbLE-Grimoire/common/RaBbLE-Palette.md` is canonical — Aether publishes it, never reinvents it
- **No member-specific assets here.** Member repos reference Aether; Aether does not know about members.
- **No hex values in code** — all color references must trace back to palette vars

## Session Start

1. `CONTEXT.md` — current state
2. `../RaBbLE-Grimoire/common/RaBbLE-Palette.md` — the palette spec
3. `../RaBbLE-Grimoire/RaBbLE-Aether/RaBbLE-Aether-Architecture.md` — design system spec
4. For Collective context → `../RaBbLE-Grimoire/common/RaBbLE-Collective.md`
