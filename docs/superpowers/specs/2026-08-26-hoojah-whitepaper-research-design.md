# Hoojah — White Paper + Master Research build

**Date:** 2026-08-26
**Owner:** Rudzainy Rahman
**Status:** Approved design → implementation

## Goal

Produce three scholarly/technical documents that **argue a case** for Hoojah (the
Malaysian social debate platform, `~/code/hoojah-beta`, live at
https://hoojah.rudzainy.com) and then refresh the site's existing Hoojah blog posts in
the owner's voice. Sources are the `hoojah-beta` codebase (shipped reality **and**
roadmap), the owner's Google Drive folder, and publicly available academic literature
cited up to today's date.

## Framing (load-bearing — set by owner)

**The papers are the primary artifact; the app follows the papers.** These are
**forward-looking problem→solution research** documents: they identify problems in
online discourse (grounded in literature), and **propose** design solutions. Hoojah is
the vehicle — the proposed and partially-realized solution. The shipped `hoojah-beta` is
the concrete grounding for what already exists; the papers may also argue for
not-yet-built features on the roadmap (one-on-one debate spectator verdict, analytics,
identity verification, etc.). The eventual fully-built app is meant to read as the
**outcome** of this research. Structure each paper as **problem → proposed solution →
justification (theory + evidence)**, not as a retrospective description of the codebase.

The **civic-data / "Malaysian data accessible to Malaysians"** motivation from the 2020
vision drafts is **background/context only** — mentioned to situate origin and intent,
carried a little more in the White Paper, but the two scholarly papers are anchored on
their chosen lenses (deliberation+argumentation; CSCW), not on data governance.

## Deliverables

Three **standalone, self-contained HTML** documents in `docs/` (NOT linked from site
nav, NOT restructuring the site; shareable by URL):

1. **`docs/hoojah-white-paper.html`** — ~3,000–4,000 words. Technical but digestible
   for a general audience. Problem→solution: the problem with online discussion (likes
   without stance, engagement-optimized noise), then Hoojah's proposed answer — the
   hujah → agree/neutral/disagree → one-on-one debate mechanic; architecture (Rails 8.1,
   server-rendered Hotwire, Action Cable real-time turns); the secret-ballot privacy
   model; trending/badges; and the roadmap the paper argues toward. Diagrams/tables,
   light citation. Carries the civic-data motivation as origin context.

2. **`docs/hoojah-research-deliberation.html`** — Master Research **Paper A**,
   ~8,000–12,000 words, top-quality scholarly. Lens: **deliberative democracy +
   computational argumentation**. Problem: degraded online deliberation. Proposed
   solution: Hoojah as designed deliberation infrastructure (stance-tagged argument,
   structured one-on-one debate, spectator verdict). Abstract, literature review,
   theoretical framework, the proposed design + justification against the theory,
   what is built vs proposed, discussion, limitations, references.

3. **`docs/hoojah-research-cscw.html`** — Master Research **Paper B**,
   ~8,000–12,000 words, top-quality scholarly. Lens: **social computing / CSCW**.
   Problem: incivility, noise, and decision fatigue in social-media discussion UX.
   Proposed solution: Hoojah's structured-debate interaction design — stance grouping,
   secret ballot, turn-based debate, spectator verdict as a design pattern — positioned
   against ConsiderIt, Kialo, Reflect, and similar systems. Same scholarly problem→
   solution→justification structure.

