# Editorial Gap Report — rudzainy.com

Per-post status across all 82 legacy `.md` sources, generated from a scan of
body length, front-matter completeness, and whether referenced images exist on
disk. This is the map for the editorial pass (Phase C): it shows exactly what
needs the owner's hand. Nothing here is fabricated — thin/empty posts are
flagged, not filled, until you approve drafted copy.

**Legend** — `EMPTY`: no body. `THIN`: under ~45 words. `NO-FM`: missing Jekyll
front matter. `OK`: has real content. Flags: 🖼️ image file missing · 🏷️ no
category · 📝 no description · 🚧 `published: false`.

## Summary

- **82** posts total — OK: **46**, THIN: **30**, EMPTY: **2**, NO-FM: **4**
- **30** drafts (`published: false`)
- **13** missing category · **47** missing description · **39** missing image field
- **13** posts point at an image file that does not exist on disk

## 1. Empty — need copy written (owner)

No body at all. Draft structure/tone only after style approval; leave facts to you.

- `life/2022-03-19-happyness-unlocked.md` — “Happyness Unlocked”
- `life/2022-09-15-maya.md` — “Maya”

## 2. Missing front matter — needs headers added

These lack Jekyll front matter. Two are already full case studies (just need
title/date/category/etc. added); the notes files need a decision on whether they
are posts at all.

- `work/2025-09-10-interview-questions-and-answers.md` — 1893w of content, no front matter
- `work/2025-09-11-day-food-catalogue.md` — 553w of content, no front matter
- `work/2025-12-28-sync.md` — 68w of content, no front matter
- `work/2025-12-28-tenggelam.md` — 1535w of content, no front matter

## 3. Thin — candidates for expansion (owner)

Under ~45 words of body. Many are intentional short-form (quotes, dev-note
snippets); others are stubs. Owner decides which to grow.

| Post | Words | Category | Flags |
|------|------:|----------|-------|
| `balance/2017-07-09-self-improvement.md` | 6 | Balance | 📝 |
| `balance/2023-11-02-16-384.md` | 11 | Balance | 🖼️ 📝 |
| `balance/2024-01-11-rails-image-tag.md` | 11 | — | 🏷️ 📝 🚧 |
| `balance/2024-01-22-rails-7-dropdown-image.md` | 11 | — | 🏷️ 📝 🚧 |
| `balance/2024-02-25-tutorial-ruby-on-rails.md` | 11 | Work | 📝 🚧 |
| `balance/2020-07-11-thoughts-explosion.md` | 14 | Balance | 🖼️ 📝 |
| `balance/2024-01-11-rails-drag-and-drop.md` | 17 | — | 🏷️ 📝 🚧 |
| `balance/2024-03-16-setup-python-3-on-macos.md` | 18 | Work | 📝 🚧 |
| `balance/2024-03-16-tutorial-generate-qr-for-wifi.md` | 18 | Work | 📝 🚧 |
| `balance/2024-05-09-how-to-validate-an-email-address-in-rails.md` | 19 | Balance | 🚧 |
| `balance/2019-12-30-teater-neon.md` | 20 | Life | 📝 🚧 |
| `balance/2020-02-24-melihat.md` | 28 | Balance | 📝 |
| `balance/2013-09-25-jantan.md` | 30 | Balance | 📝 |
| `balance/2023-12-26-pape-roger.md` | 31 | — | 🏷️ 📝 🚧 |
| `balance/2024-01-09-ux-review-decathlon-sports-shop.md` | 34 | — | 🏷️ 📝 🚧 |
| `balance/2024-03-27-why-rigid-corporate-structure-is-bad-for-me.md` | 36 | Balance | 📝 🚧 |
| `balance/2009-08-24-tm-parody-ad.md` | 37 | Life | — |
| `balance/2024-05-01-an-observation-on-recording-screen-and-editing-the-video-on-iphone.md` | 39 | Balance | — |
| `balance/2019-04-24-orang-kasar.md` | 41 | Life | 🖼️ 📝 |
| `balance/2015-09-25-hearts.md` | 42 | Balance | 📝 |
| `life/2024-01-13-krabi-logs.md` | 5 | — | 🏷️ 🚧 |
| `life/2019-06-08-railway-market.md` | 14 | Balance | 📝 |
| `life/2017-05-02-baloons-over-bagan.md` | 15 | Balance | 📝 |
| `life/2023-12-13-1001-inventions.md` | 17 | — | 🏷️ 📝 🚧 |
| `life/2023-12-12-of-death.md` | 25 | — | 🏷️ 📝 🚧 |
| `work/2012-09-01-maritime-college-corporate-branding.md` | 19 | Work | 📝 |
| `work/2017-09-01-eezeejob.md` | 22 | Work | 📝 |
| `work/2010-09-01-marliyati-froz-logo.md` | 23 | Work | 🖼️ 📝 |
| `work/2019-09-01-dxc-bionix-central.md` | 28 | Work | 🖼️ |
| `work/2018-09-01-postco-email-design.md` | 39 | Work | 📝 |

