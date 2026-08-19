# Sama² UI/UX Case Study Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Publish a Work case study about Sama²'s UI/UX, spined on the decision to build a neumorphic design system and replace it seven weeks later.

**Architecture:** A single hand-written `.html` file in `work/`, matching the current case-study template (`work/2026-08-12-rombak-lyn-forum.html`), illustrated with screenshots captured fresh from a local boot of `sama_sama` under both the `paper` and `neumorph` skins at the same commit. No build step. Copy is drafted through the `write-like-me` skill.

**Tech Stack:** Static HTML5, Bootstrap 5.3.8 (CDN), Lucide icon font, `si-es-es.css` design tokens and `.post-*` section library. Screenshots via the gstack `/browse` daemon against `sama_sama` on `localhost:3000`.

**Spec:** `docs/superpowers/specs/2026-08-17-sama2-uiux-case-study-design.md`

---

## Deviations from the spec, and why

Both are mechanical consequences of the site moving since the spec was approved. Neither changes the argument.

1. **Filename is `work/2026-08-19-sama2.html`**, not `2026-08-17-sama2-design-system.html`. The site's convention (commit `47f8c31`) is that the file slug matches the post title, and the post title is the project name, as in `2026-08-11-diveos` and `2026-08-12-rombak-lyn-forum`. The date is the publish date.
2. **The exemplar is `work/2026-08-12-rombak-lyn-forum.html`**, not the DiveOS post. DiveOS was renamed to `_2026-08-11-diveos.html`; the leading underscore removes it from the Pages build, so it is neither served nor a safe reference for current conventions. **Do not edit any `_`-prefixed file.**

---

## File structure

| File | Disposition | Responsibility |
|---|---|---|
| `work/2026-08-19-sama2.html` | Create | The case study. Self-contained: all page-scoped CSS in one `<style>` in `<head>`. |
| `images/portfolio/sama2/*.png` | Create | 10 screenshots, captured fresh. |
| `work/index.html` | Modify | Add the card that links the post. |
| `work/2026-08-12-rombak-lyn-forum.html` | Modify | Its `.post-nav` "next" arm currently ends the chain; point it at the new post. |
| `docs/superpowers/plans/2026-08-19-sama2-uiux-case-study.md` | This file | — |

Nothing in `/Users/deepsight/code/sama_sama` is modified by any task. The skin switch is a browser cookie.

---

## Global rules for every task

- **No em-dashes** (`—`) in any prose you write. This is a hard voice rule.
- Match the indentation already present in the file you are editing. Several served files use tabs despite `.editorconfig`. Read before you write.
- Bootstrap 5.3.8 JS SRI hash is `sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI`. The `ka7Sk0…` hash that appears in older files is wrong and gets SRI-blocked. Copy the hash from `work/2026-08-12-rombak-lyn-forum.html`.
- Never edit `resume.html`, `.claude/worktrees/**`, or any `_`-prefixed file.
- Never write `{%` or `{{` into a published `.md`. It breaks the whole Pages build.
- Final newline on every file. LF endings.

---

## Task 1: Capture the screenshots

**Files:**
- Create: `images/portfolio/sama2/` (10 PNGs, names fixed in Step 5)

**Preconditions established by preflight (do not re-derive, but do re-verify Step 1):** `sama_sama` boots via `bin/dev`; sign-in is `rudy@sama2.com` / `password`; the team's obfuscated id was `bJYLew` on the preflight run.

- [ ] **Step 1: Confirm the app is up, and re-derive the team id**

The team id is obfuscated and machine-specific. Derive it, never hardcode.

```bash
curl -s -o /dev/null -w '%{http_code}\n' http://localhost:3000/
```

Expected: `200`. If it is not, start the app:

```bash
cd /Users/deepsight/code/sama_sama && mise exec -- bin/dev
```

Run it in the background. If `bin/setup` is needed first, note that it blocks on an interactive Postgres version prompt on this machine (Homebrew has postgresql@18, the check expects 14); use `yes "y" | mise exec -- bin/setup`.

- [ ] **Step 2: Sign in and suppress the two capture nuisances**