Then a **write-like-me pass** on four existing posts (owner's voice, not scholarly):

- `work/2020-09-01-the-hoojah-project.html` — main case study; refresh to current app
  reality, cross-link the new docs.
- `life/2021-01-03-kenapa-rudzainy-buat-hoojah.html` — personal "why" (Malay). **Light,
  additive touch only** (factual refresh + cross-link); do not rewrite the personal
  narrative. Respects the editorial personal-posts boundary.
- `balance/_2024-04-06-reactjs-and-rails-the-hoojah.html` — technical snippet, currently
  a draft (leading `_`). **Reframe as history**: keep the React/Rails era honest as an
  earlier chapter, then bridge to the current Hotwire rebuild.
- `work/2026-08-12-rombak-lyn-forum.html` — adjacent forum piece; cross-link only if
  relevant.

## Build method: Fable orchestration + subagent-driven development

- **Fable 5 = architect/advisor.** Produces the three document outlines + a citation
  strategy up front; later runs the rigor/digestibility review pass. Low token cost,
  high leverage. (Per the `fable-orchestration` skill: advisor mode + architect-and-delegate.)
- **Opus 4.8 subagents = execution.** The token-heavy mining, searching, drafting, and
  HTML assembly, dispatched in parallel where independent (per
  `superpowers:subagent-driven-development` and `dispatching-parallel-agents`).

### Phases

- **P0 — Sources.** One subagent mines `hoojah-beta` (README, `docs/FEATURES.md`,
  `docs/superpowers/HANDOVER.md`, `docs/superpowers/ROADMAP-future-features.md`, models,
  policies, routes, design-system docs) into a structured **primary-source dossier**
  (features, domain model, debate/vote mechanics, privacy model, real-time design,
  metrics, **built-vs-proposed roadmap**, design decisions). The Google Drive folder is
  folded into the same dossier.

  **Drive inventory (confirmed, folder `10Y_lBBw6pb…`):**
  - `Whitepaper/` → draft "Hoojah: To Make Malaysian Data Accessible to Malaysians"
    (skeletal, 2020) + `Business Plan.docx`. Original civic-data vision + business model.
  - `Masters Research/` → draft "Hoojah: A User-Experience-First Approach to Better
    Discussions on The Internet" (skeletal, 2020) — **this UX-first thesis is the closest
    match to the chosen framing**; use as positioning input, not content to preserve.
  - `Masters Research/Research Papers/` → **4 owner-selected seed academic PDFs**:
    `reflect.pdf` (Reflect / ConsiderIt lineage), `To Comment or Not To Comment.pdf`,
    `Social Networking is Coming.pdf`, `327266594.pdf`. Read + identify each; verify full
    citation via web search; use as anchor citations and snowball outward.
  - Decks (`Hoojah.pptx`, `Short Deck`, `Pitching Deck`, `Show & Tell`), `How To Use
    Hoojah Script (EN/BM)`, `Topics`, `PitchIn Campaign`, `Seed` sheet — secondary;
    mine only for problem-statement framing, positioning, and terminology.

  The drafts are outlines with placeholder prose — treat them as **intent/positioning
  signal**, not text to lift. The shipped app + roadmap are authoritative for mechanics.
- **P1 — Literature** (parallel, two tracks). Track A: deliberative democracy +
  computational argumentation. Track B: social computing / CSCW / online-discussion
  design. Output: a **verified shared bibliography** — every entry a real, publicly
  checkable paper (title, authors, year, venue, DOI/URL), confirmed via web search.
- **P2 — Drafting** (parallel, three documents) grounded in the dossier + bibliography.
- **P3 — HTML assembly.** Clean, print-friendly academic HTML; numbered in-text
  citations + a reference list; lightly echoes the Batik palette but is fully
  self-contained (inline CSS, no site-CSS dependency). Files land in `docs/`.
- **P4 — Review.** Fable rigor + citation-integrity pass; fix findings.
- **P5 — Drive export-back.** Each finished paper is exported to a **Google Doc in its
  respective Drive folder**:
  - White Paper → `Whitepaper/` (folder `1ryiRKn6219wVEyeyQJyHJ31wzs5KxnMr`).
  - Both Master Research papers → `Masters Research/` (folder
    `1G3jsjg_P53k2UF6lAHWUkhNHOzvTSQUa`).
  Created as native Google Docs (`application/vnd.google-apps.document`) with clean
  heading structure and the reference list; titled to match each paper. The `docs/*.html`
  files remain the source of record; the Google Docs are exported copies for the owner's
  Drive. Existing 2020 draft docs are left in place (not overwritten).
- **P6 — write-like-me.** The four posts, via the `write-like-me` skill, cross-linked
  to the new documents.

## Guardrails (non-negotiable)

- **Citation integrity.** Every reference is a real, publicly verifiable academic work.
  Subagents confirm each via web search; anything unverifiable is cut, never fabricated.
  In-text claims map to a real source. No invented DOIs, venues, or author lists.
- **Voice split.** Papers are formal/scholarly. The four blog posts stay in the owner's
  casual first-person voice via `write-like-me`. **No em-dashes in the blog copy**
  (per voice memory); standard academic punctuation is fine inside the papers.
- **Personal-post boundary.** The Malay "why" post gets a light additive touch only.
- **Honesty over continuity.** The React/Rails post is reframed as a historical chapter,
  not retconned; Hoojah today is Hotwire with no React.
- **No site restructuring.** Docs are unlisted `/docs/` files; site nav and indexes are
  untouched except for cross-links added inside the four posts.
- **Pages/Jekyll safety.** `docs/` HTML is copied through untouched; do not introduce
  literal `{%`/`{{` Liquid sequences into any published `.md`. (These deliverables are
  `.html`, so unaffected, but the constraint stands for any prose added to posts.)

## Out of scope

- Publishing the papers as indexed site pages or nav entries.
- Changes to the `hoojah-beta` codebase.
- OKF bundle regeneration.

## Dependencies

- Google Drive connector: **authenticated and confirmed** (2026-08-26). Folder inventory
  read and captured in P0 above.
- The `write-like-me` skill (present) drives P5.
