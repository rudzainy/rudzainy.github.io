# Hoojah White Paper + Master Research Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking. This is a **document-authoring** pipeline: "verification" means citation-integrity checks, word-count checks, and HTML render checks, not unit tests.

**Goal:** Produce three self-contained HTML documents (a digestible White Paper + two scholarly Master Research papers) that frame Hoojah as forward-looking problem→solution research, export them back to Google Docs in Drive, and refresh four existing Hoojah blog posts in the owner's voice.

**Architecture:** Fable 5 acts as architect/advisor (outlines + citation strategy + final rigor review); Opus 4.8 subagents do the token-heavy mining, literature search, drafting, and HTML assembly. Phases P0→P6 run mostly sequentially with parallel fan-out inside P1 (literature) and P2 (drafting). Citation integrity is a hard gate: every reference is verified real via web search before it ships.

**Tech Stack:** Static HTML5 + inline CSS (self-contained, print-friendly, lightly Batik-tinted). Google Drive MCP for export. `write-like-me` skill for the blog pass. No build step.

**Working directory for intermediate artifacts:** `/private/tmp/claude-501/-Users-deepsight-code-rudzainy-github-io/8c05b141-491a-4f5b-ae30-1b915cc4f89d/scratchpad/hoojah-build/` (the "workroom"). Final HTML lands in `docs/`.

---

## File structure

**Intermediate (scratchpad workroom):**
- `dossier.md` — structured primary-source dossier (P0)
- `bibliography.md` — verified shared bibliography with stable cite-keys (P1)
- `outline-white-paper.md`, `outline-deliberation.md`, `outline-cscw.md` — Fable outlines (pre-P2)
- `draft-white-paper.md`, `draft-deliberation.md`, `draft-cscw.md` — prose drafts (P2)

**Final (committed to repo):**
- `docs/hoojah-white-paper.html`
- `docs/hoojah-research-deliberation.html`
- `docs/hoojah-research-cscw.html`

**Modified posts (P6):**
- `work/2020-09-01-the-hoojah-project.html`
- `life/2021-01-03-kenapa-rudzainy-buat-hoojah.html`
- `balance/_2024-04-06-reactjs-and-rails-the-hoojah.html`
- `work/2026-08-12-rombak-lyn-forum.html`

**Drive export targets (P5):**
- `Whitepaper/` folder `1ryiRKn6219wVEyeyQJyHJ31wzs5KxnMr` ← White Paper
- `Masters Research/` folder `1G3jsjg_P53k2UF6lAHWUkhNHOzvTSQUa` ← both MR papers

---

## Task 1 (P0): Build the primary-source dossier

**Files:**
- Create: `scratchpad/hoojah-build/dossier.md`

**Agent:** one Opus subagent, model inherited. Has Read/Grep/Glob on `~/code/hoojah-beta` and the Drive MCP read tools.

- [ ] **Step 1: Mine the codebase.** Read `~/code/hoojah-beta/README.md`, `docs/FEATURES.md`, `docs/superpowers/HANDOVER.md`, `docs/superpowers/ROADMAP-future-features.md`, `app/models/{hujah,vote,debate,debate_turn,user,notification}.rb`, `app/policies/*.rb`, `config/routes.rb`. Extract: the hujah/vote/debate domain model, exact vote mechanics (agree/neutral/disagree counters, array-column history), debate state machine (phases opening/counter/response/closing, derived turn/round, extend_rounds lock), the **secret-ballot privacy model** and the `new_vote` de-anonymization vector, trending (HN-gravity, 15-min id cache), badges, follow/block graph, real-time (Solid Cable `DebateChannel`), and the **built-vs-proposed roadmap table**.

- [ ] **Step 2: Mine Drive vision + positioning.** Via Drive MCP `read_file_content`, read the two 2020 drafts (`1q0s_…` whitepaper draft, `1_TWf…` / `1INeb…` research draft), and skim `Topics`, `How To Use Hoojah Script (EN)`, and one deck for problem-statement framing and terminology. Capture the original civic-data motivation as **background context**, and the UX-first thesis as positioning.

