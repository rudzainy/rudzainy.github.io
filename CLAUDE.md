# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a hand-crafted personal portfolio website, built with Jekyll and hosted
on GitHub Pages, served on the custom domain **rudzainy.com**, set by the `CNAME`
file at the repo root and in Pages Settings. `rudzainy.github.io` still resolves
and redirects there. The old `.my` domain is retired and is no longer the brand domain,
so don't reintroduce it in copy or comments. The markup is still hand-written:
the shared chrome (head, navbar, footer, scripts) lives in `_includes/` and
`_layouts/`, and each served post is a `.md` file whose body is raw HTML.
`index.html` links straight to the pages under `/work/`, `/life/`, and
`/balance/`.

**Deployment reality (important):** Jekyll is the build. GitHub Pages runs it on
push, and the `Gemfile` uses the `github-pages` gem so local builds match
production (Ruby 3.3.6, pinned in `.ruby-version`). `_config.yml` holds the site
title, URL and description, the SEO/sitemap plugins (see *SEO, sitemap and
feed*), and an `exclude:` list that keeps internal docs, `tools/`, `legacy/`
and local tooling files out of the build.
The internal docs (`CLAUDE.md`, `README.md`, `EDITORIAL-GAP-REPORT.md`,
`INDEKS.md`, `docs/superpowers`) are excluded so they are not published and,
crucially, are kept away from Jekyll's Liquid parser. Jekyll renders every other
`.md` (front matter, or `jekyll-optional-front-matter`), so **never put a literal
`{%`/`{{` Liquid sequence in any published `.md`** (even inside backticks or
prose) — it will break the whole Pages build. The only Liquid in a post is
deliberate logic such as the `live_urls` guards (see *Publishing and
unpublishing*). If you must show one, wrap it in
`{% raw %}…{% endraw %}` or exclude the file in `_config.yml`. `.css`/`.js` and
the static assets are copied through untouched.

## Technology Stack

- **Jekyll** (`github-pages` gem) — layouts and includes for the shared chrome only; post bodies stay hand-written HTML. Asset paths are root-absolute (`/images/`, `/si-es-es.css`, `/jei-es.js`), never `../`.
- **HTML5** — semantic markup.
- **Bootstrap 5.3.8** — CDN-hosted for layout and responsive design.
- **Lucide** (lucide-static font, CDN pinned to `lucide-static@1.70.0` with an SRI `integrity` hash and `crossorigin`, in `_includes/head.html` and every standalone page that loads it) — primary icon library (`icon-*` classes). Category glyphs: Work `icon-pencil-ruler`, Life `icon-sun`, Balance `icon-mountain`.
- **Simple Icons** (simpleicons.org) — brand marks only, wired as CSS masks so they inherit `currentColor` + font-size: `<i class="brand-icon brand-github">` (also `brand-behance`, `brand-youtube`, `brand-x`). Classes defined in `si-es-es.css`.
- **Bootstrap Icons** — fully retired (was the legacy icon set; all `bi-*` migrated to Lucide/Simple Icons).
- **Mermaid** — loaded per post (via `head_extra`/`scripts_extra` or inline) and
  pinned to `mermaid@10.9.8`. The `mermaid@10` inside the MermaidJS tutorial's
  `<pre><code>` sample is prose, not a load.
- **CDN pin rule** — every CDN URL names an exact version (`bootstrap@5.3.8`,
  `lucide-static@1.70.0`, `mermaid@10.9.8`). Never use `@latest` or a
  major-only range (`@10`); bump the version and the SRI hash together.
- **Custom CSS** — `si-es-es.css` for house styles (design tokens, card hover
  effects, shadows, transitions).
- **Vanilla JavaScript** — `jei-es.js` for quote randomization on section pages
  and the SmartImage `onerror` fallback swap.

### Batik Design System additions (July 2026 handoff)

Ported from the `Batik Design System` handoff into the no-build site as plain
Bootstrap + `si-es-es.css` classes (never React/JSX):

