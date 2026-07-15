# Design: Cleanup + Design System + Editorial + OKF for rudzainy.com

**Date:** 2026-07-15
**Branch:** `cleanup/overhaul-and-okf`
**Author:** Rudzainy Rahman (with Claude Code)

## Goal

Take the hand-crafted static portfolio at rudzainy.com from its current
"laying around everywhere" state to a clean, documented, knowledge-rich
codebase — without changing what makes it *his*. Five outcomes:

1. A deep structural cleanup of the served site and its legacy sources.
2. A real, documented internal **design system** (tokens + living style guide).
3. **Editorial** pass over the many draft/unfinished posts, including
   AI-drafted proposed copy in the owner's voice for thin posts.
4. An **OKF** knowledge bundle — one concept per post — built from the
   cleaned content.
5. A proper **README** written in the owner's tone of voice.

## Context / current reality

- **No build system.** GitHub Pages serves the raw `.html` files directly.
  There is no `_config.yml`, `Gemfile`, or Jekyll pipeline. `index.html`
  links straight to `/work/*.html`, `/life/*.html`, `/balance/*.html`.
- The **82 `.md` files** under `work/`, `life/`, `balance/` are **legacy
  Jekyll sources** (`layout: post` front matter, `{% ... %}` liquid tags).
  They are not built and not served — they are archival source material,
  and the richest structured input for the OKF bundle.
- **Rot:** 18 md have broken `{ % ... %}` liquid tags (space-corrupted),
  37 md still reference the old `/assets/img/` path, 32 are
  `published: false`, ~33 md have no `.html` sibling.
- **Cruft:** `ar-bi-rb` (a dead ruby.wasm experiment duplicating
  `jei-es.js`); `posts/20250905_windsurf_global_rules.html` (a misplaced
  Windsurf AI-rules file saved as HTML — not a post).
- **`CLAUDE.md` is inaccurate** — it claims "pure HTML ... no md" but 82
  md exist; it should describe the legacy-sources reality.
- **Constraint:** `.editorconfig` forbids trimming trailing whitespace in
  `.md` — respected everywhere.

## Visual identity — HARD INVARIANTS (do not change)

These are the soul of the site. The design system *codifies* them; it does
not redesign them.

- **Bento-box layout** — mixed-size cards in a grid. Kept exactly.
- **Category colour-coding:**
  - Work = **blue**
  - Life = **green**
  - Balance = **amber / yellow**
  - plus neutral **white** cards.
  These currently come from Bootstrap utility classes / per-page styling,
  *not* from `si-es-es.css`. The design system consolidates them into
  tokens (`--color-work`, `--color-life`, `--color-balance`, `--color-neutral`).
- **Typography:**
  - Display / headings — **Unica One** (condensed uppercase).
  - Body / quotes — **Crimson Text** (serif).
  - Logo / code — monospace (`-|{·}}`).
  All kept. Fonts loaded via the existing Google Fonts `@import`.

Free to evolve: spacing rhythm, shadows, radii, hover/motion states,
consistency between pages, and anything not listed above.

## Execution model — Fable orchestration + subagent-driven development

- **Fable 5 as architect/advisor.** Fable is consulted (advisor mode) to
  shape the design-token taxonomy, the editorial voice-guide, and the OKF
  concept template — the high-judgment, low-token planning. Opus (this main
  loop) drives.
- **Opus subagents as executors.** The token-heavy fan-out — 82 posts, each
  going clean → (optional) draft → OKF concept — runs as **parallel Opus
  subagents**, one post owned end-to-end per agent, dispatched in batches.
- **Verification subagents** check each batch (front-matter schema, path
  correctness, OKF validity) before it is accepted.
- All work lands on `cleanup/overhaul-and-okf`; nothing merges to `main`
  until the owner approves.

## Phases

### Phase A — Structural cleanup + Design System + Design Review

**A1. Cruft & structure**
- Delete `ar-bi-rb`.
- Move `posts/20250905_windsurf_global_rules.html` → `docs/` (after
  confirming nothing links to it).
- Fix the 4 served HTML files still referencing `/assets/img/` → `/images/`.
- Normalize served HTML/CSS/JS to `.editorconfig` (LF, UTF-8, 2-space).
- Rewrite `CLAUDE.md` to match reality (static HTML served directly; `.md`
  are legacy sources; no build).

