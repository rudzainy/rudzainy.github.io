# Batik DS Rollout + Technical-Content Pass — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Port the Batik Design System handoff (dot backgrounds, post-section template library, SmartImage, case-study/journal-post/section-index page templates) into the live no-build site, and draft the technical/work thin & empty posts — applied to the 3 section indexes + 9 exemplar posts.

**Architecture:** No build step. Translate the handoff's React/`x-dc` templates (computed inline styles) into reusable `si-es-es.css` classes + Bootstrap 5.3.8 HTML. Foundation CSS/JS is edited serially (shared files); content drafts and per-post template application fan out in parallel (independent files).

**Tech Stack:** HTML5, Bootstrap 5.3.8 (CDN), `si-es-es.css` (design tokens + house styles), `jei-es.js` (vanilla JS), Lucide `icon-*` (UI glyphs) + Simple Icons `brand-*` (brand marks).

**Reference (read-only, gitignored):** `docs/.batik-handoff-ref/batik-design-system/project/` — the pixel-perfect source. Key subpaths:
- `tokens/backgrounds.css` — dot-field tokens
- `templates/<name>/<Name>.dc.html` — each page/section template (translate the markup between `<x-dc>…</x-dc>`, resolving `--cat-*` vars per category)
- `components/media/SmartImage.jsx` — placeholder behaviour
- `assets/` — `avatar.png`, `portfolio-dayfood-featured.png`, `portfolio-hoojah-user.png`, `wau-pinned-tab.svg`, `yolo.gif`
- `ui_kits/rudzainy-com/PostPage.jsx` — target post-page composition

**Category resolution table** (apply when translating `var(--cat-*)`):
| category | base | ink | subtle | border |
|---|---|---|---|---|
| work | `#2A4BA0` | `#24408B` | `#E5E8F4` | `#BEC7E6` |
| life | `#1E7A54` | `#196045` | `#E1F0E9` | `#BADCCB` |
| balance | `#C56A12` | `#8F4E10` | `#F7E9D8` | `#EACDA6` |

Callout tint (all categories): bg `#F7E9D8`, border `#EACDA6`, ink `#8F4E10`.

**Icon mapping:** `icon-github` → `brand-github`; Behance → `brand-behance`; keep `icon-external-link` (Lucide) for generic; category glyphs Work `icon-pencil-ruler`, Life `icon-sun`, Balance `icon-mountain`. Never `bi-*`.

**Global verification helpers** (run from repo root):
- Serve: `ruby -run -e httpd . -p 8000` then curl/inspect.
- Icon guard: `grep -rn 'bi-[a-z]' work life balance components index.html 404.html si-es-es.css` → expect no matches.
- Trailing-ws guard (served files only, not `.md`): `grep -rnE ' +$' si-es-es.css jei-es.js <touched .html>` → expect none.
- Final newline: `tail -c1 <file> | od -An -c` → expect `\n`.

---

## Phase 1 — CSS + JS foundation (SERIAL — shared files)

### Task 1: Copy handoff assets into the repo

**Files:**
- Create: `images/avatar.png`, `images/avatar-192.png`, `images/wau-pinned-tab.svg`, `images/posts/dayfood/portfolio-dayfood-featured.png`, `images/posts/hoojah/portfolio-hoojah-user.png`

- [ ] **Step 1: Copy assets**

```bash
cd /Users/deepsight/code/rudzainy.github.io
REF=docs/.batik-handoff-ref/batik-design-system/project/assets
mkdir -p images/posts/dayfood images/posts/hoojah
cp "$REF/avatar.png" images/avatar.png
cp "$REF/avatar-192.png" images/avatar-192.png
cp "$REF/wau-pinned-tab.svg" images/wau-pinned-tab.svg
cp "$REF/portfolio-dayfood-featured.png" images/posts/dayfood/portfolio-dayfood-featured.png
cp "$REF/portfolio-hoojah-user.png" images/posts/hoojah/portfolio-hoojah-user.png
```

- [ ] **Step 2: Verify**

Run: `ls -1 images/avatar.png images/wau-pinned-tab.svg images/posts/dayfood/*.png images/posts/hoojah/*.png`
Expected: all five listed, non-zero size.

- [ ] **Step 3: Commit**

```bash
git add images/avatar.png images/avatar-192.png images/wau-pinned-tab.svg images/posts/dayfood images/posts/hoojah
git commit -m "Add Batik DS image assets (avatar, wau mark, portfolio featured)"
```