- **Post-body section library** — 13 reusable classes in `si-es-es.css`:
  `.post-figure`, `.post-gallery` (`--gallery-cols`), `.post-before-after`,
  `.post-pull-quote`, `.post-callout` (`.is-note/.is-warning/.is-tip`),
  `.post-meta-table`, `.post-embed`, `.post-code`, `.post-steps`, `.post-stats`,
  `.post-nav` (prev/next), `.post-related`. Documented/specimened in
  `components/posts/index.html`. Plus `.post-section-head` (below), specimened
  in `components/design-system.html`.
- **`.post-section-head` — in-post section opener ("rule tab", design 2B).**
  A solid category tab sitting on a 2px rule, so the line opens the section
  instead of closing the last one. Contract is **two sibling elements**, with
  nothing between them (the CSS uses `+`):
  ```html
  <div class="post-section-head" aria-hidden="true">
    <span class="head-tab"><i class="icon-book-open"></i><span>01 &middot; a pet project</span></span>
  </div>
  <h2 id="keep-existing-anchor">Summary</h2>
  ```
  The h2 stays a **sibling, not a child**, so `id=` anchors and heading order
  are untouched; it takes no class and no inline style. The tab carries a
  zero-padded number, one Lucide `icon-*` naming the section's subject, and an
  optional lowercase kicker after `&middot;`. Kicker-or-not is decided **per
  post, never mixed inside one**. Modifiers: `.is-first` (drops the top margin
  on a case study's first section), `.is-inverse` (white tab + white rule for a
  head on a dark category ground). Rolled out across all 21 h2-bearing posts;
  see `docs/superpowers/plans/section-header-2b-plan.md`.
- **`--cat-*` bridge.** `--cat-base/-ink/-subtle/-border` used to exist only
  under `[data-category]`, which 11 h2-bearing posts never set, so `.post-*`
  blocks rendered colourless there. `si-es-es.css` now also derives them from
  `body:has(.page-header-work|life|balance)`, which every served post carries.
  An inner `[data-category]` wrapper still wins by proximity, so nested
  overrides (e.g. a `work`-tinted `.post-related` inside a `life` post) behave
  as before. **Prefer adding nothing:** a new post gets its category colour for
  free from its `.page-header-*` class.
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
  live as hand-written HTML bodies in `.md` posts; exemplars: `work/2020-09-01-the-hoojah-project.md`
  (case study), `balance/2024-05-09-how-to-validate-an-email-address-in-rails.md`
  (journal). Rollout to all posts is a later pass.

## Development Workflow

Jekyll builds the site. Ruby is pinned to 3.3.6 by `.ruby-version`.

```bash
bundle install                 # once, and after Gemfile changes
bundle exec jekyll serve       # serve locally at http://localhost:4000
bundle exec jekyll build       # build to _site/ (gitignored); should emit no warnings
ruby tools/check-links.rb      # after every build; must report "Broken (site): 0"

# Deploy — push to main; GitHub Pages builds and serves automatically
git push origin main
```

In the cloud container the `jekyll` binstub can be missing; build with
`ruby -S bundle exec ruby -e 'load Gem.bin_path("jekyll","jekyll")' build`
instead (same for `serve`).

`tools/check-links.rb` walks the built `_site/` and reports every internal
`href`/`src` that points at nothing. Run it after every build: it must report
`Broken (site): 0` and exits 1 otherwise. Breaks seen only on `/components/`
pages (which link to never-built `_*.html` snippets) are listed separately as
informational. `tools/migrate_posts.rb` is the one-shot converter that turned
the served `.html` posts into `.md`; it refuses to run twice.
`tools/check-root.sh` is a helper for root pages. All three are excluded from
the build.

## Site Architecture

```
/                       # Root pages: index.html, 404.html, resume.html, robots.txt, feed.xml
├── _layouts/           # default (full page), post (adds back_link footer), section (index pages)
├── _includes/          # head, navbar, footer, scripts
├── /work/              # Portfolio pieces (index.html + 26 dated posts, 2008–2026; 6 are `published: false`)
├── /life/              # Personal/lifestyle content (index.html + 11 dated posts; 1 is `published: false`)
├── /balance/           # Wellness / thoughts content (index.html + 26 dated posts)
├── /legacy/            # Archival .md sources with no served page (excluded from build)
├── /tools/             # check-links.rb, migrate_posts.rb, check-root.sh (excluded from build)
├── /components/        # Living style guide: served, but noindex and out of the sitemap
│   ├── design-system.html  # Token + component specimens
│   ├── /posts/         # .post-* section library specimens
│   ├── /cards/         # Card variants (1x1, 2x2, featured, quote, etc.)
│   ├── /grids/         # Grid layout patterns
│   └── /modals/        # Modal component snippets
├── /images/            # All image assets (correct path is /images/, not /assets/img/)
│   ├── /favicons/      # Favicons; site.webmanifest and browserconfig.xml are static files
│   ├── /portfolio/     # Portfolio images organized by project
│   └── /posts/         # Post images
└── /docs/              # PDF/document assets (CVs, portfolios) + misc reference HTML
```

