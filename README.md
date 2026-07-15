# rudzainy.com

Personal portfolio at **[rudzainy.com](https://rudzainy.com)**. Hand-written
static HTML on GitHub Pages. No build system, no SSG — the `.html` files in the
repo are exactly what ships.

## Run locally

```bash
python3 -m http.server 8000      # then open http://localhost:8000
```

Any `.html` also opens directly in a browser.

## Deploy

```bash
git push origin main             # GitHub Pages serves automatically
```

Custom domain is in `CNAME`. There is no CI and no build to wait on.

## Layout

```
/                    index.html, 404.html
├── work/            portfolio pieces        (Work section)
├── life/            personal / lifestyle    (Life section)
├── balance/         thoughts, dev notes,    (Balance section)
│                    creative writing
├── components/      component catalog + design-system.html (style guide)
├── images/          all assets — portfolio/ and posts/
├── docs/            PDFs, CVs, misc reference
└── .okf/            Open Knowledge Format bundle (one concept per post)
```

## Content model

Two kinds of files sit side by side under `work/`, `life/`, `balance/`:

- **`*.html`** — the live pages. GitHub Pages serves these. Edit these to change
  the site.
- **`*.md`** — legacy Jekyll sources (`layout: post` front matter, old `{% %}`
  tags). **Not built, not served.** Kept as source material and as the input for
  the `.okf/` bundle. Don't assume an `.md` and its `.html` sibling are in sync;
  the `.html` is authoritative for what ships.

Naming: `YYYY-MM-DD-slug.html`. Some drafts use a leading `_` on the HTML.

The three sections are colour-coded (see tokens below). The `category:` field in
`.md` front matter is the real classification and does **not** always match the
folder — don't "fix" it to match the folder.

## Design system

House styles live in `si-es-es.css`, driven by **design tokens** at `:root`:
`--color-*`, `--space-*`, `--type-*`, `--radius-*`, `--shadow-*`, `--motion-*`.
Change a token, not a call site.

Palette is **Batik**: Work `#2A4BA0` indigo, Life `#1E7A54` emerald, Balance
`#C56A12` saffron, primary `#B02E5A` rose, on `#F6F2E9` songket cream. Category
colours also ship a darkened `-ink` variant for heading text on light backgrounds
(the base tones are too dark/light for both roles).

Category colours are applied through Bootstrap utility classes in the markup
(`text-info`=Work, `text-success`=Life, `text-warning`=Balance, `text-primary`).
`si-es-es.css` **remaps** `--bs-info/success/warning/primary` (and the `.btn-*`
variants) onto the tokens, so the palette changes with zero edits to the ~400
utility-class usages.

- Style guide (tokens rendered live): `components/design-system.html`
- Component catalog: `components/index.html`

Fonts: **Unica One** (headings), **Crimson Text** (body/quotes), monospace logo.
Loaded via the Google Fonts `@import` in `si-es-es.css`.

Invariants: bento layout, the concept of Work/Life/Balance colour-coding, and the
fonts. Everything else (spacing, shadows, motion, exact hues) can change.

## `.okf/` knowledge bundle

[Open Knowledge Format](https://github.com/GoogleCloudPlatform/knowledge-catalog)
v0.1 — one markdown concept per post (82), organized by section, cross-linked by
shared tag. Each concept carries type/title/description/tags/timestamp, a live
`resource` URL where published, and `Related` links. Start at `.okf/index.md`.

Regenerate/validate after content changes:

```bash
# validator ships with the okf plugin
okf_validate .okf --strict
```

## Conventions

- `.editorconfig`: LF, UTF-8, 2-space indent, trim trailing whitespace, final
  newline — **except `.md`**, which is exempt from trailing-whitespace trimming
  (never reflow or strip trailing whitespace in the legacy sources).
- `jei-es.js` rotates random quotes on the section cards (`quotesWork`,
  `quotesLife`, `quotesBalance`).
- Draft/thin/empty posts are tracked in `EDITORIAL-GAP-REPORT.md`. AI-drafted
  proposed copy is marked `<!-- AI-DRAFTED: review & edit -->` with `[owner: ]`
  placeholders for facts to fill in.
- Agent guidance lives in `CLAUDE.md`.