### Task 2: Dot-background tokens + utilities

**Files:**
- Modify: `si-es-es.css` (append a new `/* === Dot backgrounds === */` block after the existing `:root` tokens)
- Reference: `docs/.batik-handoff-ref/batik-design-system/project/tokens/backgrounds.css`

- [ ] **Step 1: Add tokens + utility classes**

Copy the three `--bg-dots-work/life/balance` values **verbatim** from the reference `tokens/backgrounds.css` (they are long data-URI SVGs — do not retype by hand; read and paste exactly). Add to `:root`:

```css
/* === Dot backgrounds (Batik) — headers + subtle section tints only === */
:root {
  --bg-dot-size: clamp(5px, 0.486vw, 9px); /* 7px @ 1440px */
  --bg-dot-tile: calc(var(--bg-dot-size) * 48);
  /* --bg-dots-work/life/balance: paste verbatim from tokens/backgrounds.css */
}
.bg-dots-work    { background: var(--bg-dots-work);    background-size: var(--bg-dot-tile) var(--bg-dot-tile); }
.bg-dots-life    { background: var(--bg-dots-life);    background-size: var(--bg-dot-tile) var(--bg-dot-tile); }
.bg-dots-balance { background: var(--bg-dots-balance); background-size: var(--bg-dot-tile) var(--bg-dot-tile); }
```

Note: the dot data-URIs already embed a subtle tint fill; on the coloured page-header band, layer the dots over the category colour by putting `.bg-dots-*` on an inner subtle-tint element, not the vivid band itself (see Task 9 usage). On white/tinted section blocks apply directly.

- [ ] **Step 2: Verify tokens resolve**

Run: `grep -c 'bg-dots-work' si-es-es.css` → expect ≥ 2 (token + class). Confirm no literal `undefined`/truncated URI: `grep -o "url('data:image/svg" si-es-es.css | wc -l` → expect 3.

- [ ] **Step 3: Commit**

```bash
git add si-es-es.css && git commit -m "Add Batik dot-background tokens + utilities"
```

### Task 3: Section category-tweak variables

**Files:**
- Modify: `si-es-es.css`

- [ ] **Step 1: Add per-category tweak vars scoped to a `data-category` hook**

```css
/* === Section category tweak (drives post-body components) === */
[data-category="work"]    { --cat-base:#2A4BA0; --cat-ink:#24408B; --cat-subtle:#E5E8F4; --cat-border:#BEC7E6; }
[data-category="life"]    { --cat-base:#1E7A54; --cat-ink:#196045; --cat-subtle:#E1F0E9; --cat-border:#BADCCB; }
[data-category="balance"] { --cat-base:#C56A12; --cat-ink:#8F4E10; --cat-subtle:#F7E9D8; --cat-border:#EACDA6; }
```

Post pages set `data-category` on `<body>` (or `<main>`), so every `.post-*` block inherits the right hue. This coexists with the existing `page-header-*` classes.

- [ ] **Step 2: Verify**

Run: `grep -c 'data-category=' si-es-es.css` → expect 3.

- [ ] **Step 3: Commit**

```bash
git add si-es-es.css && git commit -m "Add per-category tweak vars for post-body components"
```

### Task 4: SmartImage — CSS placeholder + JS onerror handler

**Files:**
- Modify: `si-es-es.css`, `jei-es.js`
- Reference: `docs/.batik-handoff-ref/batik-design-system/project/components/media/SmartImage.jsx`

- [ ] **Step 1: Add `.smart-image` CSS**

```css
/* === SmartImage: framed lazy image with songket-stripe fallback === */
.smart-image { display:block; width:100%; overflow:hidden; border-radius:var(--radius-md); border:1px solid var(--color-neutral); background:var(--color-surface); box-sizing:border-box; }
.smart-image img { display:block; width:100%; object-fit:cover; object-position:top; transition:transform var(--motion-slow) var(--ease); }
.smart-image.is-zoom:hover img { transform:scale(var(--motion-zoom)); }
.smart-image-placeholder { display:flex; align-items:center; justify-content:center; aspect-ratio:16/10; border-style:dashed;
  background:repeating-linear-gradient(45deg,#EFE9DB 0 10px,#F6F2E9 10px 20px); }
.smart-image-placeholder .label { font-family:var(--font-mono, ui-monospace,SFMono-Regular,Menlo,monospace); font-size:.78rem; color:var(--color-muted);
  background:rgba(255,255,255,.9); border:1px solid var(--color-neutral); border-radius:4px; padding:3px 10px; max-width:85%; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
@media (prefers-reduced-motion: reduce) { .smart-image.is-zoom:hover img { transform:none; } }
```

