# Section Header 2B "Rule tab": implementation plan

Architect's spec for the rollout. Input: `section-header-2b-brief.md` (authoritative).
Scope: 20 h2-bearing posts + the Let's-work-together landing page + a specimen on
`components/design-system.html`. `resume.html` untouched. No build step, no JS.

---

## A. The CSS block

Append verbatim to the end of `si-es-es.css` (currently 906 lines, ends after the
`.post-nav` reduced-motion rule).

**Decisions baked in:**

- **Class names:** `.post-section-head` (wrapper = tab + 2px rule), child
  `.head-tab`, modifiers `.is-inverse` (dark ground) and `.is-first` (kills the
  top margin on the first section of a case study). Fits the `.post-*` family
  and its `.is-*` modifier style (`.is-note`, `.is-next`, `.is-zoom`).
- **Structure:** the wrapper is a flex row carrying `border-bottom: 2px` (the
  rule); the tab is its only child and sits flush on the rule
  (`align-items: flex-end` plus no bottom radius). The h2 is the wrapper's
  **next sibling**, not its child: minimal diff, `id=` anchors and heading
  order untouched, and the rule spans whatever column the pair sits in.
- **`--cat-*` fallback resolution:** a CSS bridge that derives `--cat-*` from
  `body:has(.page-header-work|life|balance)`. One line per category fixes all
  57 served posts at once (the header class is universal, `data-category` is
  not), with zero per-file edits; inner `[data-category]` wrappers still win by
  custom-property proximity. (Side effect, wanted: existing `.post-*` blocks on
  the 11 no-`data-category` files stop rendering colourless.)
- **Specificity plan:** colour + `text-shadow: var(--shadow-heading-sub)` on
  the h2 are **not redeclared**; the existing `body:has(.page-header-*) main h2`
  rules (si-es-es.css:639-668, specificity 0,1,3) already supply exactly the
  values the 2B design specifies. The component only sets geometry
  (margin/measure/wrap) on the h2, using a doubled selector so the
  reading-rhythm rule `main.container > article.post-content h2` (0,2,3 at
  :707-713) is outrun by (0,3,3) without `!important`. The base
  `h1,h2 { text-shadow: var(--shadow-heading) }` (:122-124, 0,0,1) is already
  beaten by :639-668 on every post page. A `[data-category]`-scoped colour rule
  (0,2,1) covers non-post pages (the specimen).
- **Shadow decision:** the h2 keeps **`--shadow-heading-sub`**. It is the
  in-post heading convention and is byte-identical to the design reference's
  `1px 1px 0 rgba(0,0,0,0.3)`. `--shadow-heading` stays reserved for page
  titles.
- **Responsive:** no media query needed. The tab is `max-width: 100%` and its
  label wraps internally; the kicker length rule (section D) caps copy so a
  single line holds at 375px anyway. The h2's `26ch` cap and fluid
  `--type-h2` already behave at the mobile floor.
- **New tokens:** none. Everything maps to existing tokens (`--radius-sm` is
  the design's 6px, `--space-5`/`--space-2` the rhythm, `--shadow-heading-sub`
  the shadow). Fixed px values (tab padding, 13px/14px type, 18px gap) are
  hardcoded in the component exactly like the rest of the `.post-*` library.

