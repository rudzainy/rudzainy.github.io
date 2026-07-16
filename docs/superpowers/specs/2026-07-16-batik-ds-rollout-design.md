# Batik Design System rollout + technical-content pass — design

**Date:** 2026-07-16
**Branch:** `cleanup/overhaul-and-okf`
**Source:** `Batik Design System-handoff.zip` (Claude Design export) + `EDITORIAL-GAP-REPORT.md`

## Goal

Two coupled workstreams, one pass:

1. **Design system** — implement the Batik DS updates from the handoff into the
   live no-build site: dot backgrounds, the post-body section template library,
   `SmartImage` placeholders, and the case-study / journal-post / section-index
   page templates — applied to the section indexes and a few exemplar posts.
2. **Content** — draft the *technical/work* thin & empty posts (`.md` source →
   served `.html`), leaving the owner's personal/reflective posts untouched. A
   second content-refinement pass happens later; this pass gets structure and
   correct-where-verifiable copy in place.

## Non-negotiable constraints

- **No build system.** GitHub Pages serves raw `.html`. What we edit is what
  ships. No React/JSX, no `x-dc` bundle, no client-side include system.
- **Translate, don't import.** The handoff's React/`x-dc` templates carry
  *computed* style values. Port those to `si-es-es.css` classes + Bootstrap
  5.3.8 HTML. The handoff's own UI-kit README mandates exactly this for
  production.
- **Visual identity invariants** hold: bento layout, category colour-coding
  (Work indigo `#2A4BA0` / Life emerald `#1E7A54` / Balance saffron `#C56A12` /
  primary aubergine `#201A2B` on songket cream `#F6F2E9`), Unica One display +
  Crimson Text body, poster offset shadows, hover lift −5px / press sink 2px,
  ASCII wau `~|{·})` typed never drawn.
- **Personal-posts boundary.** Do NOT AI-draft the owner's personal/intimate or
  reflective posts (e.g. `life/2022-09-15-maya`, `life/2022-03-19-happyness-unlocked`,
  poetry, journal reflections). Technical tutorials and portfolio case studies
  only.
- **Icon reconciliation.** The site (commit `0f877be`) uses **Lucide `icon-*`**
  for UI glyphs and **Simple Icons `brand-*`** for brand marks. Handoff templates
  say `icon-github`; map brand marks to `brand-github` / `brand-behance` and keep
  `icon-external-link` (Lucide) for generic external links. No `bi-*`.
- **EditorConfig.** Served HTML/CSS/JS: LF, UTF-8, 2-space indent, trimmed
  trailing whitespace, final newline. `.md` sources are EXEMPT from
  trailing-whitespace trimming — never reflow them.
- **No gradients** except the two sanctioned ones: horizontal scroll-fade
  affordances and the dot-field SVGs. No blur/transparency beyond existing
  `--bs-text-opacity` usage.

## Architecture / units

### Unit 1 — CSS foundation (`si-es-es.css`, additive)

The token layer already exists (colours, category, shadows, `page-header-*`,
`post-content`). Add:

- **Dot backgrounds** — port `--bg-dot-size`, `--bg-dot-tile`,
  `--bg-dots-work/life/balance` from `tokens/backgrounds.css`, plus
  `.bg-dots-work` / `.bg-dots-life` / `.bg-dots-balance` utilities. Applied ONLY
  to coloured page-header bands and subtle-tinted section blocks. Flat cream body
  stays flat.
- **Section category tweak vars** — `--cat-base`, `--cat-ink`, `--cat-subtle`,
  `--cat-border`, set per page (via the `page-header-*` context or a
  `data-category` hook) so body-section components inherit the right hue.
- **SmartImage (CSS)** — `.smart-image` frame + `.smart-image-placeholder` (45°
  songket stripe `repeating-linear-gradient(45deg,#EFE9DB 0 10px,#F6F2E9 10px 20px)`
  with a dashed border and a mono caption chip). No React.

### Unit 2 — Post-section snippet library (`components/posts/`)

12 reusable HTML+CSS patterns, each a `si-es-es.css` class block + a documented
snippet in the living style guide (`components/index.html` / a new
`components/posts/index.html`). All honour the category tweak vars:

| Pattern | Class | Notes |
|---|---|---|
| Figure | `.post-figure` | breakout-wide captioned image via SmartImage, optional zoom |
| Gallery | `.post-gallery` | `--gallery-cols` grid of SmartImages |
| Before/After | `.post-before-after` | labelled 2-col comparison, striped placeholders |
| Pull quote | `.post-pull-quote` | big category serif quote, hairline rules, em-dash attr |
| Callout | `.post-callout` (`.is-note/warning/tip`) | construction-notice voice, variant icon/label/tint |
| Meta table | `.post-meta-table` | `<dl>` fact sheet (client/role/stack/year/links) |
| Embed | `.post-embed` | Behance/video iframe card + truncated source link |
| Code | `.post-code` | dark aubergine block, filename header + lang tag, mono |
| Steps | `.post-steps` | numbered vertical timeline on a rail |
| Stats | `.post-stats` | poster-shadow number row, divided strip |
| Prev/Next | `.post-nav` | two hover-lift cards |
| Related | `.post-related` | "more of X" bento CardScroller |

### Unit 3 — Page templates (applied)