```bash
B=$HOME/.claude/skills/gstack/browse/dist/browse
$B goto http://localhost:3000/users/sign_in
$B fill "#user_email" "rudy@sama2.com"
$B fill "#user_password" "password"
$B click "input[type=submit], button[type=submit]"
sleep 2
$B goto "http://localhost:3000/account?pp=disable"
sleep 2
$B storage set sama2_pwa_notice_dismissed_v1 1
$B url
```

Expected: `$B url` prints a URL of the form `http://localhost:3000/account/teams/<ID>`. **Record that `<ID>`.** Every account path below substitutes it.

If the password fails, the seeded user predates the seed file and `find_or_create_by!` never reset it. Repair it in the dev DB only:

```bash
cd /Users/deepsight/code/sama_sama && mise exec -- bundle exec rails runner \
  'u = User.find_by(email: "rudy@sama2.com"); u.password = "password"; u.save!(validate: false); puts u.valid_password?("password")'
```

Expected: `true`.

- [ ] **Step 3: Verify the mobile viewport is honoured**

There is a recorded gotcha that headless Chrome can clamp narrow viewports to ~500px. Prove the actual rendered width before capturing anything at 390px.

```bash
$B viewport 390x844
$B goto http://localhost:3000/account/teams/<ID>
sleep 2
$B eval "window.innerWidth"
```

Expected: `390`. If it reports ~500 or anything other than 390, **stop and report it**. Do not capture mobile shots at the wrong width and label them 390px. Desktop captures are unaffected either way, so the rest of the task can proceed without the mobile pair.

- [ ] **Step 4: Capture the paper set**

Each `goto` needs a settle. Turbo renders after navigation resolves; without the sleep you capture an empty shell.

```bash
mkdir -p /Users/deepsight/code/rudzainy.github.io/images/portfolio/sama2
OUT=/Users/deepsight/code/rudzainy.github.io/images/portfolio/sama2
$B cookie "skin=paper"

$B viewport 1400x1000
for p in "theme_kit:/account/theme_kit" \
         "dashboard:/account/teams/<ID>" \
         "tasks:/account/teams/<ID>/tasks" \
         "money:/account/teams/<ID>/money_overview"; do
  name="${p%%:*}"; path="${p#*:}"
  $B goto "http://localhost:3000${path}"
  sleep 2
  $B screenshot "$OUT/${name}-paper-desktop.png"
done

$B viewport 390x844
$B goto "http://localhost:3000/account/teams/<ID>"
sleep 2
$B screenshot --viewport "$OUT/dashboard-paper-mobile.png"
```

`--viewport` on the mobile shot is deliberate: in a stitched full-page mobile capture the fixed bottom tab bar renders a second time mid-page.

- [ ] **Step 5: Capture the neumorph set**

Same screens, same commit, one cookie different. No file edit, no restart.

```bash
$B cookie "skin=neumorph"

$B viewport 1400x1000
for p in "theme_kit:/account/theme_kit" \
         "dashboard:/account/teams/<ID>"; do
  name="${p%%:*}"; path="${p#*:}"
  $B goto "http://localhost:3000${path}"
  sleep 2
  $B screenshot "$OUT/${name}-neumorph-desktop.png"
done

$B viewport 390x844
$B goto "http://localhost:3000/account/teams/<ID>"
sleep 2
$B screenshot --viewport "$OUT/dashboard-neumorph-mobile.png"
```

- [ ] **Step 6: Capture the un-skinned carve-outs and the public landing**

These are the evidence for "the app has two looks". They must be captured with the skin cookie cleared, because these controllers never declare a skin at all.

```bash
$B cookie "skin=paper"
$B viewport 1400x1000

$B goto "http://localhost:3000/main"; sleep 2
$B screenshot "$OUT/games-hub-desktop.png"

$B goto "http://localhost:3000/si/rudzainy"; sleep 2
$B screenshot "$OUT/bento-profile-desktop.png"

$B goto "http://localhost:3000/"; sleep 2
$B screenshot "$OUT/public-landing-desktop.png"
```

- [ ] **Step 7: Verify the capture set**

```bash
cd /Users/deepsight/code/rudzainy.github.io
ls -la images/portfolio/sama2/
```