## 4. Missing image files

Front matter references an image that is not present under `/images/`. Either
the asset needs adding or the reference should be cleared.

- `balance/2019-04-24-orang-kasar.md` → `https://blog.rudzainy.my/blog/wp-content/uploads/2023/70749792_10156914013949545_8267946219578327040_n.jpg`
- `balance/2020-07-11-thoughts-explosion.md` → `https://blog.rudzainy.my/blog/wp-content/uploads/2023/B87FFB01-B568-489B-8B6A-75A632C8BD76.jpeg`
- `balance/2023-11-02-16-384.md` → `https://blog.rudzainy.my/blog/wp-content/uploads/2023/2048.png`
- `balance/2024-04-06-reactjs-and-rails-the-hoojah.md` → `https://res.cloudinary.com/rudzainy/image/upload/v1687145994/User-Show-Votes_kfjcf1.png`
- `life/2022-09-15-maya.md` → `https://blog.rudzainy.my/blog/wp-content/uploads/2023/`
- `work/2010-09-01-marliyati-froz-logo.md` → `https://blog.rudzainy.my/blog/wp-content/uploads/2019/05/mf.jpg`
- `work/2011-09-01-malaysia-maritime-association-logo-website.md` → `https://blog.rudzainy.my/blog/wp-content/uploads/2019/05/pemm-web-1.jpg`
- `work/2017-09-01-design-review-jkm-web-portal.md` → `https://res.cloudinary.com/rudzainy/image/upload/v1687147294/jkm-new_dukca5.png`
- `work/2018-09-01-lkim-fish-price-app.md` → `https://blog.rudzainy.my/blog/wp-content/uploads/2022/01/Screenshot-2022-01-27-at-3.11.13-PM-1-2048x890.jpg`
- `work/2019-09-01-dxc-bionix-central.md` → `https://blog.rudzainy.my/blog/wp-content/uploads/2023/2e2a0a175212223.64afa37f9c39d.png`
- `work/2019-09-01-dxc-bionix-design-system.md` → `https://blog.rudzainy.my/blog/wp-content/uploads/2022/06/Screenshot-2022-06-21-at-8.38.24-PM-2048x1124.png`
- `work/2020-09-01-the-hoojah-project.md` → `/images/posts/hoojah/thumbnail-hoojah.jpg`
- `work/2022-09-01-flip-down-numbers-and-characters.md` → `https://blog.rudzainy.my/blog/wp-content/uploads/2023/flip-number-file-cover.png`

## 5. Metadata gaps on otherwise-complete posts

Posts with real content but missing `category` or `description` (matters for the
OKF bundle and any future listing/SEO).

| Post | 🏷️ cat | 📝 desc |
|------|:---:|:---:|
| `balance/2016-09-01-kontact-web-crm-system.md` | ok | missing |
| `balance/2020-09-01-not-the-stage-manager-for-sudirmania.md` | ok | missing |
| `balance/2023-08-17-of-workshops.md` | ok | missing |
| `balance/2023-11-29-of-mlbb.md` | ok | missing |
| `balance/2023-12-04-users-vs-corporations-in-digital-communication.md` | ok | missing |
| `balance/2023-12-31-current-state-of-malaysia.md` | ok | missing |
| `balance/2024-03-23-add-diagram-on-websites-using-mermaidjs.md` | ok | missing |
| `life/2021-01-03-kenapa-rudzainy-buat-hoojah.md` | ok | missing |
| `life/2024-01-03-of-books.md` | ok | missing |
| `life/2024-01-03-of-video-games.md` | ok | missing |
| `work/2008-09-01-jkm-web-portal.md` | ok | missing |
| `work/2009-08-06-altfa-solution-logo.md` | ok | missing |
| `work/2011-09-01-malaysia-maritime-association-logo-website.md` | ok | missing |
| `work/2017-09-01-design-review-jkm-web-portal.md` | ok | missing |
| `work/2023-05-18-slide-to-select.md` | ok | missing |
| `work/2024-02-21-how-i-build-a-dynamic-system-for-syedewa-using-notion.md` | ok | missing |

---

*Generated during Phase C of the cleanup/overhaul-and-okf branch. Regenerate by
re-running the editorial audit after content changes.*