- [ ] **Step 3: Identify the 4 seed PDFs.** Via Drive MCP `read_file_content` on each PDF id (`1Ktfk2…` reflect, `1zhbzp…` 327266594, `1nbklg…` To Comment or Not To Comment, `12spA…` Social Networking is Coming), extract title, authors, year, venue, and 2–3 sentence relevance to Hoojah. These are anchor citations for P1.

- [ ] **Step 4: Write `dossier.md`** with sections: `## Mechanics (built)`, `## Roadmap (proposed)`, `## Privacy model`, `## Problem statements` (from vision + observed), `## Original vision (background)`, `## Seed papers`. Every mechanic claim tagged `[built]` or `[proposed]`.

- [ ] **Step 5: Verify.** Read back `dossier.md`. Gate: it must contain the debate phase names, the `new_vote` privacy vector, the built-vs-proposed table, and all 4 seed papers identified with author+year. If any missing, fix before proceeding.

---

## Task 2 (P1): Verified shared bibliography (parallel: 2 tracks)

**Files:**
- Create: `scratchpad/hoojah-build/bibliography.md`

**Agents:** two Opus subagents in parallel, each with WebSearch + WebFetch. Track A = deliberative democracy + computational argumentation. Track B = social computing / CSCW / online-discussion design. A third short merge step dedupes.

- [ ] **Step 1: Track A search.** Find and **verify** real works across: deliberative democracy (e.g. Habermas public sphere, Fishkin deliberative polling, Dryzek), online/digital deliberation (Wright & Street; Friess & Eilders review), computational argumentation (Toulmin model; Walton; Dung abstract argumentation frameworks), argument mining (Lawrence & Reed), and opinion/vote-stance systems (ConsiderIt — Kriplean et al. CSCW 2012; Reflect — Kriplean et al. CSCW 2012). For each: authors, year, title, venue, DOI/stable URL. **Verify each via web search — no citation ships unconfirmed.**

- [ ] **Step 2: Track B search.** Find and verify real works across: online incivility/toxicity (e.g. Anderson et al. "nasty effect" 2014; Coe et al.), comment-system design ("To Comment or Not to Comment" seed), structured discussion/deliberation systems (Kialo studies; ConsiderIt; Reflect; Deliberatorium — Klein), moderation & pro-social design (Grimmelmann virtues of moderation; Seering et al.), and stance/argument UX. Same citation completeness + verification rule.

- [ ] **Step 3: Merge + key.** One subagent merges both lists into `bibliography.md`, dedupes, assigns stable cite-keys (`AuthorYear`), and flags each entry `[verified: URL]`. Seed PDFs from Task 1 must appear if identified.

- [ ] **Step 4: Verify (hard gate).** Grep `bibliography.md` for any entry lacking a `[verified: …]` URL. Gate: **zero unverified entries.** Any entry that could not be confirmed as a real publicly-available work is deleted, not kept. Target ≥ 25 verified sources spanning both tracks.

---

## Task 3 (pre-P2): Fable produces the three outlines + citation strategy

**Files:**
- Create: `scratchpad/hoojah-build/outline-white-paper.md`, `outline-deliberation.md`, `outline-cscw.md`

**Agent:** Fable 5 as architect (advisor mode), given `dossier.md` + `bibliography.md`.

- [ ] **Step 1:** Prompt Fable to produce, for each of the 3 documents: a section-by-section outline with target word counts per section (summing to the doc target), the problem→solution→justification arc, and **which cite-keys anchor which claims**. White Paper target 3,000–4,000; each MR paper 8,000–12,000.

- [ ] **Step 2:** Fable specifies the citation strategy: numbered in-text `[n]` mapping to a reference list per document, drawing from the shared bibliography (each doc carries only the subset it cites).

