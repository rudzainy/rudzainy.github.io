# rudzainy.github.io

Personal portfolio at **[rudzainy.com](https://rudzainy.com)**, built with Jekyll
and served from this repo via GitHub Pages (`CNAME` at the root). The markup is
hand-written; Jekyll only supplies the shared chrome (head, navbar, footer,
scripts) through `_layouts/` and `_includes/`.
`rudzainy.github.io` still resolves and redirects to the custom domain.

## Run locally

Ruby 3.3.6 (pinned in `.ruby-version`) and the `github-pages` gem, so local
builds match production.

```bash
bundle install                   # once
bundle exec jekyll serve         # then open http://localhost:4000
bundle exec jekyll build         # build to _site/ (gitignored)
```

## Deploy

```bash
git push origin main             # GitHub Pages builds with Jekyll and serves
```

Custom domain is in `CNAME`.

## Layout

```
/                    index.html, 404.html, resume.html, robots.txt
├── _layouts/        default, post, section
├── _includes/       head, navbar, footer, scripts
├── work/            portfolio pieces        (Work section)
├── life/            personal / lifestyle    (Life section)
├── balance/         thoughts, dev notes,    (Balance section)
│                    creative writing
├── legacy/          archival .md sources with no served page (not built)
├── tools/           one-shot post converter and helpers (not built)
├── components/      component catalog + design-system.html (style guide)
├── images/          all assets — portfolio/, posts/, favicons/
├── docs/            PDFs, CVs, misc reference
└── .okf/            Open Knowledge Format bundle (one concept per post)
```

Asset paths are root-absolute (`/images/`, `/si-es-es.css`, `/jei-es.js`).

## Content model

Under `work/`, `life/`, `balance/`:

- **`YYYY-MM-DD-slug.md`** — the live posts. Front matter (`layout`, `title`,
  `date`, `description`, `category`, `permalink`, and optional extras) plus the
  original HTML body kept raw. Edit these to change the site. The `permalink`
  is pinned to the original `.html` URL. Don't add `published: false`; it
  removes the post from the build.
- **`YYYY-MM-DD-slug.html`** — the superseded hand-written pages. Excluded from
  the build in `_config.yml` because the `.md` renders to the same URL; they
  stay in the tree until their deletion is approved.
- **`_YYYY-MM-DD-slug.html`** — unlisted drafts. Jekyll skips them.
- **`index.html`** — the section index, hand-written card grid on the section
  layout.
- **`legacy/*.md`** — archival Jekyll sources with no served page (old
  `layout: post` front matter, old Liquid-style tags). Not built. Kept as source
  material and as input for the `.okf/` bundle.

Never put a literal Liquid tag in a published `.md`; it breaks the Pages build.
Internal docs are excluded in `_config.yml` for the same reason.

The three sections are colour-coded (see tokens below). The `category:` field in
front matter is the real classification and does **not** always match the
folder — don't "fix" it to match the folder.

## Design system

House styles live in `si-es-es.css`, driven by **design tokens** at `:root`:
`--color-*`, `--space-*`, `--type-*`, `--radius-*`, `--shadow-*`, `--motion-*`.
Change a token, not a call site.

Palette is **Batik**: Work `#2A4BA0` indigo, Life `#1E7A54` emerald, Balance
`#C56A12` saffron, primary `#201A2B` aubergine ink (mono — the triad carries the
colour), on `#F6F2E9` songket cream. Category
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