## Content: served `.md` posts, drafts, and `legacy/`

Files under `work/`, `life/`, `balance/`:

```
YYYY-MM-DD-slug-title.md        # SERVED — the live page, linked from the section index
_YYYY-MM-DD-slug-title.html     # Unlisted draft page — Jekyll skips it (leading underscore)
index.html                      # Section index (section layout, hand-written card grid)
```

- The **`.md` posts are the site.** Edit these to change what visitors see.
  Front matter keys: `layout` (post), `title`, `date`, `description`,
  `category` (work|life|balance), `permalink` (pinned to the original `.html`
  URL so inbound links keep working), plus optional `tags`, `image`,
  `back_link`, `data_category`, `head_extra`, `scripts_extra`, `footer`. The
  body is the original HTML kept raw.
- The old hand-written `YYYY-MM-DD-slug-title.html` versions of the served
  posts were deleted (commit `6a04818`); each `.md` renders to the same URL.
- The `_*.html` drafts are not linked from indexes and are not built.
- **`legacy/`** holds the archival `.md` sources that have no served page
  (draft siblings and orphans; they carry old `layout: post` front matter and
  Liquid-style tags). It is excluded from the build, kept as source material
  and as input for the `.okf/` knowledge bundle. Don't reflow or strip
  trailing whitespace in them.
- Section indexes, `index.html`, `resume.html` and `404.html` are Jekyll pages
  with front matter, rendered through the shared layouts.

### Publishing and unpublishing

To take a post down, add `published: false` to its front matter; delete the
line (or set `true`) to bring it back. Nothing else needs touching. An
unpublished post is not built, so it drops out of `site.pages`, the sitemap
and `/feed.xml`, and its URL 404s.

Everything that links to a post is guarded on that, so cards and links hide
and reappear on their own. Each page that links to dated posts (`index.html`,
the three section indexes, and any post with prev/next or related links to
another post) computes the live URLs once at the top:

```liquid
{%- assign live_urls = site.pages | map: "url" -%}
```

and wraps every card or link in a guard on the post's **absolute permalink**
(even where the `href` itself is relative):

```liquid
{%- if live_urls contains "/work/2026-08-19-sama2.html" %}
  …card or link…
{%- endif %}
```

Section indexes group cards by year. Each year is captured in `year_section`,
with its cards captured in `year_cards`, and the section is printed only if
`year_cards | strip` is non-empty, so a year whose posts are all unpublished
disappears together with its year card. A guarded prev/next link that needs to
hold its slot uses `{%- else %}<span></span>` (see
`life/2023-09-01-let-s-work-together.md`).

**Any new index card or cross-post link must use the guard.** Otherwise
unpublishing its target leaves a broken link, which `tools/check-links.rb`
will report. Status per post is tracked in `INDEKS.md`. Currently unpublished:
Sama², the four RevoTickets posts, Kakiseni Homepage Directions (work) and
Happyness Unlocked (life).

### SEO, sitemap and feed

- **jekyll-seo-tag** (in `plugins:`) emits the description, canonical, Open
  Graph, Twitter and JSON-LD tags via `{% seo title=false %}` in
  `_includes/head.html`; `title=false` keeps the hand-written `<title>`, and
  there is no separate description meta any more. `_config.yml` sets `author`
  as a hash (`name`, `twitter`) so `twitter:creator` is the handle, `lang: en`,
  `locale: en_MY`, `twitter.username` and `twitter.card: summary` (the default
  image is a square icon), `logo`, and `timezone: Asia/Kuala_Lumpur`. The
  site-wide social image is a front-matter **default** (`image:` under
  `defaults`, path `""`), because seo-tag only reads `page.image`; a post's
  own `image:` wins.