```css
/* === Section header 2B: "Rule tab" =======================================
   The hairline promoted: a solid category tab sits on a 2px rule like a file
   divider, so the line opens the section instead of closing the last one.
   Contract: <div class="post-section-head"><span class="head-tab">…</span></div>
   immediately followed by the <h2> it introduces. Colour rides the inherited
   --cat-* vars; the bridge below guarantees they exist on every post page.
   Specimen: components/design-system.html. */

/* --cat-* bridge. The category vars at :768-771 only exist under
   [data-category], which 11 h2-bearing posts never set; .page-header-* IS on
   every served post. Derive the vars from it so no .post-* block is ever
   colourless. An inner [data-category] wrapper still overrides by proximity. */
body:has(.page-header-work)    { --cat-base: var(--color-work);    --cat-ink: var(--color-work-ink);    --cat-subtle: #E5E8F4; --cat-border: #BEC7E6; }
body:has(.page-header-life)    { --cat-base: var(--color-life);    --cat-ink: var(--color-life-ink);    --cat-subtle: #E1F0E9; --cat-border: #BADCCB; }
body:has(.page-header-balance) { --cat-base: var(--color-balance); --cat-ink: var(--color-balance-ink); --cat-subtle: #F7E9D8; --cat-border: #EACDA6; }

/* Tab + rule. Flex (not inline) so no baseline gap opens between the tab and
   the rule it sits on. Spans its container: the reading column. */
.post-section-head {
  display: flex;
  align-items: flex-end;
  margin: var(--space-5) 0 0;
  border-bottom: 2px solid var(--cat-base, var(--color-primary));
}
.post-section-head.is-first { margin-top: 0; }
.post-section-head .head-tab {
  display: inline-flex;
  align-items: center;
  gap: 9px;
  max-width: 100%;
  padding: 6px 14px 5px;
  background: var(--cat-base, var(--color-primary));
  border-radius: var(--radius-sm) var(--radius-sm) 0 0;
  font-family: var(--font-display);
  text-transform: uppercase;
  letter-spacing: var(--tracking-display);
  font-size: 13px;
  line-height: 1.3;
  color: #fff;
}
.post-section-head .head-tab i { font-size: 14px; }

/* The h2 the head introduces. Geometry only: colour and --shadow-heading-sub
   already come from body:has(.page-header-*) main h2 (si-es-es.css:639-668).
   The doubled selector (0,3,3) outruns the reading-rhythm margins at :707-713
   (0,2,3) without !important. */
.post-section-head + h2,
main.container > article.post-content .post-section-head + h2 {
  margin: 18px 0 var(--space-2);
  max-width: 26ch;
  font-weight: 400;
  line-height: 1.12;
  text-wrap: balance;
}

/* Colour for pages without a .page-header-* band (the component specimens):
   same values the post-page rules resolve to, keyed off [data-category]. */
[data-category] .post-section-head + h2 {
  color: var(--cat-ink);
  text-shadow: var(--shadow-heading-sub);
}

/* Inverse: for the one head on a dark category ground (landing-page contact
   band). Tab flips to white-on-ink, rule goes white, h2 goes white. */
.post-section-head.is-inverse { border-bottom-color: #fff; }
.post-section-head.is-inverse .head-tab { background: #fff; color: var(--cat-ink, var(--color-ink)); }
.post-section-head.is-inverse + h2 { color: #fff; text-shadow: var(--shadow-heading-sub); }
```

Notes for the CSS executor:

- Append after line 906 (after the `.post-nav` reduced-motion block), preceded
  by one blank line. LF, 2-space indent, final newline.
- Do not touch :639-668, :707-713, :768-771 or the base h1/h2 rules. The
  component is additive.
- `#lwt .lwt-contact h2` (1,1,2) intentionally still beats `.is-inverse + h2`
  on the landing page; both paint white so there is no visible conflict.

## B. Canonical markup contract

The component is **two sibling elements**. Nothing may sit between the wrapper
and its h2 (the CSS uses `+`).

**1. Number + icon + kicker**

```html
<div class="post-section-head" aria-hidden="true">
  <span class="head-tab"><i class="icon-flask-conical"></i><span>07 &middot; before it ships</span></span>
</div>
<h2 id="existing-anchor-if-any">What I'd test before shipping any of it</h2>
```

**2. Number + icon (no kicker)**

```html
<div class="post-section-head" aria-hidden="true">
  <span class="head-tab"><i class="icon-gamepad-2"></i><span>03</span></span>
</div>
<h2 id="windows-pc-games">Windows PC games</h2>
```

**3. Inverse (dark ground)**

```html
<div class="post-section-head is-inverse" aria-hidden="true">
  <span class="head-tab"><i class="icon-message-square"></i><span>06 &middot; so,</span></span>
</div>
<h2>Let's chat</h2>
```

**Rules:**

- Numbers are the h2's 1-based position in the post, zero-padded to two digits
  (`01`), counting every converted h2 including Summary/Conclusion sections.
- Separator between number and kicker is ` &middot; ` exactly. No-kicker tabs
  contain the number alone.
- **Accessibility:** the whole wrapper carries `aria-hidden="true"`. The tab is
  decorative garnish (number, glyph, kicker); the h2 alone carries the
  section's accessible name. No separate `aria-hidden` needed on the `<i>`.
  The h2 keeps its existing `id=` anchor byte-for-byte where one exists (all
  prose posts have them; the 4 case studies have none, verified). Heading
  order is unchanged: the wrapper is a `div`, never a heading.
- The h2 element itself gains no class and no inline style. Any existing
  inline `style=` and in-h2 `<i>` icon is removed (the icon moves into the
  tab, see C).

## C. Placement rules per page shape

### Case study (4 work files, Pattern A)