Markup contract for authors: `<span class="smart-image is-zoom"><img src="…" alt="…" loading="lazy" data-fallback="drop screenshot · label"></span>`. If `src` is missing/empty, author instead writes the placeholder directly: `<span class="smart-image smart-image-placeholder"><span class="label">drop screenshot · label</span></span>`.

- [ ] **Step 2: Add onerror handler to `jei-es.js`**

Append a small IIFE that, on `img.error` inside `.smart-image`, replaces the frame content with the striped placeholder using `img`'s `data-fallback` (or `alt`) as the label:

```js
// SmartImage: swap failed images for the songket-stripe placeholder
(function () {
  function toPlaceholder(img) {
    var frame = img.closest('.smart-image');
    if (!frame) return;
    var label = img.getAttribute('data-fallback') || img.getAttribute('alt') || 'image';
    frame.classList.add('smart-image-placeholder');
    frame.setAttribute('role', 'img');
    frame.setAttribute('aria-label', label);
    frame.innerHTML = '<span class="label"></span>';
    frame.querySelector('.label').textContent = label;
  }
  document.addEventListener('error', function (e) {
    var t = e.target;
    if (t && t.tagName === 'IMG' && t.closest('.smart-image')) toPlaceholder(t);
  }, true); // capture: image error events don't bubble
})();
```

- [ ] **Step 3: Verify locally**

Run: `ruby -run -e httpd . -p 8000 &` then create a throwaway `components/posts/_smartimage-test.html` with one good image and one `src="/images/does-not-exist.png"`, open it, confirm the broken one renders the dashed striped placeholder with the label text. Delete the throwaway after. `curl -s localhost:8000/jei-es.js | grep -c smart-image` → expect ≥1.

- [ ] **Step 4: Commit**

```bash
git add si-es-es.css jei-es.js && git commit -m "Add SmartImage striped-placeholder CSS + onerror handler"
```

---

## Phase 2 — Post-section snippet library (SERIAL — shared `si-es-es.css`)

### Task 5: Port the 12 post-section patterns to `si-es-es.css`

**Files:**
- Modify: `si-es-es.css` (new `/* === Post-body sections === */` region)
- Reference: `docs/.batik-handoff-ref/batik-design-system/project/templates/post-*/Post*.dc.html`

For EACH pattern below, translate the reference `.dc.html` body (between `<x-dc>`) into a `si-es-es.css` class, replacing inline styles with the class and resolving `--cat-*` through the Task 3 vars. `style-hover`/`style-active` become `:hover`/`:active` rules. Keep exact spacing/measure/shadow values.

