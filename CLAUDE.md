# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a hand-crafted static personal portfolio website hosted on GitHub Pages
at **rudzainy.com**. GitHub Pages serves the raw `.html` files directly — there
is **no build system, no static site generator, no Jekyll pipeline** (no
`_config.yml`, no `Gemfile`). `index.html` links straight to the served pages
under `/work/`, `/life/`, and `/balance/`.

## Technology Stack

- **HTML5** — semantic markup, no templating. What you edit is what ships.
- **Bootstrap 5.3.8** — CDN-hosted for layout and responsive design.
- **Lucide** (lucide-static font, CDN) — primary icon library (`icon-*` classes). Category glyphs: Work `icon-pencil-ruler`, Life `icon-sun`, Balance `icon-mountain`.
- **Simple Icons** (simpleicons.org) — brand marks only, wired as CSS masks so they inherit `currentColor` + font-size: `<i class="brand-icon brand-github">` (also `brand-behance`, `brand-youtube`, `brand-x`). Classes defined in `si-es-es.css`.
- **Bootstrap Icons** — fully retired (was the legacy icon set; all `bi-*` migrated to Lucide/Simple Icons).
- **Custom CSS** — `si-es-es.css` for house styles (design tokens, card hover
  effects, shadows, transitions).
- **Vanilla JavaScript** — `jei-es.js` for quote randomization on section pages
  and the SmartImage `onerror` fallback swap.

### Batik Design System additions (July 2026 handoff)

Ported from the `Batik Design System` handoff into the no-build site as plain
Bootstrap + `si-es-es.css` classes (never React/JSX):

- **Post-body section library** — 12 reusable classes in `si-es-es.css`:
  `.post-figure`, `.post-gallery` (`--gallery-cols`), `.post-before-after`,
  `.post-pull-quote`, `.post-callout` (`.is-note/.is-warning/.is-tip`),
  `.post-meta-table`, `.post-embed`, `.post-code`, `.post-steps`, `.post-stats`,
  `.post-nav` (prev/next), `.post-related`. Documented/specimened in
  `components/posts/index.html`.
- **`data-category` hook** — set `data-category="work|life|balance"` on `<body>`
  (or any ancestor) to make `.post-*` blocks re-tint via the inherited
  `--cat-base/-ink/-subtle/-border` vars.
- **Dot backgrounds** — `.bg-dots-work/life/balance` (pale category dots on a
  subtle tint). Used only on section-index header bands and subtle-tint zones —
  **not** on the vivid category header bands (those stay flat) and not on the
  cream body. Tokens: `--bg-dot-size`, `--bg-dot-tile`, `--bg-dots-*`.
- **SmartImage** — `.smart-image` frame + `.smart-image-placeholder` (45°
  songket stripe). Real image: `<span class="smart-image is-zoom"><img … data-fallback="label"></span>`;
  a failed/missing image is swapped to the striped placeholder by `jei-es.js`.
- **Page templates** — case-study (Work) and journal-post (Life/Balance) layouts
  live as hand-written HTML; exemplars: `work/2020-09-01-the-hoojah-project.html`
  (case study), `balance/2024-05-09-how-to-validate-an-email-address-in-rails.html`
  (journal). Rollout to all posts is a later pass.

## Development Workflow

There is no build step. Edit files directly and push:

```bash
# View locally — open any HTML file in a browser, or serve the folder
ruby -run -e httpd . -p 8000

# Deploy — push to main; GitHub Pages serves automatically
git push origin main
```

## Site Architecture

```
/                       # Root pages: index.html, 404.html
├── /work/              # Portfolio pieces (served: 20 .html, 2008–2025)
├── /life/              # Personal/lifestyle content (served: 10 .html)
├── /balance/           # Wellness / thoughts content (served: 23 .html)
├── /components/        # Internal component reference / living style guide
│   ├── /cards/         # Card variants (1x1, 2x2, featured, quote, etc.)
│   ├── /grids/         # Grid layout patterns
│   └── /modals/        # Modal component snippets
├── /images/            # All image assets (correct path is /images/, not /assets/img/)
│   ├── /portfolio/     # Portfolio images organized by project
│   └── /posts/         # Post images
└── /docs/              # PDF/document assets (CVs, portfolios) + misc reference HTML
```

## Content: served HTML vs. legacy `.md` sources

Two kinds of files live side by side under `work/`, `life/`, `balance/`:

```
YYYY-MM-DD-slug-title.html    # SERVED by GitHub Pages — this is the live page
_YYYY-MM-DD-slug-title.md     # LEGACY Jekyll source — NOT built, NOT served
```

- The **`.html` files are the site.** Edit these to change what visitors see.
- The **82 `.md` files are archival Jekyll sources** — they carry
  `layout: post` front matter and `{% ... %}` liquid tags from a previous
  Jekyll incarnation of the site. Nothing builds them; GitHub Pages ignores
  them. They are kept as source material and as the richest structured input
  for the `.okf/` knowledge bundle. Many are `published: false` drafts.
- Do **not** assume an `.md` and its `.html` sibling are in sync — treat the
  `.html` as authoritative for what ships, and the `.md` as historical.

## Key Files

| File | Purpose |
|------|---------|
| `index.html` | Homepage — bento-box grid of Work / Life / Balance cards |
| `si-es-es.css` | Custom styles + design tokens (see below) |
| `jei-es.js` | Quote randomizer for the section cards |
| `CNAME` | Custom domain (rudzainy.com) |
| `components/index.html` | Component reference / living style guide |
| `.okf/` | Open Knowledge Format bundle built from the cleaned content |

## Visual identity — invariants

These are the soul of the site. Codify them; do not redesign them.

- **Bento-box layout** — mixed-size cards in a grid. Kept exactly.
- **Category colour-coding as a concept is invariant** — Work / Life / Balance
  must stay visually distinguished by colour, plus neutral white cards. The
  specific hues live in tokens (`--color-work`, `--color-life`,
  `--color-balance`, `--color-neutral`, `--color-primary`) and may evolve
  toward a bespoke palette; the *concept* of colour-coding does not change.
- **Typography** — Unica One (condensed uppercase) for display/headings;
  Crimson Text (serif) for body/quotes; monospace for the logo/code. Loaded via
  the existing Google Fonts `@import`. Kept.

Free to evolve: spacing rhythm, shadows, radii, hover/motion, cross-page
consistency.

## Styling Conventions

Bootstrap classes handle layout; `si-es-es.css` adds house style. House style is
expressed through **design tokens** at `:root` (colours, spacing, type,
radii, shadows, motion) so magic numbers live in one place. When changing a
spacing/shadow/radius/motion value, change the token, not the call site.

## JavaScript Notes

`jei-es.js` holds three quote arrays (`quotesWork`, `quotesLife`,
`quotesBalance`) that rotate a random quote every few seconds on the respective
section cards.

## EditorConfig

Enforced for served HTML/CSS/JS: LF line endings, UTF-8, 2-space indentation,
trimmed trailing whitespace, final newline. **Exception:** `.md` files are
**exempt from trailing-whitespace trimming** — never reflow or strip trailing
whitespace in the legacy `.md` sources.