- **jekyll-sitemap** builds `/sitemap.xml` from every built page. Unpublished
  posts are absent automatically. Kept out with `sitemap: false`: `components/`
  (defaults), `feed.xml` (its own front matter) and the one-byte
  `images/favicons/index.html` and `images/posts/index.html` placeholders
  (defaults).
- **`/feed.xml`** is a hand-rolled Atom feed (Liquid, `layout: null`), linked
  from the head. `jekyll-feed` is not used because it only reads `_posts` and
  these posts are pages. It takes every page in `site.pages` with a
  work/life/balance `category` and a `date`, sorts newest first on a
  `YYYYMMDDHHMM|url` key (front-matter dates are a mix of YAML dates and
  strings), and keeps 20 entries.
- **Favicons** from `/images/favicons/` (icon PNGs, `favicon.ico`,
  apple-touch-icon, mask icon, `site.webmanifest`, `browserconfig.xml`,
  theme colour `#201A2B`) are linked in `_includes/head.html`.
- **`robots.txt`** allows all crawlers and carries
  `Sitemap: https://rudzainy.com/sitemap.xml`.

### Housekeeping decisions

- `.idea/` is in `.gitignore` and untracked.
- `_config.yml` also excludes `mise.toml` (local toolchain pin) and
  `docs/20250905_windsurf_global_rules.html` (internal AI-rules file).
- `LICENSE` stays published: the footer's copyright mark links to `/LICENSE`.
- `components/` stays served as the living style guide but is kept out of
  search: each page carries `<meta name="robots" content="noindex">` and the
  folder is `sitemap: false`.

## Key Files

| File | Purpose |
|------|---------|
| `index.html` | Homepage — bento-box grid of Work / Life / Balance cards |
| `si-es-es.css` | Custom styles + design tokens (see below) |
| `jei-es.js` | Quote randomizer, card auto-scroll with edge fades, the `hackering()` easter-egg modal, SmartImage fallback |
| `_config.yml` | Site title/URL/description; seo-tag settings (`author`, `lang`, `locale`, `twitter`, `logo`, `timezone`); `plugins:` (jekyll-seo-tag, jekyll-sitemap); the `exclude:` list (internal docs, `Gemfile*`, `tools/`, `legacy/`, `mise.toml`, the windsurf rules file); `defaults` (site-wide social `image`, `sitemap: false` for `components/` and placeholder pages) |
| `feed.xml` | Hand-rolled Atom feed over `site.pages` (20 newest posts) |
| `robots.txt` | Allows crawling; points at `/sitemap.xml` |
| `tools/check-links.rb` | Internal broken-link checker for `_site/`; run after every build |
| `Gemfile` / `.ruby-version` | `github-pages` gem; Ruby 3.3.6 |
| `_layouts/`, `_includes/` | Shared page chrome |
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

**Navbar category links.** `nav-work`, `nav-life` and `nav-balance` in
`_includes/navbar.html` take their category ink (`--color-*-ink`, via a
per-link `--nav-cat`) on hover and focus-visible, and are `.active` on their
section index and on every post in that section, with a 2px underline at the
`lg` breakpoint and up. `.active` is driven by `cat` in `_layouts/default.html`
(the page's `category`, else the first URL segment); `aria-current="page"` is
set only on the section index itself.

## JavaScript Notes

`jei-es.js` holds three quote arrays (`quotesWork`, `quotesLife`,
`quotesBalance`) that rotate a random quote every few seconds on the respective
section cards. It also auto-scrolls overflowing cards (with top/bottom fade
masks updated on resize), defines `hackering()` — the homepage easter-egg modal
that unlocks hidden links when `#answer` matches a word in `ansArray` — and
ends with the SmartImage `error` listener that swaps a broken `img[data-fallback]`
for the striped placeholder. It loads as a plain script, not a module.

## EditorConfig

Enforced for served HTML/CSS/JS: LF line endings, UTF-8, 2-space indentation,
trimmed trailing whitespace, final newline. **Exception:** `.md` files are
**exempt from trailing-whitespace trimming** — never reflow or strip trailing
whitespace in the legacy `.md` sources.