- [ ] **Step 1: Add classes** (one per pattern — implement all 12):
  - `.post-figure` (ref `post-figure`) — `<figure>` max-width 56rem centered, SmartImage, centered italic `figcaption` max 42rem.
  - `.post-gallery` (ref `post-gallery`) — grid `repeat(var(--gallery-cols,2),1fr)` gap 16px, max 66rem; figures with centered captions.
  - `.post-before-after` (ref `post-before-after`) — 2-col grid, `Before` (muted, `icon-history`) vs `After` (`--cat-ink`, `icon-sparkles`) labels, SmartImages ratio 4/3.
  - `.post-pull-quote` (ref `post-pull-quote`) — max 50rem centered, hairline `--cat-border` top+bottom, italic `clamp(1.5rem,1.2rem+1.6vw,2.1rem)` `--cat-ink`, Unica One em-dash attribution.
  - `.post-callout` + `.is-note/.is-warning/.is-tip` (ref `post-callout`) — max 42rem, callout tint, Unica One header row with variant icon+label; default note icon `icon-info`, warning `icon-alert-triangle`/label WARNING, tip `icon-lightbulb`/label TIP.
  - `.post-meta-table` (ref `post-meta-table`) — `<dl>` max 42rem, white card, 170px/1fr rows, Unica One `--cat-ink` `<dt>`, link buttons.
  - `.post-embed` (ref `post-embed`) — white card max 56rem, header (category-base source tag + truncated mono link + external-link button), `aspect-ratio:16/9` iframe on `--cat-subtle`.
  - `.post-code` (ref `post-code`) — aubergine `#201A2B` block radius 8px max 48rem, header (mono filename + Unica One `--cat-border` lang tag), `<pre><code>` cream mono.
  - `.post-steps` (ref `post-steps`) — max 42rem, vertical rail (`--cat-border`), numbered `--cat-base` chips, Unica One `--cat-ink` H3.
  - `.post-stats` (ref `post-stats`) — white card max 56rem, `repeat(4,1fr)` divided, Unica One poster-shadow numbers `--cat-ink`, uppercase muted labels.
  - `.post-nav` (ref `post-nav`) — 2-col max 46rem, hover-lift/press-sink cards, prev (`icon-arrow-left`) / next (`icon-arrow-right`, right-aligned, `--cat-ink`).
  - `.post-related` (ref `post-related`) — "more of X" Unica One heading (muted lead-in + `--cat-ink` poster-shadow subject) + a horizontal card scroller of content cards ending in the arrow button card (reuse existing card/scroller classes already in `si-es-es.css`; add only what's missing).

All wrapping `<section>`s: `max-width:1140px; margin:0 auto; padding:32px 24px`.

- [ ] **Step 2: Verify each class exists**

Run: `for c in post-figure post-gallery post-before-after post-pull-quote post-callout post-meta-table post-embed post-code post-steps post-stats post-nav post-related; do grep -q "\.$c" si-es-es.css && echo "ok $c" || echo "MISSING $c"; done`
Expected: 12 × `ok`.

- [ ] **Step 3: Commit**

```bash
git add si-es-es.css && git commit -m "Port 12 Batik post-body section patterns to si-es-es.css"
```

### Task 6: Living style-guide page for the post sections

**Files:**
- Create: `components/posts/index.html`
- Reference: existing `components/index.html` for page chrome/pattern.

- [ ] **Step 1: Build the page** — site navbar + footer, `data-category="work"` on a wrapper, one titled specimen per Task-5 pattern using real placeholder content, each with a copy-pasteable code sample (following how `components/index.html` documents existing patterns). Add a link to it from `components/index.html`.

- [ ] **Step 2: Verify**

Run: serve, open `localhost:8000/components/posts/`, confirm all 12 patterns render with correct category colours; toggle a wrapper to `data-category="balance"` and confirm hues switch. Icon guard + trailing-ws guard on the new file.

- [ ] **Step 3: Commit**

```bash
git add components/posts/index.html components/index.html && git commit -m "Add post-section pattern style guide"
```

---

## Phase 3 — Technical/work content drafts (PARALLEL — independent `.md` files)

> Each task edits ONE `.md` source only. `.md` files are EXEMPT from trailing-whitespace trimming — do not reflow. Preserve existing front-matter markers. Add missing `category`/`description`. Keep house voice: first-person, casual, playful, Malay woven in, `DD.MM.YYYY` dates, uppercase short labels, emoji sparingly. Tier B: invent NO specific facts (metrics, client specifics) — mark unknowns with `<!-- DRAFT: owner to confirm -->`.

### Task 7: Tier A technical tutorials (7 posts)

**Files (each edited independently; may be split across parallel subagents):**
- Modify: `balance/2024-01-11-rails-image-tag.md`
- Modify: `balance/2024-01-22-rails-7-dropdown-image.md`
- Modify: `balance/2024-01-11-rails-drag-and-drop.md`
- Modify: `balance/2024-02-25-tutorial-ruby-on-rails.md`
- Modify: `balance/2024-03-16-setup-python-3-on-macos.md`
- Modify: `balance/2024-03-16-tutorial-generate-qr-for-wifi.md`
- Modify: `balance/2024-05-09-how-to-validate-an-email-address-in-rails.md`

- [ ] **Step 1: For each, read the existing stub + front matter.** Keep `published: false` unless already true. Fill `category`, `description`.
- [ ] **Step 2: Write real, correct tutorial content** — a short intro in voice, then the technical steps with fenced code blocks (```ruby / ```bash), a closing line. These are verifiable technical topics; write them fully. Aim 150–350 words each.
- [ ] **Step 3: Verify** — `head -12 <file>` shows complete front matter; body has fenced code; no accidental trailing-ws *removal* on unrelated lines (diff is additive). `grep -c '^---' <file>` → expect 2.
- [ ] **Step 4: Commit** (batch of the 7): `git add balance/2024-*.md && git commit -m "Draft Tier-A technical tutorial posts (Rails/Python/QR/email)"`

### Task 8: Tier B portfolio + NO-FM posts (10 posts)

**Files (each independent):**
- Add front matter only (bodies already complete): `work/2025-09-10-interview-questions-and-answers.md`, `work/2025-12-28-tenggelam.md`
- Front matter + light expansion: `work/2025-09-11-day-food-catalogue.md`, `work/2025-12-28-sync.md`
- Front matter + case-study scaffold + connective prose (no invented facts): `work/2017-09-01-eezeejob.md`, `work/2018-09-01-postco-email-design.md`, `work/2012-09-01-maritime-college-corporate-branding.md`, `work/2010-09-01-marliyati-froz-logo.md`, `work/2019-09-01-dxc-bionix-central.md`, `balance/2024-01-09-ux-review-decathlon-sports-shop.md`

- [ ] **Step 1:** For the two complete-body posts, add Jekyll front matter (`layout: post`, `title`, `date`, `category: Work`, `description`) matched to the existing body; change nothing else.
- [ ] **Step 2:** For scaffold posts, add front matter + section headings (`## Summary`, `## The approach`, etc.) with house-voice connective prose. Use ONLY facts present in the existing stub/front matter. Any specific metric/claim/client detail you cannot verify → `<!-- DRAFT: owner to confirm -->`.
- [ ] **Step 3: Verify** — each has 2 `^---` lines; scaffold posts contain at least one `<!-- DRAFT` marker OR are fully fact-grounded; no fabricated numbers.
- [ ] **Step 4: Commit:** `git add work/*.md balance/2024-01-09-*.md && git commit -m "Draft Tier-B portfolio case studies + add front matter to NO-FM posts"`

---

## Phase 4 — Apply templates (PARALLEL — independent `.html` files; depends on Phases 1–2)

> Each task produces ONE served `.html` from its `.md` source using the ported templates. Preserve the site's existing head (Bootstrap CDN, Lucide CSS, `si-es-es.css` link) and navbar/footer patterns from an existing served post. Set `data-category` on `<body>`. Breadcrumb + `page-header-*` band gets `.bg-dots-*` on its inner tint. Reading column `max-width:var(--measure)` (42rem). Missing images → SmartImage placeholder with a descriptive `data-fallback`.

### Task 9: Section index pages (3)

**Files:**
- Modify: `work/index.html`, `life/index.html`, `balance/index.html`
- Reference: `templates/section-index/SectionIndex.dc.html`

- [ ] **Step 1:** For each, rebuild the "all about X" bento header (back-arrow card → title card `all about <Cat>` → intro card) on a `.bg-dots-<cat>` band, then year-grouped horizontal scrollers built from the ACTUAL served posts in that section (scan the directory; group by year from the filename date; card = date label + title + one-line + "Read more" → the post's `.html`). Keep existing navbar/footer.
- [ ] **Step 2: Verify** — serve, open each index, confirm dot band renders, cards link to real posts, category hue correct, horizontal scroll works. Icon + trailing-ws guards.
- [ ] **Step 3: Commit:** `git add work/index.html life/index.html balance/index.html && git commit -m "Rebuild section index pages on Batik section-index template"`

### Task 10: Work exemplar case studies (3)

**Files:**
- Modify: `work/2020-09-01-the-hoojah-project.html` (meta-table, stats, embed, related; featured img `/images/posts/hoojah/portfolio-hoojah-user.png`)
- Modify: `work/2025-09-11-day-food-catalogue.html` (figure/gallery with `/images/posts/dayfood/portfolio-dayfood-featured.png`)
- Create: `work/2019-09-01-dxc-bionix-central.html` (before/after, steps; from the Tier-B `.md`)
- Reference: `templates/case-study/CaseStudy.dc.html`, `ui_kits/rudzainy-com/PostPage.jsx`

- [ ] **Step 1:** Build each on the case-study template: coloured header band (`.bg-dots-work` inner tint) + breadcrumb + kicker + hero title + standfirst + featured image + 4-col featured-meta strip overlapping the serif reading column; body composed from the relevant `.post-*` sections carrying content from the `.md`. Brand links use `brand-github`/`brand-behance`.
- [ ] **Step 2: Verify** — serve each, confirm meta strip overlap, iconed H2s, sections render, images load (or placeholder shows), no `bi-*`, category text uses `-ink` on white. Trailing-ws + final-newline guards.
- [ ] **Step 3: Commit:** `git add work/2020-09-01-the-hoojah-project.html work/2025-09-11-day-food-catalogue.html work/2019-09-01-dxc-bionix-central.html && git commit -m "Apply case-study template to 3 Work exemplars"`

### Task 11: Life exemplar journal posts (3)

**Files:**
- Modify: `life/2021-01-03-kenapa-rudzainy-buat-hoojah.html` (pull-quote, related)
- Modify: `life/2024-01-03-of-books.html` (figure)
- Modify: `life/2024-01-03-of-video-games.html` (callout)
- Reference: `templates/journal-post/JournalPost.dc.html`

- [ ] **Step 1:** Build each on the journal-post template: `.bg-dots-life` header band + breadcrumb + date/kicker + hero title, serif reading column, body `.post-*` sections from the `.md`. `data-category="life"`.
- [ ] **Step 2: Verify** — serve, confirm emerald hue, hero, sections, prev/next where present. Guards.
- [ ] **Step 3: Commit:** `git add life/2021-01-03-kenapa-rudzainy-buat-hoojah.html life/2024-01-03-of-books.html life/2024-01-03-of-video-games.html && git commit -m "Apply journal-post template to 3 Life exemplars"`

### Task 12: Balance exemplar journal posts (3)

**Files:**
- Modify: `balance/2024-03-23-add-diagram-on-websites-using-mermaidjs.html` (code, embed)
- Create: `balance/2024-05-09-how-to-validate-an-email-address-in-rails.html` (code, steps, callout; from Tier-A `.md`)
- Modify: `balance/2023-12-04-users-vs-corporations-in-digital-communication.html` (pull-quote, callout)
- Reference: `templates/journal-post/JournalPost.dc.html`

- [ ] **Step 1:** Build each on the journal-post template with `.bg-dots-balance` + `data-category="balance"`; bodies use the relevant `.post-*` sections from the `.md`.
- [ ] **Step 2: Verify** — serve, confirm saffron hue, code blocks render aubergine, sections correct. Guards.
- [ ] **Step 3: Commit:** `git add balance/2024-03-23-*.html balance/2024-05-09-*.html balance/2023-12-04-*.html && git commit -m "Apply journal-post template to 3 Balance exemplars"`

---

## Phase 5 — Integration verification (SERIAL)

### Task 13: Cross-cutting audit + fixes

- [ ] **Step 1: Icon guard** — `grep -rn 'bi-[a-z]' work life balance components index.html 404.html si-es-es.css` → no matches. Fix any.
- [ ] **Step 2: Gradient guard** — `grep -rn 'linear-gradient\|radial-gradient' si-es-es.css` → only the scroll-fade + SmartImage stripe (and dot SVG data-URIs). No stray gradients in the new `.html`.
- [ ] **Step 3: Contrast/semantics spot-check** — one exemplar per category: category text on white uses `-ink`; icon-only controls have `visually-hidden`/`aria-label`; figures have `figcaption`; breadcrumb has `aria-label`; `<time datetime>` present.
- [ ] **Step 4: EditorConfig** — for every touched served file: LF (`file` / `grep -lP '\r'` → none), final newline (`tail -c1 | od -An -c` → `\n`), no trailing ws (`grep -rnE ' +$'` on served files, NOT `.md`).
- [ ] **Step 5: Rendered spot-check** — serve; load home, the 3 indexes, and one exemplar per category; confirm no console errors, dot bands render, SmartImage placeholders appear for missing images, quote rotation still works.
- [ ] **Step 6: Commit any fixes** — `git commit -am "Fix audit findings from Batik DS rollout"` (if any).

### Task 14: OKF + docs note

- [ ] **Step 1:** If the OKF skill flags `.okf/` drift from the new drafted content, refresh the affected concept files (do not rebuild the whole bundle). Otherwise note that a later editorial pass will regenerate it.
- [ ] **Step 2:** Update `CLAUDE.md`'s technology-stack section only if a new convention was introduced (dot-background utilities, `.post-*` library, `data-category` hook, `.smart-image`). Keep it terse.
- [ ] **Step 3: Commit:** `git commit -am "Document Batik DS additions (post sections, dot bg, SmartImage)"`

---

## Notes for the executor

- Phases 1→2 are serial and gate Phase 4. Phase 3 (content) is independent of 1–2 and can run concurrently with them.
- Within Phases 3 and 4, tasks touch disjoint files — safe to fan out to parallel subagents.
- The handoff templates are the source of truth for pixel values; when in doubt, read the `.dc.html` rather than guessing.
- Do not commit `docs/.batik-handoff-ref/` or the zip (gitignored).
