# Jekyll Migration and Housekeeping Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Convert the hand-written static site into a Jekyll site where every served post is a Markdown source rendered through shared layouts, with URLs, content and visual output unchanged, and the repo tidied so `bundle exec jekyll build` runs clean.

**Architecture:** Shared chrome (head, navbar, footer, scripts) moves into `_includes/` and `_layouts/`, parameterised by page front matter (`category`, `title`, extra head/script hooks). Each served `.html` post becomes a `.md` file with front matter and its body kept as the original raw HTML (the Batik `.post-*` blocks, hero band and figures are HTML, which kramdown passes through). Permalinks are pinned to the current `.html` URLs. Verification compares the built site against the pre-migration HTML: URL set, normalised rendered body, and link/asset resolution.

**Tech Stack:** Jekyll (via the `github-pages` gem, to match GitHub Pages' build), Ruby for the migration script, Bootstrap 5.3.8, `si-es-es.css`, `jei-es.js`.

**Spec:** `CLAUDE.md` at the repo root (project invariants, site architecture, Liquid rules, EditorConfig). There is no separate design spec; this plan argues from CLAUDE.md. Where CLAUDE.md is out of date for Jekyll, Task 5 updates it.

## Global Constraints

- The served `.html` pages are the authority for content until Task 4 passes. Legacy `.md` files are overwritten only by Task 3, and git is the backup.
- Served URLs do not change: `/work/YYYY-MM-DD-slug.html`, `/life/...`, `/balance/...`, `/`, `/resume.html`, `/404.html`. Every pre-migration served URL must exist in the build output.
- Images live under `/images/`, never `/assets/img/`. Asset references use root-absolute paths (`/images/...`, `/si-es-es.css`, `/jei-es.js`), replacing today's `../` and bare relative paths.
- Bento-box layout, category colour-coding (Work / Life / Balance plus neutral cards) and the typography stack are invariant (CLAUDE.md, "Visual identity").
- The domain is `rudzainy.com`. Never write `rudzainy.my` into copy, config or comments.
- No literal `{%` or `{{` in any published `.md`, except inside a `{% raw %}` block. Converted posts must not contain Liquid that was not intended.
- EditorConfig: LF, UTF-8, 2-space indent, final newline. Trailing whitespace may be left in `.md` bodies (CLAUDE.md exemption).
- Drafts (`_`-prefixed `.html`) are not built by Jekyll and are not converted in this plan.
- Use `git mv` for renames so history follows.

## Review Focus

1. A served post with `published: false` in its legacy `.md` front matter silently disappears from the build. Converted files must drop that key; the `.html` is what is live.
2. Kramdown rewrites or swallows raw HTML that contains blank lines, markdown-looking text, or a `markdown="1"` attribute. A `.post-*` block with an internal blank line renders differently from the original.
3. Front-matter `date` with a timezone, or a `permalink` left unpinned, changes the output path. The URL must match the original filename exactly.
4. A missing image (15 known refs) renders as a broken `<img>`. The build passes, so only a link/asset check catches it.
5. The footer and navbar drift across pages (five balance posts drop the emoji, the Kakiseni footer carries a live Sama2 link). Normalising these to one layout changes what visitors see on those pages.

Each line above gets a test in the owning task (Task 1 for 1, 3 and 5; Task 3 for 2; Task 4 for 4; Task 3 for 5).

---

## Rulings (made in planning; the user may overturn any)

- **R1. Gem:** use `gem "github-pages"` in the Gemfile so local builds match Pages. Cost if wrong: a version mismatch with production; fix by pinning.
- **R2. Post permalinks:** pin `permalink:` per file to the existing `.html` path. Cost if wrong: broken inbound links; Task 4 catches it.
- **R3. Body format:** the original body is kept as raw HTML inside the `.md` file, wrapped so kramdown does not transform it (see Task 3 step 2). Cost if wrong: a few blocks render differently; Task 4's DOM diff catches it.
- **R4. Footer drift:** the layout uses the majority footer. The Kakiseni live Sama2 link and the emoji/`&#xB2;` differences are normalised to the majority, and the Kakiseni Sama2 link moves into the post body so no content is lost. Cost if wrong: small visible footer change on about 7 pages.
- **R5. Bootstrap icons page** (`life/2022-03-19-happyness-unlocked.html`) moves to Lucide icons to match the rest of the site. Cost if wrong: that page's icons change style.
- **R6. Section index pages** (`work/index.html`, `life/index.html`, `balance/index.html`) become Jekyll pages using the section layout. The card grids stay hand-written for now; generation from a collection is out of scope. Cost if wrong: none for visitors.
- **R7. Drafts** (`_*.html`, and the 27 `.md` that map to them) are left alone. Jekyll does not build them. Cost if wrong: none now; they can be converted later.
- **R8. `published: false`** in legacy front matter is discarded during conversion (see Review Focus 1).
- **R9. `tools/`** holds the migration script and is added to `exclude:` so Jekyll does not publish it.
- **R10. `docs/` stays static.** `docs/robots.txt` moves to the site root, the only place it takes effect.

---

## Task 1: Jekyll scaffold

**Files:**
- Modify: `Gemfile` (replace `gem "jekyll"` with `gem "github-pages", group: :jekyll_plugins`)
- Modify: `_config.yml`
- Modify: `.gitignore` (add `_site/`, `.jekyll-cache/`, `.sass-cache/`)
- Create: `_layouts/default.html`, `_layouts/post.html`, `_layouts/section.html`
- Create: `_includes/head.html`, `_includes/navbar.html`, `_includes/footer.html`, `_includes/scripts.html`
- Test: a manual DOM comparison in Task 4 (no test file here)

**Interfaces:**
- Consumes: nothing from earlier tasks
- Produces: layout contract. Front matter keys used by layouts: `title` (string), `category` (`work` | `life` | `balance`, default: derived from URL path), `description`, `body_class` (optional, extra class on `<body>`), `head_extra` (optional raw HTML, inserted after the head stylesheets), `scripts_extra` (optional raw HTML, inserted after `jei-es.js`). Layouts add nothing to the body beyond the chrome. `_config.yml` sets `title: Website of Rudzainy Rahman`, `url: https://rudzainy.com`, `description`, and `exclude:` extended with `tools`, `docs/superpowers`, `CLAUDE.md`, `README.md`, `EDITORIAL-GAP-REPORT.md`, `../../../INDEKS.md`, `Gemfile`, `Gemfile.lock`, `**/*.md` only where no front matter exists (see Task 3; initially keep `**/*.md` and remove it in Task 3 once converted files are in place).

- [ ] **Step 1: Capture the reference.** Run `bundle exec jekyll build -d "$SCRATCH/before"` against the current tree and keep the output list as the URL baseline. Expected: exit 0, zero warnings.
- [ ] **Step 2: Switch the gem.** Edit `Gemfile`, run `bundle install`. Expected: lock resolves; `bundle exec jekyll -v` runs.
- [ ] **Step 3: Extract head, navbar, footer, scripts** from `index.html` (the majority copy) into the four `_includes/` files. Keep Bootstrap's SRI hash unchanged. The navbar border class comes from `{{ page.category }}`, mapped `work→border-info`, `life→border-success`, `balance→border-warning`, default `border-primary`.
- [ ] **Step 4: Write the three layouts.** `default.html` wraps `{{ content }}` in the head/navbar/footer/scripts includes. `post.html` sets `layout: default` and adds `head_extra` and `scripts_extra`. `section.html` is `default` with a `section` class hook. Use `relative_url` for nothing; all asset paths are root-absolute.
- [ ] **Step 5: Verify the scaffold.** Add a temporary test page `scaffold-check.md` with `layout: post`, `category: work`, and a body of `<main>x</main>`. Run the build. Expected: zero warnings; the page output contains the navbar with `border-info` and the Bootstrap SRI hash. Delete the test page.
- [ ] **Step 6: Update `.gitignore`** with `_site/`, `.jekyll-cache/`, `.sass-cache/`.
- [ ] **Step 7: Commit.** `git add Gemfile Gemfile.lock _config.yml .gitignore _layouts _includes && git commit -m "Add Jekyll layouts and includes for shared chrome"`

---

## Task 2: Root and path housekeeping

**Files:**
- Modify: `index.html`, `resume.html`, `404.html` (add front matter `layout: default`; remove inline chrome that the layout now supplies; keep the body)
- Modify: `life/2022-03-19-happyness-unlocked.html` (Bootstrap Icons to Lucide, R5)
- Move: `docs/robots.txt` to `robots.txt` (`git mv`, R10)
- Modify: every root-relative asset path that starts with `../` or is bare (`si-es-es.css`, `jei-es.js`) in root pages, to `/si-es-es.css`, `/jei-es.js`

**Interfaces:**
- Consumes: layout contract from Task 1
- Produces: `robots.txt` at site root; root pages use the `default` layout. `resume.html` keeps its 85-line inline `<style>` through `head_extra` (it is one-off, so it stays inline).

- [ ] **Step 1: Write a failing check** (`tools/check-root.sh`, not committed) listing root-page `<link>`/`<script>` hrefs that are not root-absolute. Expected: failures listed for index, resume and 404.
- [ ] **Step 2: Apply the path and layout changes** above.
- [ ] **Step 3: Re-run the check.** Expected: no failures.
- [ ] **Step 4: Build** and confirm `/robots.txt` is in the output and zero warnings.
- [ ] **Step 5: Commit** `git commit -m "Route root pages through layout; move robots.txt to root"`

---

## Task 3: Migrate served posts and section indexes to Markdown

**Files:**
- Create: `tools/migrate_posts.rb` (converter; excluded from the build by Task 1's `_config.yml`)
- Overwrite: each served post's `.md` sibling (52 files) and create `.md` for the 10 served posts with no sibling, plus `work/index.html`, `life/index.html`, `balance/index.html` converted to front-matter pages
- Not touched here: the served `.html` files stay in place. Deleting them is gated on the user (Task 6).
- Test: `tools/migrate_posts.rb --check` (see step 3)

**Interfaces:**
- Consumes: layout contract (Task 1), root-path changes (Task 2)
- Produces: for each served `section/YYYY-MM-DD-slug.html` a file `section/YYYY-MM-DD-slug.md` with front matter:
  ```yaml
  ---
  layout: post
  title: <from <title> or <h1>, unchanged text>
  date: <from filename>
  description: <from <meta name="description"> if present, else from the legacy md>
  category: <section name>
  permalink: /section/YYYY-MM-DD-slug.html
  ---
  ```
  plus `head_extra` / `scripts_extra` only when the source page has extra `<style>` or `<script>` tags (move them verbatim). The body is the original `<main>` (or equivalent content block) inner HTML, wrapped as described in step 2. `published:` is never written (R8). Tags and image keys from the legacy md are kept when present.

- [ ] **Step 1: Write the converter's failing check first.** `tools/migrate_posts.rb --check` reports, for each served post, whether the proposed `.md` has the required keys and whether the body contains a `<main>` region. Expected initially: all 62 posts fail.
- [ ] **Step 2: Implement the body wrapper.** Wrap the raw body as:
  ```
  {% raw %}
  <original body HTML with its blank lines removed>
  {% endraw %}
  ```
  Use `{% raw %}` only if the body contains `{{` or `{%`; otherwise emit the HTML directly with no blank lines inside any block (kramdown keeps raw HTML blocks intact when no blank line separates them). Blank lines between top-level blocks are emitted as a single blank line.
- [ ] **Step 3: Implement the converter** to read the served `.html`, extract the content region, apply the footer normalisation from R4 (the Kakiseni Sama2 link is moved from the footer into the post body, after the last `</section>`), and write the `.md`. Run `ruby tools/migrate_posts.rb --check` until it passes for all 62 posts and the three index pages.
- [ ] **Step 4: Run the migration and rewrite asset paths.** Replace `../images/` and `images/` with `/images/` in the converted bodies. Do not invent missing files (see Task 4 for the 15 missing refs).
- [ ] **Step 5: Remove the `**/*.md` exclude** from `_config.yml`, so converted posts are built. Keep `CLAUDE.md`, `README.md`, `EDITORIAL-GAP-REPORT.md`, `../../../INDEKS.md`, `docs/superpowers`, `tools` excluded. The 27 draft-sibling `.md` and 3 orphan `.md` must stay excluded: add them by path, or move them under `_drafts/` (R7). Decision: exclude the draft/orphan `.md` by a `exclude:` list entry for each, generated by the converter.
- [ ] **Step 6: Build.** Expected: exit 0, zero warnings, zero conflicts, and every served URL present in output.
- [ ] **Step 7: Commit** `git commit -m "Migrate served posts and section indexes to Markdown with shared layouts"`

---

## Task 4: Verification (independent worker)

**Files:**
- Create: `tools/verify-migration.rb` (or `.sh`) and a report at the scratchpad path, not in the repo
- Test: the script itself

**Interfaces:**
- Consumes: the pre-migration reference build (Task 1 step 1), the post-migration build
- Produces: a report with PASS/FAIL per check, each failure listing the exact URL and the first differing element.

- [ ] **Step 1: URL parity.** The set of `.html` paths in the post-migration build must contain every served `.html` path from the baseline. Any missing or added URL fails.
- [ ] **Step 2: Body parity.** For each served post, extract the rendered body from both builds, normalise whitespace and attribute order, and compare. Expected: identical, except the R4 footer changes and the Kakiseni move, which are listed as known differences.
- [ ] **Step 3: Chrome parity.** Compare the navbar and footer HTML per page against the layout output. Expected: differences only where R4 or the category border applies.
- [ ] **Step 4: Assets and links.** Every local `src`/`href` in the built HTML resolves to a file in the build. Report the 15 known missing refs by name; they are expected failures until the user supplies the files.
- [ ] **Step 5: Liquid and encoding.** Grep the converted `.md` for `{%` and `{{` outside `{% raw %}`. Expected: none.
- [ ] **Step 6: Visual spot-check.** Render one post from each section, before and after, at 390px and 1280px wide, and compare screenshots. Report any visible difference. Use the built-in headless browser if available; otherwise state that visual parity was not checked.
- [ ] **Step 7: Report.** Write the report to scratchpad; return PASS/FAIL per step with the failing URLs. Do not fix anything in this task.

---

## Task 5: Housekeeping and documentation

**Files:**
- Modify: `CLAUDE.md` (the "Development Workflow" section says there is no build step; replace with the Jekyll build and serve commands; update "Deployment reality" to say Jekyll is the build; keep the invariants)
- Modify: `README.md` (build command, layout map)
- Modify: `_config.yml` (final exclude list)
- Not touched here: the superseded served `.html` posts are deleted only under the Task 6 gate.

- [ ] **Step 1: Update `CLAUDE.md`** to describe the Jekyll build, the new layout/include structure, the `published:` rule, and the `tools/` directory. Keep the invariants and the Liquid warning, which is still true.
- [ ] **Step 2: Update `README.md`** with `bundle install`, `bundle exec jekyll serve`, and the layout map.
- [ ] **Step 3: Confirm `.gitignore`** still ignores build output; add `tools/*.log` if the converter writes logs.
- [ ] **Step 4: Final build** with zero warnings. Commit `git commit -m "Update CLAUDE.md and README for the Jekyll build"`

---

## Task 6 (gated on the user): Remove superseded HTML and legacy Markdown

**Not executed without approval.** This deletes tracked files. Git keeps them, but the working tree changes.

- [ ] **Step 1: Ask the user** whether to delete the 62 served `.html` posts (now superseded by the `.md`) and the 82 legacy `.md` (after conversion, only the 27 draft-sibling `.md`, the 3 orphan `.md`, and `_`-drafts remain relevant).
- [ ] **Step 2: If approved**, `git rm` the approved set in one commit, then rebuild and re-run Task 4.

---

## Open items the user must resolve

- **Missing images (15 refs, Task 4 step 4):** the hoojah project screenshots, the Kakiseni homepage directions images and a few others are referenced but absent. They render as broken images until the files are supplied. Affected pages: `work/2020-09-01-the-hoojah-project.html` (6), `work/2026-09-02-kakiseni-homepage-directions.html` (4), `life/2022-03-19-happyness-unlocked.html` (2), three more work posts (1 each).
- **Legacy `.md` disposition (Task 6):** approve or decline the deletion.
- **Execution method:** subagent-driven (recommended: five dependent tasks with a parity gate, where a fresh verifier matters) or native.

## Rulings I made (ledger)

Recorded here so they travel with the plan: R1–R10 above. Cost if each is wrong is stated beside it.