Expected: exactly 10 PNGs, every one larger than 20 KB. A file under ~20 KB is almost certainly a blank or half-rendered page. Open the two `theme_kit-*` files and the two `dashboard-*-desktop` files and confirm by eye that the neumorph pair is visibly cool blue-grey with cards the same tone as the page, and the paper pair is cream with white cards and drawn edges. If any capture is blank, re-run its `goto` with a longer sleep.

- [ ] **Step 8: Confirm `sama_sama` is untouched**

```bash
cd /Users/deepsight/code/sama_sama && git status --porcelain && echo "CLEAN-IF-EMPTY-ABOVE"
```

Expected: no output before the marker line.

- [ ] **Step 9: Commit**

```bash
cd /Users/deepsight/code/rudzainy.github.io
git add images/portfolio/sama2
git commit -m "Add Sama2 case study screenshots, both skins"
```

---

## Task 2: Verify every number before it is written

The post makes quantitative claims. Each one gets checked against the repo now, so the drafting task quotes verified figures rather than research summaries. **Record the actual output of each command**; the draft uses those values, not the expected values below.

**Files:** none modified. Produces a findings note used by Task 3.

- [ ] **Step 1: Sama²'s own commit count and start date**

```bash
cd /Users/deepsight/code/sama_sama
git rev-list --count HEAD
git log --reverse --format='%h %ad %an' --date=short | head -1
git log --format='%h %ad %an %s' --date=short --author='Rudzainy' --reverse | head -1
git rev-list --count 7edff0f5..HEAD
```

Expected shape: total ~4,052; first commit 2016-11-15 by Andrew Culver; Rudzainy's first 2025-08-13; commits since that point ~1,750. **Use the real numbers.**

- [ ] **Step 2: The peak month**

```bash
git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c | sort -rn | head -5
```

Expected: `2026-05` leads with roughly 595.

- [ ] **Step 3: How long neumorphism actually lived**

The spec's stats strip says "6 weeks". Compute it rather than repeating it.

```bash
git log --format='%h %ad %s' --date=short --all | grep -i 'neumorphic theme foundation'
git log --format='%h %ad %s' --date=short --all | grep -iE 'replace the neumorphic layer|delete the neumorphic layer'
```

Take the first plan commit as the start and the deletion merge as the end, and compute the span in whole weeks. If it is closer to seven weeks than six, **the post says seven**. Do not round toward the better story.

- [ ] **Step 4: The migration's real size**

```bash
grep -rn "roughly 10%" docs/design/paper-migration/HANDOVER.md
grep -rnE "7,?700|625 ERB" docs/design/paper-migration/HANDOVER.md
```

Expected: the handover's own sentence about the visual language living in Tailwind colour utilities across ERB files. Quote it from the file, verbatim, with the real figures.

- [ ] **Step 5: The accessibility argument, verbatim**

```bash
grep -n -A2 "directly hostile" docs/design/sama2-paper/readme.md
```

Record the exact sentence. This is the quotation the whole post turns on and it must be reproduced word for word.

- [ ] **Step 6: Locale coverage**

```bash
cat config/locales/locales.yml
for l in en ms en-MY zh-CN ta; do printf '%s: ' "$l"; find config/locales -name "*.$l.yml" | wc -l; done
```

Expected shape: five locales declared; `en` around 70 files, `ms` around 39, `zh-CN` and `ta` around 5 each.

- [ ] **Step 7: The two looks, and the touch-target conflict**

```bash
grep -rn "default_skin" app/controllers --include=*.rb
grep -rn "44px" app/assets/stylesheets/components/touch_optimizations.css | head
grep -n "touch-min" app/assets/stylesheets/paper/tokens/spacing.css
```

Expected: `default_skin = "paper"` on a handful of controllers only; a 44px pin in `touch_optimizations.css`; a 48px `--touch-min` in the Paper tokens.

- [ ] **Step 8: The typeface finding**

The claim is that the neu design doc specified DM Sans and Nunito and the app never loaded either. Verify at the last commit of the living neu layer.