Shape: `<main style="max-width:1140px;…">` containing sibling
`<article style="max-width:var(--measure);margin:0 auto">` prose blocks. An
h2 is usually the first child of its article, but not always: in
`2019-09-01-dxc-bionix-central.html` the first `<article>` holds **two** h2s
(Summary and Background). Do not rely on the one-h2-per-article shape.

- Insert the wrapper **immediately before each h2**, inside that h2's
  `article`. Both are inside the `--measure` article, so the rule spans the
  reading column. Correct. (This is the operative rule and it gives the right
  result whether or not the h2 is the article's first child.)
- **Delete** from each converted h2: the entire `style="display:flex;…"`
  attribute (the ~300-char inline block including the old hairline
  `border-bottom`) and the inline `<i class="icon-… " style="font-size:0.8em">`
  inside it. The glyph is reused in the tab.
- Strip leading number prefixes from h2 text (`1. Background` becomes
  `Background`); the number lives in the tab now.
- The **first** section head in each file gets `class="post-section-head is-first"`
  (the old first h2 had `margin:0`; `main` already pads 104px on top).
- All 4 files already have `body data-category="work"` and
  `.page-header-work`; no attribute changes needed.
- h3s and everything else inside the articles are untouched.

### Prose / journal (16 files, Pattern B/C)

Shape: `<main class="container my-5"> <article class="post-content">` with bare
`<h2 id="…">` as direct children of the article.

- Insert the wrapper as a **direct child of `article.post-content`**,
  immediately before each h2. The reading-layout rules cap the article to
  `--measure` and give direct children `max-width:100%`, so the rule spans the
  reading column. Correct.
- The h2 keeps its `id` and text (strip leading `N. ` numeral prefixes where
  present: `of-video-games`, `users-vs-corporations`, `restarting-postgres`;
  ids stay unchanged even where they encode the old number). Also drop the
  stray trailing colon in `orang-kasar`'s `Retrospective:`.
- No inline styles to delete. No `is-first` (the header band + `my-5` already
  space the top, and the first h2 previously carried `margin-top: var(--space-5)`
  from :707-713, so keeping the wrapper's `--space-5` preserves today's rhythm).
- 11 of these files lack `data-category`; do **not** add it. The CSS bridge in
  A colours them via their `.page-header-*` class (verified present on all).
- Constraint check for executors: all 16 files pour h2s inside
  `article.post-content` (spot-verified). If you find an h2 that is a direct
  child of `main.container` instead, stop and flag it; do not improvise.

### Landing page (`life/2023-09-01-let-s-work-together.html`)

Shape: `<main id="lwt">` with sections holding `div.container > h2`. Six h2s
convert (lines ~310, 383, 410, 468, 517, 606). The seventh h2 at ~543 belongs
to the `.post-related` component and is **not** converted.

- Insert the wrapper inside the section's `.container`, immediately before the
  h2. The rule spans the container column here; that is this page's content
  column, correct.
- Replace each `<span class="lead-in">…</span>` kicker with a tab kicker
  carrying the same sense (see D); delete the span from the h2.
- The contact-band h2 (`Let's chat`, on the dark green `.lwt-contact`) gets the
  `is-inverse` wrapper. Its own colour rules (`#lwt .lwt-contact h2`) stay.
- **Page-scoped `<style>` edits (deletions only):**
  - delete the rule `#lwt h2 .lead-in { color: var(--color-muted); text-shadow: none; }`
  - delete the rule `#lwt .lwt-contact h2 .lead-in { … }`
  - in `#lwt .lwt-contact h2 { color: #fff; text-shadow: var(--shadow-title); margin-top: 0; }`
    delete only the `margin-top: 0;` declaration (it would crush the 18px gap
    under the new rule).
  - keep `#lwt h2 { margin-bottom: var(--space-3) }`; its ID specificity wins
    over the component's `--space-2` and the roomier rhythm suits this page.
- `body data-category="life"` already present; the inner
  `.post-related[data-category="work"]` keeps overriding locally, as designed.

## D. Kicker or no-kicker

**The rule.** A post gets **number + icon + kicker** only when all three hold:

1. Its h2s form a narrative arc (phases of a story or case) rather than an
   enumeration of items, steps, or reference labels.
2. The h2 titles are short (roughly 6 words or fewer), leaving the framing
   work for a kicker to do.
3. A kicker can add something the h2 does not already say.

Everything else gets **number + icon**. Kicker copy is authored with the
`write-like-me` skill, lowercase, at most about 24 characters including the
number, and never contains an em-dash. If an implementer cannot write a kicker
that passes rule 3 for a given section, that whole post falls back to
no-kicker; the choice is per post, never mixed within one post.

**Applied to the 21 files:**

| file | h2s | kicker? | why |
|---|---|---|---|
| work/2019-09-01-dxc-bionix-central.html | 4 | kicker | case-study arc, short titles (Summary/Background/Approach/Outcome) |
| work/2020-09-01-the-hoojah-project.html | 5 | kicker | case-study arc, short titles, owner's flagship story |
| work/2025-09-11-day-food-catalogue.html | 12 | kicker | long case-study arc; kickers keep 12 sections navigable |
| work/2026-08-11-diveos.html | 7 | kicker | case-study arc with conversational titles; kickers extend the voice |
| work/2017-09-01-design-review-jkm-web-portal.html | 5 | kicker | review report with an arc, one-word titles beg for framing |
| work/2024-05-26-ux-assignment-1.html | 5 | kicker | narrative assignment writeup, short titles |
| work/2025-07-26-ux-assignment-1.html | 5 | kicker | duplicate of the above; mirror it exactly |
| life/2023-12-04-of-maritime-academy.html | 8 | no-kicker | h2s already verbose (up to 10 words); a kicker doubles up, fails rule 2 |
| life/2024-01-03-of-video-games.html | 8 | no-kicker | enumerated console list; numbers move to tabs, kickers are filler |
| life/2024-01-06-of-javascript.html | 5 | kicker | story arc (Prologue/Hunt/Farewell/Epilogue), playful and short |
| life/2024-01-03-of-books.html | 3 | no-kicker | category labels (Fictions/Comic/Misc.), not an arc |
| balance/2024-09-05-the-framework.html | 8 | no-kicker | formal proposal headings, several long; self-describing, fails rules 2-3 |
| balance/2023-12-04-users-vs-corporations-in-digital-communication.html | 7 | no-kicker | enumerated argument list between intro and conclusion |
| balance/2023-12-23-ranting.html | 7 | kicker | project-story arc with short titles (Background/Challenges/…) |
| balance/2024-06-16-an-answer-to-the-question-of-windows-vs-macos.html | 7 | no-kicker | mixed list of OS sections, one 9-word title; fails rule 2 |
| balance/2023-12-25-restarting-postgres-for-rails-on-macos.html | 3 | no-kicker | numbered how-to steps |
| balance/2016-05-19-browsercrush-clone.html | 1 | no-kicker | single tutorial section (Setup) |
| balance/2019-04-24-orang-kasar.html | 1 | no-kicker | single section; nothing to frame |
| balance/2024-05-09-how-to-validate-an-email-address-in-rails.html | 1 | no-kicker | single reference section (References) |
| balance/2024-03-23-add-diagram-on-websites-using-mermaidjs.html | 2 | no-kicker | the two h2s are one joined sentence; a kicker breaks the joke |
| life/2023-09-01-let-s-work-together.html | 6 of 7 | kicker | the `.lead-in` spans ARE kickers already; port their copy into the tabs |

Tally: 10 kicker, 11 no-kicker. Landing-page kickers reuse the existing
lead-in copy (e.g. `01 · eight reasons to`, `06 · so,`), lightly trimmed via
`write-like-me` if a lead-in reads awkwardly inside a tab.

## E. Icon assignment

- The 4 case studies keep their existing per-h2 Lucide glyphs; each moves from
  inside the h2 into the tab unchanged (e.g. `icon-book-open` for Summary,
  `icon-users` Background, `icon-lightbulb` Approach/Solution, `icon-flag`
  Outcome/Conclusion).
- For every other h2, pick **one Lucide `icon-*` glyph naming the section's
  subject, not its position**, with two constraints:
  1. Reuse the site's established vocabulary first, so the same idea always
     wears the same glyph across posts: summary/intro `icon-book-open`, people
     or background `icon-users`, goals `icon-target`, idea/solution
     `icon-lightbulb`, process/flows `icon-workflow`, delivery
     `icon-square-kanban`, results `icon-trending-up`, technical
     `icon-wrench`, showcase `icon-image` or `icon-monitor`, next steps
     `icon-arrow-up-circle`, closing `icon-flag`.
  2. Any glyph outside that vocabulary must be verified to exist before use:
     it must either already appear in the repo
     (`grep -rho 'icon-[a-z0-9-]*' --include='*.html' . | sort -u`) or be
     present in the loaded lucide-static font CSS
     (`curl -s https://unpkg.com/lucide-static@latest/font/lucide.css | grep -c 'icon-NAME\b'`).
- No brand marks in tabs (Lucide only, no `brand-*`). One glyph per tab, never
  two. When in doubt, prefer the duller correct glyph over a clever miss.

## F. Task breakdown

Task 1 must land before tasks 2-6 (they all render against the new CSS).
Tasks 2-6 are independent, non-overlapping, and fully parallelisable.
Global rules for every task: never touch `resume.html`, `.claude/worktrees/**`,
or any `_`-prefixed file; match the indentation style already in the file you
edit (some served files use tabs); no em-dash in any copy you write; kickers go
through the `write-like-me` skill.

**Task 1: CSS + specimen.**
Files: `si-es-es.css`, `components/design-system.html`.
Append the block from A verbatim. Add a 2B specimen section to
`design-system.html` in the same documentation style as
`components/posts/index.html` (usage notes + live demo): show all three forms
from B inside `data-category` wrappers for at least two categories, including
one `is-inverse` demo on a `--cat-base` ground. A specimen, not a restyle:
change nothing else on the page.
Verify: serve locally (`ruby -run -e httpd . -p 8000`); specimen tabs render
coloured in each category; an old post-section specimen on
`components/posts/index.html` still renders; `resume.html` section heads are
visually unchanged; one no-`data-category` post (e.g.
`balance/2024-09-05-the-framework.html`) now shows coloured `.post-*` tints via
the bridge with no other visual regression.

**Task 2: case studies.**
Files: `work/2019-09-01-dxc-bionix-central.html`,
`work/2020-09-01-the-hoojah-project.html`,
`work/2025-09-11-day-food-catalogue.html`, `work/2026-08-11-diveos.html`.
Apply C (case-study placement), D (all kicker), E (reuse existing glyphs).
Verify: `grep -c 'post-section-head'` equals the file's h2 count; no converted
`<h2` retains a `style=` attribute or an inner `<i>`; first head in each file
has `is-first`; kickers pass the 24-char cap; visual check at desktop and
375px (tab on rule, no overflow).

**Task 3: work prose.**
Files: `work/2017-09-01-design-review-jkm-web-portal.html`,
`work/2024-05-26-ux-assignment-1.html`, `work/2025-07-26-ux-assignment-1.html`.
Apply C (prose placement), D (all kicker), E. The two ux-assignment files are
the same post twice: produce identical section-head markup in both (`diff` the
converted h2 regions to prove it).
Verify: every pre-existing `h2 id=` survives byte-for-byte (`git diff` shows no
id line removed); head count equals h2 count; 375px visual check.

**Task 4: life prose.**
Files: `life/2023-12-04-of-maritime-academy.html`,
`life/2024-01-03-of-video-games.html`, `life/2024-01-06-of-javascript.html`,
`life/2024-01-03-of-books.html`.
Apply C, D (only `of-javascript` gets kickers), E. In `of-video-games` strip
the `N. ` prefixes from h2 text (ids unchanged).
Verify: same checks as Task 3.

**Task 5: balance prose.**
Files: the 9 balance files listed in D.
Apply C, D (only `ranting` gets kickers), E. Strip numeral prefixes in
`users-vs-corporations` and `restarting-postgres`; drop the trailing colon in
`orang-kasar`.
Verify: same checks as Task 3, plus: single-h2 files carry exactly one head
numbered `01`.

**Task 6: landing page.**
File: `life/2023-09-01-let-s-work-together.html`.
Apply C (landing placement): six heads numbered 01-06, kickers ported from the
`.lead-in` spans, `is-inverse` on the contact head, the three page-scoped
`<style>` deletions listed in C. Do not touch the `.post-related` h2.
Verify: no `lead-in` markup or dead `lead-in` CSS remains; the contact tab
reads white-on-white-rule over the green band with the h2 still white; sticky
TOC anchors still land on their sections (`scroll-margin-top` behaviour
unchanged); 375px visual check of the longest tab.

**Acceptance sweep (whoever lands last, or a Task 7 reviewer):**
across all changed files: an em-dash scan on the diff
(`git diff | grep -nP '\x{2014}'`) returns nothing;
`git diff` shows no removed `id=`; total `.post-section-head` count equals
110 heads (28 case study: 4+5+12+7; 15 work prose: 5+5+5; 24 life prose:
8+8+5+3; 37 balance prose: 8+7+7+7+3+1+1+1+2; 6 landing) plus the specimen's
demos; every
file ends with a final newline.
