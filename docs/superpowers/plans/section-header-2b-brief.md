# Section Header 2B — architecture brief (input for the architect)

## The design being implemented

From the Claude Design project `Section Header Studies.dc.html`, option **2b "Rule tab"**:

> The hairline gets promoted: a solid tab sits on a 2px rule like a file divider,
> so the line clearly opens the section instead of closing the last one.

Reference markup as designed (inline styles, category vars supplied by the canvas):

```html
<div>
  <div style="display: inline-flex; align-items: center; gap: 9px; padding: 6px 14px 5px;
              background: var(--cat-base, #2A4BA0); border-radius: 6px 6px 0 0;
              font-family: 'Unica One', sans-serif; text-transform: uppercase;
              letter-spacing: 0.05em; font-size: 13px; color: #fff;">
    <i class="icon-flask-conical" aria-hidden="true" style="font-size: 14px;"></i>
    <span>07 &middot; before it ships</span>
  </div>
  <div style="height: 2px; background: var(--cat-base, #2A4BA0);"></div>
  <h2 style="margin: 18px 0 0; max-width: 26ch; font-family: 'Unica One', sans-serif;
             text-transform: uppercase; letter-spacing: 0.05em; font-weight: 400;
             font-size: 2.25rem; line-height: 1.12; color: var(--cat-ink, #24408B);
             text-shadow: 1px 1px 0 rgba(0,0,0,0.3); text-wrap: balance;">
    What I'd test before shipping any of it
  </h2>
</div>
```

Category palette the canvas fed it (identical to the site's own tokens):

| category | `--cat-base` | `--cat-ink` | `--cat-subtle` | `--cat-border` |
|---|---|---|---|---|
| work    | `#2A4BA0` | `#24408B` | `#E5E8F4` | `#BEC7E6` |
| life    | `#1E7A54` | `#196045` | `#E1F0E9` | `#BADCCB` |
| balance | `#C56A12` | `#8F4E10` | `#F7E9D8` | `#EACDA6` |

## Owner's decisions (already made — do not re-litigate)

1. **Tab content:** posts where all three read naturally get **number + icon + kicker**
   (`⚗ 07 · before it ships`). Everything else gets **number + icon** (`⚗ 07`).
   The architect defines the rule that decides which is which.
2. **Scope:** the 20 served posts under `work/`, `life/`, `balance/` that carry
   in-body `<h2>`s; plus `life/2023-09-01-let-s-work-together.html`; plus a
   *specimen* (not a restyle) on `components/design-system.html`.
   **`resume.html` is explicitly out of scope** — leave `.rz-section-head` alone.
3. Posts with no `<h2>` at all (32 files) are untouched. No content restructuring.

## Site facts the design must survive

- **No build step.** Hand-written HTML + `si-es-es.css` + Bootstrap 5.3.8 CDN +
  Lucide icon font. What is edited is what ships.
- **`--cat-*` has no `:root` fallback.** `si-es-es.css:768-771` defines
  `--cat-base/-ink/-subtle/-border` only under `[data-category="work|life|balance"]`.
  11 of the h2-bearing files never set `data-category`, so any `var(--cat-*)` rule
  renders colourless there. This must be resolved.
- **Category colour today comes from `.page-header-*`, not `data-category`.**
  `si-es-es.css:639-668` keys in-post heading colour off
  `body:has(.page-header-work|life|balance)`. That class *is* universally present
  on all 57 served posts. `data-category` is not.
- **Two incompatible page shapes:**
  - *Case study* (4 files, `work/`): `<main style="max-width:1140px;…">` with **no
    `.container`**, alternating narrow `<article style="max-width:var(--measure)">`
    prose blocks and full-width sibling `.post-*` divs. H2s carry ~300 chars of
    **inline style** which beats any class rule on specificity — must be stripped.
  - *Journal/prose* (16 files): everything inside one
    `<main class="container my-5"> <article class="post-content">`. H2s are bare.
- **Existing heading rules that will interact:** `si-es-es.css:115-130` (display
  font, uppercase, tracking, `--type-h2`), `:122-124` (`text-shadow:
  var(--shadow-heading)` on every h1/h2), `:639-668` (category ink +
  `--shadow-heading-sub`), `:707-713` (margin rhythm on
  `main.container > article.post-content h2`).
- **Relevant tokens already in `:root`:** `--font-display`, `--tracking-display`,
  `--type-h2`, `--measure` (42rem), `--shadow-heading-sub`
  (`1px 1px 0 rgba(0,0,0,0.3)`), `--radius-md`, the `--space-*` scale.
- **`life/2023-09-01-let-s-work-together.html`** is a one-off landing page with its
  own `<style>` block (lines 17-223), `<main id="lwt">`, six `#lwt h2 .lead-in`
  kicker headers, and **one h2 sitting on a dark ground** — needs an inverse variant.
- **Duplicate content:** `work/2024-05-26-ux-assignment-1.html` and
  `work/2025-07-26-ux-assignment-1.html` are the same post at two dates with
  identical h2 ids. Whatever is done to one is mirrored on the other.
- **EditorConfig:** LF, UTF-8, 2-space indent, trimmed trailing whitespace, final
  newline for served HTML/CSS/JS.
- **Voice:** any kicker copy is authored in the owner's voice via the
  `write-like-me` skill. Casual, playful, first person. **Never use an em-dash.**

## Files carrying in-body h2s (the rollout set)

**Pattern A — inline-styled flex h2 + icon + hairline (must strip inline styles):**
```
work/2019-09-01-dxc-bionix-central.html          4 h2
work/2020-09-01-the-hoojah-project.html          5 h2
work/2025-09-11-day-food-catalogue.html         12 h2
work/2026-08-11-diveos.html                      7 h2
```

**Pattern B/C — bare h2:**
```
work/2017-09-01-design-review-jkm-web-portal.html                        5 h2
work/2024-05-26-ux-assignment-1.html                                     5 h2
work/2025-07-26-ux-assignment-1.html                                     5 h2
life/2023-12-04-of-maritime-academy.html                                 8 h2
life/2024-01-03-of-video-games.html                                      8 h2
life/2024-01-06-of-javascript.html                                       5 h2
life/2024-01-03-of-books.html                                            3 h2
balance/2024-09-05-the-framework.html                                    8 h2
balance/2023-12-04-users-vs-corporations-in-digital-communication.html   7 h2
balance/2023-12-23-ranting.html                                          7 h2
balance/2024-06-16-an-answer-to-the-question-of-windows-vs-macos.html    7 h2
balance/2023-12-25-restarting-postgres-for-rails-on-macos.html           3 h2
balance/2016-05-19-browsercrush-clone.html                               1 h2
balance/2019-04-24-orang-kasar.html                                      1 h2
balance/2024-05-09-how-to-validate-an-email-address-in-rails.html        1 h2
balance/2024-03-23-add-diagram-on-websites-using-mermaidjs.html          2 h2
```

**Bespoke:**
```
life/2023-09-01-let-s-work-together.html                                 6 h2 (kicker spans, one on dark)
```

**Files missing `data-category` but carrying h2s** (11): the three
`work/*ux-assignment*` + `design-review-jkm`, `life/2023-12-04-of-maritime-academy`,
`life/2024-01-06-of-javascript`, `balance/2016-05-19-browsercrush-clone`,
`balance/2019-04-24-orang-kasar`, `balance/2023-12-23-ranting`,
`balance/2023-12-25-restarting-postgres-for-rails-on-macos`,
`balance/2024-06-16-an-answer-to-the-question-of-windows-vs-macos`,
`balance/2024-09-05-the-framework`.