- [ ] **Step 3: Verify.** Each outline names real cite-keys that exist in `bibliography.md`. Gate: no outline references a cite-key absent from the bibliography.

---

## Task 4 (P2): Draft the three documents (parallel: 3 drafts)

**Files:**
- Create: `scratchpad/hoojah-build/draft-white-paper.md`, `draft-deliberation.md`, `draft-cscw.md`

**Agents:** three Opus subagents in parallel, each given its outline + `dossier.md` + `bibliography.md`.

- [ ] **Step 1: White Paper draft.** Digestible technical prose, 3,000–4,000 words, following `outline-white-paper.md`. Problem→solution; carries civic-data motivation as origin context; includes 2–3 simple tables/diagram-descriptions; light `[n]` citations. Every mechanic marked built vs proposed honestly.

- [ ] **Step 2: Deliberation paper draft.** Scholarly, 8,000–12,000 words, following `outline-deliberation.md`. Sections: Abstract, Introduction (problem), Literature Review, Theoretical Framework, Proposed Design (Hoojah) + justification, Built vs Proposed, Discussion, Limitations & Future Work, References. Formal academic register; `[n]` citations throughout.

- [ ] **Step 3: CSCW paper draft.** Scholarly, 8,000–12,000 words, following `outline-cscw.md`. Same scholarly section structure, CSCW lens, explicit comparison table to ConsiderIt / Kialo / Reflect / Deliberatorium.

- [ ] **Step 4: Verify each draft.** For each: word count in range (`wc -w`); every `[n]` resolves to a bibliography entry; no fabricated citation (spot-check 3 per doc against `bibliography.md`); built-vs-proposed claims consistent with `dossier.md`. Gate: all three pass before P3.

---

## Task 5 (P3): Assemble self-contained HTML

**Files:**
- Create: `docs/hoojah-white-paper.html`, `docs/hoojah-research-deliberation.html`, `docs/hoojah-research-cscw.html`

**Agent:** one Opus subagent (owns a shared inline-CSS template for consistency across all three).

- [ ] **Step 1: Build the template.** A single self-contained HTML skeleton: inline `<style>` only (no CDN, no site-CSS dependency), print-friendly (`@media print`), readable measure (~68ch), Batik-tinted accents (indigo/emerald/saffron as section rules only — not a full re-skin), numbered reference list styling, a citation-superscript style, and a simple table style. Theme-aware is not required (these are documents), but set explicit background/text colors.

- [ ] **Step 2: Render all three drafts** into the template — headings, tables, blockquotes, and a `<ol>` reference list with `id="ref-n"` anchors that in-text `<sup><a href="#ref-n">[n]</a></sup>` link to. Each doc's title in `<title>` and an `<h1>`. Add a small "Status: working paper · 2026" note and an author line.

- [ ] **Step 3: Verify render.** For each file: valid HTML (open in headless check or grep for balanced core tags), no `http://`/CDN `<link>`/`<script src>` (self-contained), every `<sup>` ref anchor has a matching `id="ref-n"`. Gate: zero broken ref anchors, zero external asset references.

- [ ] **Step 4: EditorConfig compliance.** LF, UTF-8, 2-space indent, final newline, no trailing whitespace (per repo `.editorconfig` for served HTML).

- [ ] **Step 5: Commit.**
```bash
git add docs/hoojah-white-paper.html docs/hoojah-research-deliberation.html docs/hoojah-research-cscw.html
git commit -m "Add Hoojah White Paper + two Master Research papers (docs/)"
```

---

## Task 6 (P4): Fable rigor + citation-integrity review

**Agent:** Fable 5 as reviewer, given the three HTML files + `bibliography.md`.

- [ ] **Step 1:** Fable reviews each doc for: scholarly rigor (does each claim earn its citation; is the argument sound), digestibility (White Paper only — is it actually accessible), internal consistency (built vs proposed), and **citation integrity** (every reference real + verified). Returns a findings list ranked by severity.