- **Section indexes** (`work/index.html`, `life/index.html`, `balance/index.html`):
  "all about X" bento header (back card + title card + intro card) on a dotted
  category band, year-grouped horizontal scrollers of content cards. Rebuild from
  the actual served posts in each section (not the handoff's sample data).
- **Case-study template** (Work exemplars): coloured header band + breadcrumb +
  standfirst + featured image + 4-col featured-meta strip overlapping the body,
  serif reading column with iconed H2s, body sections drawn from Unit 2.
- **Journal-post template** (Life/Balance exemplars): category band + breadcrumb
  + date/kicker + hero title, serif reading column, Unit 2 sections.

### Unit 4 — Content drafts (technical/work only)

**Tier A — fully draftable** (write real, correct copy in house voice):
- `balance/2024-01-11-rails-image-tag`, `2024-01-22-rails-7-dropdown-image`,
  `2024-01-11-rails-drag-and-drop`, `2024-02-25-tutorial-ruby-on-rails`,
  `2024-03-16-setup-python-3-on-macos`, `2024-03-16-tutorial-generate-qr-for-wifi`,
  `2024-05-09-how-to-validate-an-email-address-in-rails`
- `work/2025-12-28-sync` (NO-FM, 68w — expand + front matter)

**Tier B — structural draft, invent no specific facts** (front matter + case-study
scaffold + house-voice connective prose; anything unverifiable gets a visible
`<!-- DRAFT: owner to confirm -->` marker):
- Portfolio: `work/2017-09-01-eezeejob`, `2018-09-01-postco-email-design`,
  `2012-09-01-maritime-college-corporate-branding`,
  `2010-09-01-marliyati-froz-logo`, `2019-09-01-dxc-bionix-central`,
  `balance/2024-01-09-ux-review-decathlon-sports-shop`
- NO-FM front-matter-only (already complete bodies): `work/2025-09-10-interview-questions-and-answers`
  (1893w), `work/2025-12-28-tenggelam` (1535w), `work/2025-09-11-day-food-catalogue`
  (553w — add FM, light expansion).

**Explicitly out of scope** (leave as-is): `life/2022-09-15-maya`,
`life/2022-03-19-happyness-unlocked`, and all reflective/poetry/personal
`balance` + `life` posts flagged THIN in the gap report.

Each drafted `.md` remains a legacy source; its served `.html` is generated on
the new templates. Metadata gaps (missing `category`/`description`) on the
touched posts are filled while we're there.

### Exemplar posts for the DS rollout (9)

Chosen to overlap drafted content and exercise every Unit-2 pattern:

- **Work (case-study):** `2020-09-01-the-hoojah-project` (meta-table, stats,
  embed, related), `2025-09-11-day-food-catalogue` (figure/gallery with the real
  `portfolio-dayfood-featured.png` asset), `2019-09-01-dxc-bionix-central`
  (before/after, steps — Tier B draft).
- **Life (journal-post):** `2021-01-03-kenapa-rudzainy-buat-hoojah` (pull-quote,
  related), `2024-01-03-of-books` (figure), `2024-01-03-of-video-games`
  (callout).
- **Balance (journal-post):** `2024-03-23-add-diagram-on-websites-using-mermaidjs`
  (code, embed), `2024-05-09-how-to-validate-an-email-address-in-rails` (code,
  steps, callout — Tier A draft), `2023-12-04-users-vs-corporations-in-digital-communication`
  (pull-quote, callout).

Exemplar selection may shift ±1 if a chosen post proves a poor fit; the intent
(section indexes + ~3 per category covering all patterns) is fixed.

## Execution model

Fable 5 as architect/advisor sequences the work and delegates; Opus 4.8 subagents
do token-heavy execution (subagent-driven-development).

- **Phase 1 (serial, single owner):** Unit 1 CSS + `jei-es.js` SmartImage handler.
  Shared files — must not be edited in parallel.
- **Phase 2 (serial):** Unit 2 snippet library in `si-es-es.css` + style-guide
  page. Also touches the shared stylesheet.
- **Phase 3 (parallel):** content drafts (Unit 4) — each `.md` is an independent
  file; fan out.
- **Phase 4 (parallel):** apply templates to the 9 exemplar posts + 3 section
  indexes — each `.html` is independent; fan out. Depends on Phases 1–2.

## Verification

- EditorConfig compliance on every touched served file (LF, 2-space, trimmed
  trailing ws, final newline); `.md` trailing ws preserved.
- No `bi-*`; brand marks use `brand-*`, UI glyphs `icon-*`.
- No gradients outside scroll-fades + dot SVGs; category text uses `-ink`
  variants on white; white text only on category base.
- WCAG: `visually-hidden` on icon-only controls, `figcaption` on figures,
  `:focus-visible`, `prefers-reduced-motion` respected, semantic landmarks.
- Rendered spot-check of one exemplar per category (local `ruby -run -e httpd`)
  before declaring done.
- OKF bundle (`.okf/`) note: drafted content changes it; regenerate/refresh if
  the OKF skill flags drift (out of scope to fully rebuild here).

## Out of scope

- Full rollout to all ~80 served posts (later pass).
- Second content-refinement pass (owner-led).
- Rebuilding the OKF bundle from scratch.
- Any redesign of the invariant visual identity.