**A2. Internal design system**
- Extract **design tokens** into CSS custom properties at `:root` in
  `si-es-es.css`: `--color-*` (incl. the three category colours pulled out
  of the per-page/Bootstrap usage), `--space-*`, `--type-*`,
  `--radius-*`, `--shadow-*`, `--motion-*`. Replace magic numbers
  (`translateY(-5px)`, `scale(1.02)`, `150px`, text/button shadows) with
  tokens — identical visual output, single source of truth.
- Refactor `si-es-es.css` to consume the tokens.
- Formalize `components/` into a **living style guide**: upgrade
  `components/index.html` (or add `design-system.html`) documenting the
  tokens and every component variant already in `components/cards`,
  `components/grids`, `components/modals`, plus buttons.
- Consult Fable for the token taxonomy; use the `frontend-design` skill for
  aesthetic direction.

**A3. Design review pass**
- Run the `design-review` skill against `index.html`, the three section
  pages, and the style guide. Fix visual inconsistency, spacing/hierarchy
  issues, AI-slop patterns, and slow interactions — expressed through the
  new tokens. Invariants above are off-limits.

### Phase B — Data cleanup of the 82 `.md` sources
- Repair the 18 broken `{ % ... %}` liquid tags → plain markdown/HTML image
  references pointing at `/images/`.
- Fix the 37 md referencing `/assets/img/` → `/images/`.
- Normalize front matter consistently (title, date, category, tags,
  description, published) across all 82 md.
- Do **not** trim `.md` trailing whitespace.

### Phase C — Editorial (draft proposed content)
- For empty / thin / `published: false` posts, draft body copy **in the
  owner's voice** — warm, first-person, emoji-friendly, EN/BM bilingual —
  each clearly marked `<!-- AI-DRAFTED: review & edit -->` so nothing
  masquerades as final words. Never fabricate specific personal facts,
  dates, names, or memories; draft structure and tone, leave placeholders
  for facts only the owner knows.
- Produce `EDITORIAL-GAP-REPORT.md`: per-post status (empty / thin /
  missing image / draft) so the owner sees exactly what needs their hand.
- **Gate:** draft 2–3 sample posts first for owner approval of the drafting
  style before fanning out to all drafts.

### Phase D — OKF bundle
- Invoke the `okf` skill; build an `.okf/` bundle with **one concept per
  post** (~82), from the *cleaned* content, with cross-links between
  related work (e.g. Hoojah ↔ podcast ↔ DXC BioniX design system).
- Run `okf:validate`; optionally `okf:visualize` for a graph preview.

### Phase E — README in the owner's voice
- Hand-written `README.md`: what rudzainy.com is; the three sections
  (Work / Life / Balance) and their colour-coding; the no-build static-HTML
  reality; local preview (`python3 -m http.server`) + deploy (push to
  `main`); the design system; and the `.okf/` bundle. In the owner's tone,
  not corporate boilerplate.

## Ordering & gates
1. Phase A + B run first (mechanical + design system) → show diff for review.
2. Phase C: 2–3 sample drafts → owner approval → fan out to remaining drafts.
3. Phase D (OKF) and Phase E (README) last.
4. Nothing merges to `main` until owner approves the branch.

## Success criteria
- No cruft files; served HTML on correct `/images/` paths; `.editorconfig`
  clean on HTML/CSS/JS.
- `si-es-es.css` driven by documented tokens; visual output unchanged for
  the invariants; a browsable style guide exists.
- All 82 md have consistent front matter, working image paths, no broken
  liquid tags.
- Every draft/thin post either has AI-drafted proposed copy (marked) or is
  listed in `EDITORIAL-GAP-REPORT.md`.
- `.okf/` bundle passes `okf:validate` with one concept per post and
  meaningful cross-links.
- `README.md` reads in the owner's voice and matches reality.

## Out of scope
- Any change to the bento layout, category colour-coding, or fonts.
- Fabricating personal facts/memories in draft posts.
- Introducing a build system / SSG.
- Reworking the `components/` catalog beyond documenting + tokenizing it.