- [ ] **Step 2:** Dispatch an Opus subagent to apply the findings (fixes to the HTML). Re-verify ref anchors after edits.

- [ ] **Step 3: Verify + commit.**
```bash
git add docs/hoojah-*.html
git commit -m "Apply Fable rigor + citation-integrity review to Hoojah papers"
```

---

## Task 7 (P5): Export papers back to Google Docs

**Agent:** main session (has Drive MCP `create_file`).

- [ ] **Step 1:** For each paper, create a native Google Doc (`application/vnd.google-apps.document`) from the paper's text content (headings + references preserved), in the correct folder:
  - White Paper → parent `1ryiRKn6219wVEyeyQJyHJ31wzs5KxnMr` (Whitepaper/)
  - Deliberation paper → parent `1G3jsjg_P53k2UF6lAHWUkhNHOzvTSQUa` (Masters Research/)
  - CSCW paper → parent `1G3jsjg_P53k2UF6lAHWUkhNHOzvTSQUa` (Masters Research/)
  Titles: "Hoojah White Paper (2026)", "Hoojah — Deliberation & Argumentation (Master Research, 2026)", "Hoojah — CSCW & Structured Debate (Master Research, 2026)".

- [ ] **Step 2:** Do **not** overwrite the 2020 drafts. Verify each new Doc exists via `search_files` on its parent folder and record the three `viewUrl`s to report to the owner.

---

## Task 8 (P6): write-like-me pass on four posts

**Sub-skill:** `write-like-me` (routes Work/Life/Balance voice). One post per subagent, sequential enough to keep voice consistent.

- [ ] **Step 1: `work/2020-09-01-the-hoojah-project.html`** (Work voice). Refresh to current app reality (Hotwire debate platform, not the old stack), and add a cross-link block to the three new `/docs/` papers. Preserve structure and the owner's voice. No em-dashes.

- [ ] **Step 2: `life/2021-01-03-kenapa-rudzainy-buat-hoojah.html`** (Life voice, Malay). **Light additive touch only** — do not rewrite the personal narrative (editorial personal-posts boundary). Add at most a short current-state note + a single cross-link to the White Paper. If it reads as intimate/personal, add only the cross-link.

- [ ] **Step 3: `balance/_2024-04-06-reactjs-and-rails-the-hoojah.html`** (Balance voice). **Reframe as history:** keep the React/Rails era honest as an earlier chapter, add a bridge paragraph to the current Hotwire rebuild, cross-link the White Paper. (Note: file keeps its `_` draft prefix unless owner asks to promote.)

- [ ] **Step 4: `work/2026-08-12-rombak-lyn-forum.html`** (Work voice). Cross-link to the papers **only if** the forum piece is topically related to structured debate; otherwise leave untouched and report why.

- [ ] **Step 5: Verify.** Grep all four edited files for em-dashes (`—`) introduced by the pass (must be zero new). Confirm cross-links resolve to the real `docs/*.html` filenames. Confirm no `twitter.com`→`x.com` rewrites occurred.

- [ ] **Step 6: Commit.**
```bash
git add work/2020-09-01-the-hoojah-project.html life/2021-01-03-kenapa-rudzainy-buat-hoojah.html balance/_2024-04-06-reactjs-and-rails-the-hoojah.html work/2026-08-12-rombak-lyn-forum.html
git commit -m "Refresh Hoojah blog posts in owner voice; cross-link new papers"
```

---

## Final verification (whole-plan gate)

- [ ] Three `docs/hoojah-*.html` exist, self-contained, ref anchors intact, word counts in range.
- [ ] `bibliography.md` has zero unverified entries; every in-text `[n]` across all docs resolves.
- [ ] Three Google Docs created in the correct Drive folders; 2020 drafts untouched; `viewUrl`s recorded.
- [ ] Four posts refreshed in-voice, no new em-dashes, cross-links resolve, personal-post boundary respected.
- [ ] Report to owner: the three doc paths, three Drive URLs, and a one-line summary of each post change.