```bash
git grep -n "font-family" 0f5c6a30^ -- app/assets/stylesheets/components/neumorphism.css | wc -l
git grep -n "fontFamily" 0f5c6a30^ -- tailwind.config.js
git show 0f5c6a30^:app/views/themes/light/layouts/head/_fonts.html.erb 2>/dev/null || echo "PARTIAL ABSENT IN APP AT THAT COMMIT"
grep -n -E "DM Sans|Nunito" docs/theme/README.md
```

Expected: zero `font-family` declarations in the neumorphic stylesheet; only `fontFamily.mono` overridden; the app-level fonts partial absent (so the theme gem's Inter CDN link rendered); DM Sans and Nunito present only in the doc.

- [ ] **Step 9: Write the findings note**

Create `/private/tmp/claude-501/-Users-deepsight-code-rudzainy-github-io/0d34b131-322b-467f-9c1e-d02c76a72063/scratchpad/sama2-verified-facts.md` recording, for each of Steps 1 to 8, the command run and its actual output. Mark any figure that came out different from the expected shape above with `CHANGED:` so Task 3 cannot miss it. No commit; this is a working note.

---

## Task 3: Draft the copy

**Files:**
- Create: `/private/tmp/claude-501/-Users-deepsight-code-rudzainy-github-io/0d34b131-322b-467f-9c1e-d02c76a72063/scratchpad/sama2-draft.md`

- [ ] **Step 1: Load the voice**

Invoke the `write-like-me` skill (Skill tool, `skill: "write-like-me"`), Work route. Follow it. Do not draft before reading it.

- [ ] **Step 2: Read the two inputs**

Read the spec (`docs/superpowers/specs/2026-08-17-sama2-uiux-case-study-design.md`) for structure, and the findings note from Task 2 Step 9 for numbers. Every figure in the draft comes from the findings note.

- [ ] **Step 3: Draft the five sections plus summary**

Write markdown, not HTML. Section headings are the five from the spec. Target roughly 1,400 to 1,800 words total. This is a macro-level piece: details appear only as evidence for a decision, never as inventory. No token tables, no component lists.

The load-bearing beats, in order:

1. **What Sama² Is, and Who It's For.** A shared organiser for Malaysian families, plus a games hub, plus public Bento profiles. The stated audience is people who are not digital natives, at the low end of digital adoption. Establish this here, because sections 3 and 4 both turn on it.
2. **The First Year: Inherit, Patch, Delete.** The repo's 4,052 commits and 2016 first commit are inherited Bullet Train history; Sama²'s own work starts 2025-08-13. So the frontend arrived already decided: Tailwind since 2020, Turbo since 2021, esbuild since 2022. Then the habit: bespoke mobile navigation built September 2025 and deleted that December for framework defaults; a 513-line six-step wizard replaced by one sheet. Name the Bento profile as the one visual idea that survives everything.
3. **Neumorphism, and the Argument That Killed It.** First whole-app identity that was planned before it was built. The hairline border kept on every surface from day one, because pure neumorphism fails contrast, is the tell that the problem was known early. Then the replacement, and the verbatim quote from Task 2 Step 5. Include the typeface finding from Task 2 Step 8: the design doc specified DM Sans and Nunito, the app never loaded a byte of either, and the whole era actually rendered in Inter fetched from a CDN. A design system that documented a font it never shipped.
4. **Paper, and Why the Reversal Was Cheap.** Drawn edges instead of shadow, Atkinson Hyperlegible, a 48px touch floor. Then the mechanism: every design language is a skin, scoped under `data-skin` on `<body>`, one line to roll back. Then the honest scale from Task 2 Step 4.
5. **Where It Stands.** The games and the Bento profiles are still un-skinned, so the app genuinely has two looks. Chinese and Tamil are declared locales with a fraction of English's coverage, in a typeface with no glyphs for either. A 44px versus 48px conflict still in the tree.

- [ ] **Step 4: Write the honesty callout**

The before/after images are same-commit, cookie-switched, and therefore a tonal reconstruction rather than period screenshots. Draft a short `.post-callout.is-note` body saying so plainly: the neumorph skin renders 48px touch targets where the era shipped 44px, and self-hosted Inter where the era loaded Inter from a CDN. Same design, not the same bytes.

- [ ] **Step 5: Draft the four stats**

Four figures from the findings note, each with a short label. Candidates: months of Sama²'s own history; commits in the peak month; how long neumorphism lived; screens re-shot as visual baselines. Use the verified values.

- [ ] **Step 6: Self-check the draft**

```bash
grep -nP '\x{2014}' /private/tmp/claude-501/-Users-deepsight-code-rudzainy-github-io/0d34b131-322b-467f-9c1e-d02c76a72063/scratchpad/sama2-draft.md
```

Expected: no output. If any em-dash is found, rewrite that sentence rather than swapping the character for a hyphen.

Then reread against the findings note and confirm every number in the draft appears there. Any number that does not, delete or verify.

---

## Task 4: Build the page

**Files:**
- Create: `work/2026-08-19-sama2.html`

- [ ] **Step 1: Read the template end to end**

```bash
cd /Users/deepsight/code/rudzainy.github.io
wc -l work/2026-08-12-rombak-lyn-forum.html
```

Read the whole file. Copy its skeleton exactly: `<head>` with the Bootstrap CSS link, Lucide font link and `../si-es-es.css`; the page-scoped `<style>` including the two responsive blocks for `.header-hero-grid` and `.header-meta-strip`; `<body data-category="work">`; nav; `.page-header-work` band with breadcrumb, `.header-hero-grid` and `.header-meta-strip`; `<main>`; footer; `../jei-es.js`; Bootstrap JS with the correct SRI hash.

- [ ] **Step 2: Write the head and header band**

`<title>Sama² by Rudzainy Rahman</title>`. Meta description: one sentence naming the neu-to-Paper turn.

Hero kicker: `Case study · 2025–2026`. Title: `Sama²`. Standfirst: the draft's opening from Task 3.

Meta strip, four cells matching the template's markup exactly:

- Project: `Sama², by Nasi Forge PLT`
- Technology stack: `Ruby on Rails 8 + Bullet Train + Hotwire, Tailwind 3, esbuild`
- Year: `<time datetime="2025">2025</time>–<time datetime="2026">2026</time>`
- Project links: a `meta-link` anchor to `https://sama2.my` plus a muted `icon-lock` span reading `Private repository`

- [ ] **Step 3: Write the five sections with rule-tab heads**

Each section is a `.post-section-head` wrapper immediately followed by its `<h2>`, both inside that section's `<article style="max-width:var(--measure);margin:0 auto">`. Nothing may sit between the wrapper and the h2; the CSS uses `+`.

This post is a case study with a narrative arc and short titles, so it takes **kickers** (numbers, icons and lowercase kicker copy). The first head carries `is-first`.

```html
<div class="post-section-head is-first" aria-hidden="true">
  <span class="head-tab"><i class="icon-users"></i><span>01 &middot; who it's for</span></span>
</div>
<h2>What Sama² Is, and Who It's For</h2>
```

Heads two to five follow the same shape without `is-first`. Suggested glyphs from the site's established vocabulary: `icon-users` (01), `icon-workflow` (02), `icon-lightbulb` (03), `icon-layers` (04), `icon-arrow-up-circle` (05). Kickers are lowercase, at most about 24 characters including the number, no em-dash, and authored in Task 3.

The h2 takes no class, no inline style, and no inner `<i>`. Do not copy the older inline-styled h2 pattern from the DiveOS file.

- [ ] **Step 4: Place the stats strip**

After the summary article, before section 1, using the library markup:

```html
<div class="post-stats">
  <div class="stats-strip">
    <div class="stat">
      <div class="stat-num">595</div>
      <div class="stat-label">Commits in the peak month</div>
    </div>
  </div>
</div>
```

Four `.stat` blocks, values from Task 3 Step 5.

- [ ] **Step 5: Place the before/after comparison**

In section 3, after the argument is made. Use `.post-before-after`, which is the library's own comparison component, and give it the theme-kit pair (the design-system specimen shows every component at once, so it is the clearest comparator). Every image uses the SmartImage frame so a missing file degrades to the songket placeholder:

```html
<span class="smart-image is-zoom"><img src="../images/portfolio/sama2/theme_kit-neumorph-desktop.png" alt="The Sama² component specimen under the neumorphic skin: cool blue-grey surfaces with cards the same tone as the page" loading="lazy" data-fallback="Neumorphic theme kit"></span>
```

Follow it with the dashboard pair as a `.post-gallery`, and then the honesty callout from Task 3 Step 4 as a `.post-callout.is-note`.

- [ ] **Step 6: Place the current-state gallery**

In section 5, a `.post-gallery` carrying `games-hub-desktop.png` and `bento-profile-desktop.png` side by side, captioned so they read as the evidence for "two looks". Place `tasks-paper-desktop.png`, `money-paper-desktop.png`, `dashboard-paper-mobile.png` and `public-landing-desktop.png` across sections 4 and 5 as `.post-figure` blocks where the prose calls for them. Every image needs a real `alt` describing what is in it, not a filename restatement.

- [ ] **Step 7: Write the prev/next**

```html
<div class="post-nav">
  <nav aria-label="More work">
    <a href="/work/" class="nav-card is-prev">
      <span class="nav-dir"><i class="icon-arrow-left" aria-hidden="true"></i>Back</span>
      <span class="nav-title">All Work</span>
      <span class="nav-date">The full portfolio</span>
    </a>
    <a href="/work/2026-08-12-rombak-lyn-forum.html" class="nav-card is-next">
      <span class="nav-dir">More<i class="icon-arrow-right" aria-hidden="true"></i></span>
      <span class="nav-title">Rombak LYN Forum</span>
      <span class="nav-date"><time datetime="2026-08-12">12.08.2026</time></span>
    </a>
  </nav>
</div>
```

- [ ] **Step 8: Verify the structural contract**

```bash
cd /Users/deepsight/code/rudzainy.github.io
grep -c 'post-section-head' work/2026-08-19-sama2.html
grep -c '<h2' work/2026-08-19-sama2.html
grep -c 'is-first' work/2026-08-19-sama2.html
grep -nP '\x{2014}' work/2026-08-19-sama2.html
grep -c 'ka7Sk0' work/2026-08-19-sama2.html
```

Expected: section-head count equals h2 count; exactly one `is-first`; no em-dash output; zero `ka7Sk0`.

Then confirm no h2 carries a `style=` attribute or an inner `<i>`:

```bash
grep -n '<h2' work/2026-08-19-sama2.html
```

Expected: every line is a bare `<h2>` with text only.

- [ ] **Step 9: Verify every image resolves**

```bash
for f in $(grep -o 'images/portfolio/sama2/[a-z0-9._-]*\.png' work/2026-08-19-sama2.html | sort -u); do
  test -f "$f" && echo "OK  $f" || echo "MISSING  $f"
done
```

Expected: every line starts `OK`.

- [ ] **Step 10: Commit**

```bash
git add work/2026-08-19-sama2.html
git commit -m "Work: add the Sama2 UI/UX case study"
```

---

## Task 5: Wire it into the site

**Files:**
- Modify: `work/index.html`
- Modify: `work/2026-08-12-rombak-lyn-forum.html`

- [ ] **Step 1: Read how the newest card is built**

```bash
cd /Users/deepsight/code/rudzainy.github.io
grep -n 'rombak-lyn-forum' work/index.html
```

Read 30 lines either side of the hit. Copy that card's markup shape exactly, including its grid classes and any category tint.

- [ ] **Step 2: Add the Sama² card**

Insert immediately before the Rombak LYN card so the newest post leads. Title `Sama²`, date `19.08.2026`, `href="/work/2026-08-19-sama2.html"`, and a one-line description drawn from the post's standfirst. Match the surrounding indentation.

- [ ] **Step 3: Point the previous post's "next" at this one**

```bash
grep -n -A6 'is-next' work/2026-08-12-rombak-lyn-forum.html
```

If its `is-next` arm points at `/work/` (chain end), repoint it to `/work/2026-08-19-sama2.html`, title `Sama²`, date `<time datetime="2026-08-19">19.08.2026</time>`. If it already points at a real post, leave it alone and report that instead of guessing.

- [ ] **Step 4: Verify**

```bash
grep -c '2026-08-19-sama2.html' work/index.html
grep -nP '\x{2014}' work/index.html work/2026-08-12-rombak-lyn-forum.html
```

Expected: `1`, and no em-dash output.

- [ ] **Step 5: Commit**

```bash
git add work/index.html work/2026-08-12-rombak-lyn-forum.html
git commit -m "Work: list the Sama2 case study and close the prev/next chain"
```

---

## Task 6: Render QA

**Files:** none modified unless a defect is found.

- [ ] **Step 1: Serve the site**

```bash
cd /Users/deepsight/code/rudzainy.github.io && ruby -run -e httpd . -p 8000
```

Run in the background.

- [ ] **Step 2: Desktop render**

```bash
B=$HOME/.claude/skills/gstack/browse/dist/browse
$B viewport 1400x1000
$B goto http://localhost:8000/work/2026-08-19-sama2.html
sleep 2
$B screenshot /private/tmp/claude-501/-Users-deepsight-code-rudzainy-github-io/0d34b131-322b-467f-9c1e-d02c76a72063/scratchpad/qa-desktop.png
$B console
```

Open the screenshot and confirm: the header band renders with the hero and the four-cell meta strip; every section head shows a solid blue tab sitting on a 2px rule; no image shows the songket placeholder; the before/after pair is visibly different. `$B console` must report no errors, in particular no SRI failure on the Bootstrap bundle.

- [ ] **Step 3: Mobile render**

```bash
$B viewport 390x844
$B eval "window.innerWidth"
$B goto http://localhost:8000/work/2026-08-19-sama2.html
sleep 2
$B screenshot --viewport /private/tmp/claude-501/-Users-deepsight-code-rudzainy-github-io/0d34b131-322b-467f-9c1e-d02c76a72063/scratchpad/qa-mobile.png
```

`window.innerWidth` must report 390. If it clamps, fall back to a same-origin 375px iframe harness rather than reporting an unverified mobile pass.

Confirm: the hero grid and the meta strip have both stacked to one column; no section tab overflows its rule; the page does not scroll horizontally.

- [ ] **Step 4: Confirm the index card and the chain**

```bash
$B viewport 1400x1000
$B goto http://localhost:8000/work/
sleep 2
$B screenshot /private/tmp/claude-501/-Users-deepsight-code-rudzainy-github-io/0d34b131-322b-467f-9c1e-d02c76a72063/scratchpad/qa-index.png
```

Confirm the Sama² card is present, leads the grid, and its link resolves.

- [ ] **Step 5: Final sweep**

```bash
cd /Users/deepsight/code/rudzainy.github.io
git status --porcelain
git log --oneline -4
cd /Users/deepsight/code/sama_sama && git status --porcelain && echo "SAMA-CLEAN-IF-EMPTY"
```

Expected: site tree clean, three or four new commits, `sama_sama` clean.

- [ ] **Step 6: Report**

State plainly what was verified by looking at a render versus what was only grep-checked. If the mobile viewport could not be held at 390px, say so rather than claiming a mobile pass.

---

## Self-review against the spec

- Spine (neumorphism to Paper as the turn): Task 3 Step 3 beats 3 and 4. Covered.
- Commit-count caveat: Task 2 Step 1, Task 3 Step 3 beat 2. Covered.
- Five-section macro structure: Task 3 Step 3, Task 4 Step 3. Covered.
- Stats strip of four: Task 3 Step 5, Task 4 Step 4. Covered.
- Fresh captures, both skins, same commit: Task 1 Steps 4 and 5. Covered.
- Reconstruction honesty callout: Task 3 Step 4, Task 4 Step 5. Covered.
- SmartImage frames: Task 4 Step 5. Covered.
- `sama_sama` left clean: Task 1 Step 8, Task 6 Step 5. Covered.
- Voice via `write-like-me`, no em-dashes: Task 3 Steps 1 and 6, plus global rules and three grep gates. Covered.
- Template match, correct SRI hash: Task 4 Steps 1 and 8. Covered.
- Listed on the index, prev/next closed: Task 5. Covered.
- Renders clean at desktop and mobile, no broken images: Task 6. Covered.

Spec items deliberately not implemented: none. Two mechanical deviations are recorded at the top of this plan.
