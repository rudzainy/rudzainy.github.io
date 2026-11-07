# Status check fixes (2026-11-07)

Follow-up to the 2026-11-07 feature-complete status check. Executed task by
task with one subagent per task, reviewed between tasks. Tasks run in order
because several touch the same files (`index.html`, section indexes,
`_includes/head.html`, `CLAUDE.md`).

**Shared rules for every task**

- Read `CLAUDE.md` first. Never put a literal Liquid tag in a published `.md`
  except where the task deliberately adds Liquid logic. Never reflow `legacy/`.
- Build: `ruby -S bundle exec ruby -e 'load Gem.bin_path("jekyll","jekyll")' build`
  (the `jekyll` binstub is missing in the cloud container; locally
  `bundle exec jekyll build` works). Must emit no warnings.
- Links: `ruby tools/check-links.rb` after every build. A task may not add a
  new broken link.
- Commit as `Rudzainy <tek@rudzainy.com>`, one short summary line, no
  trailers. Do not push.

## Task 1 — Missing images, unpublish Happyness Unlocked

The Drive folder `1VveNq9w8iFPq-FZ3dIbycX94JfnFn6b_` holds only screenshots
already in `images/portfolio/hoojah/`. None of the missing files exist anywhere.

- `work/2020-09-01-the-hoojah-project.md`: remove the six figures whose image is
  missing (`poll-interface`, `poll-first-layout`, `grouped-arguments`,
  `debate-view`, `cta-buttons`, `responsive-design`). Remove the whole wrapper
  (figure, caption, gallery cell). If a gallery ends up with one image, turn it
  into a single `.post-figure`; if it ends up empty, remove it. Keep the prose.
- `life/2022-03-19-happyness-unlocked.md`: add `published: false`, remove the
  missing `/images/posts/hoojah/hoojah-1.png` reference.

## Task 2 — Indexes respect published status

Pages with `published: false`, and `_` drafts, are not in `site.pages`. Every
hand-written index card that links to a dated post is wrapped in a guard, so
republishing a post brings its card back and unpublishing hides it:

```liquid
{%- assign live_urls = site.pages | map: "url" -%}   (once, top of the page)
{% if live_urls contains "/work/2026-08-19-sama2.html" %} …card… {% endif %}
```

- Applies to `index.html`, `work/index.html`, `life/index.html`,
  `balance/index.html`. Use the absolute permalink even where the href is
  relative. A year section whose cards are all hidden must hide its whole
  section, including the year card.
- Restore the work-index cards removed in commits `d097240` and `d585fe4` (Sama²,
  RevoTickets series, Kakiseni), each inside its guard, so they reappear when
  republished.
- Homepage Sama² card: primary button goes to `https://sama2.nasiforge.com`;
  the case-study button is guarded.
- Prev/next and related links inside published posts that point at an
  unpublished post get the same guard.

## Task 3 — Housekeeping

- `.idea/` into `.gitignore`, removed from the index (`git rm -r --cached`).
- `_config.yml` `exclude:` also `mise.toml`, `LICENSE`.
- `components/` stays served (living style guide) but is kept out of search:
  `noindex` robots meta on its pages and `sitemap: false` (front matter
  defaults in `_config.yml`).
- Homepage: replace the "under construction" card with a plain Dev Logs card
  (same slot, keep the git-init timestamp and the link).
- Unlisted published posts get index cards: Website Logs (work, 2025),
  Validate an Email Address in Rails and Add Diagram on Websites using MermaidJS
  (balance, 2024), each in date order and inside a guard.

## Task 4 — Head metadata, sitemap, feed, pinned Lucide

- `jekyll-seo-tag` and `jekyll-sitemap` (both on the GitHub Pages allowlist) in
  `_config.yml` `plugins:`. `{% seo title=false %}` in `_includes/head.html`
  keeps the existing `<title>`; drop the now-duplicate description meta.
  `_config.yml`: `author`, `twitter.username: rudzainy`, `lang`, default
  social `image` (`/images/favicons/android-chrome-512x512.png`), `logo`.
- Favicons: link the existing files in `/images/favicons/` (icon PNGs,
  apple-touch-icon, manifest, theme colour, msapplication config).
- Feed: `jekyll-feed` only reads `_posts`, so add a Liquid `feed.xml` (Atom)
  over `site.pages` with a category of work/life/balance and a date, newest
  first, 20 entries. Link it from the head.
- `robots.txt`: `Sitemap: https://rudzainy.com/sitemap.xml`.
- Pin `lucide-static@1.70.0` everywhere it loads (head include and any
  standalone pages), with an SRI `integrity` hash and `crossorigin`.

## Task 5 — Docs and logs

- `CLAUDE.md`: remove the "Never add `published: false`" rule; document how
  unpublishing works (front matter flag, guarded index cards, `live_urls`),
  `tools/check-links.rb`, SEO/sitemap/feed, pinned Lucide, housekeeping
  decisions.
- `INDEKS.md`: refresh statuses (Happyness Unlocked unpublished; formerly
  unlisted posts now listed; new Balance post).
- `work/2025-09-11-website-logs.md`: entry 24 for this batch.
