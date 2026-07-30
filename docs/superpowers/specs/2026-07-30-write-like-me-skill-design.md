# Design: `write-like-me` skill

**Date:** 2026-07-30
**Status:** Approved, pending implementation plan

## Purpose

A personal Claude Code skill that helps the owner (Rudzainy) write in his own
voice for the `rudzainy.github.io` portfolio site. The site's public copy is the
owner's own voice: casual, playful, first-person, a little self-deprecating,
Malay woven in, emoji as accents. AI-flat or formal drafts read wrong. This skill
codifies that voice and puts it to work.

The three site categories (Work, Life, Balance) have distinct tonal registers, so
the skill is voice-core + three category-tuned reference files.

## Location & invocation

- **Global skill:** `~/.claude/skills/write-like-me/` (same tier as `graphify`;
  not checked into the repo).
- **Trigger:** `/write-like-me`.
- **Repo-aware routing:** if the target file lives under `work/`, `life/`, or
  `balance/`, auto-route to that category. Otherwise ask which category, or none
  (voice-core only) for general copy like the homepage.

## Structure

```
~/.claude/skills/write-like-me/
  SKILL.md              # frontmatter + voice core + 4 jobs + router + guardrails
  references/
    work.md             # case-study / portfolio voice
    life.md             # personal / journal voice
    balance.md          # thoughts / opinion / how-to voice
    lint-checklist.md   # deterministic grep + soft AI-tell checklist
```

Progressive disclosure: `SKILL.md` is always read; the router loads exactly one
`references/<category>.md` on demand (plus `lint-checklist.md` for the Lint job).
The model never loads all three category voices at once.

## SKILL.md contents

### Frontmatter
```yaml
---
name: write-like-me
description: <one line: draft/rewrite/lint copy in Rudzainy's voice for the portfolio site; routes to Work/Life/Balance>
trigger: /write-like-me
---
```

### Voice core (shared across all categories)
Distilled from memory + exemplars:
- Casual, playful, first-person; a little self-deprecating.
- Malay woven in naturally (code-switch, not translated).
- Emoji as occasional accents, not decoration on every line.
- Rhythm: short punchy sentences mixed with longer riffs.

**Hard rules (invariants):**
- **Never the em-dash `—` (U+2014).** Use commas, periods, colons, or
  parentheses. En-dash `–` is fine in numeric ranges (e.g. `2022 – 2023`).
- **No STE / controlled-language flattening.** Do not robotify the prose. If
  asked for a "simplified / technical English" pass, confirm tone first.
- **Keep `twitter.com`.** Never rewrite `twitter.com` links or references to
  `x.com`.

### The four jobs
Each is a short procedure in SKILL.md:

1. **Draft** - from a brief, produce copy in the routed category voice.
   Personal/intimate posts: draft freely, but the output is a starting draft the
   owner rewrites (clay), not finished copy. (This job only runs on explicit
   `/write-like-me` invocation; it is not license to fill personal posts
   unprompted elsewhere.)
2. **Rewrite** - re-voice flat / formal / AI-sounding text into the owner's
   voice with minimal change to meaning.
3. **Lint** - run `references/lint-checklist.md`: the grep one-liner for
   deterministic hits (em-dash, `x.com`) plus the soft checklist by reading.
   Report hits with locations; do not auto-fix unless asked.
4. **Reference** - answer "how would I phrase X" / explain a voice choice
   without producing a full draft.

### Router
Determine category from the target file path (`work/|life/|balance/`) or ask.
Load the matching `references/<category>.md`. For non-category copy, use
voice-core only.

### Guardrails (restated near the jobs)
- No em-dash; en-dash only in ranges.
- No STE flattening without tone confirmation.
- Keep `twitter.com`.
- Draft output for personal/intimate content is clay, flagged as such.

## references/<category>.md contents

Each category file, built by reading the owner's hand-picked exemplars, contains:
- **Fingerprint:** tone, sentence rhythm, vocabulary, structural habits,
  signature quirks specific to that category.
- **3-4 real quoted lines** pulled verbatim from the exemplars as calibration.
- **Category do / don't** notes.

### Exemplar sources (owner-selected)

**Work** (case studies / portfolio):
- `work/2020-09-01-the-hoojah-project.html`
- `work/2017-09-01-design-review-jkm-web-portal.md`
- `work/2009-08-06-altfa-solution-logo.md`
- `work/2011-09-01-malaysia-maritime-association-logo-website.md`

**Life** (personal / journal):
- `life/2021-01-03-kenapa-rudzainy-buat-hoojah.html`
- `life/2024-01-06-of-javascript.html`
- `life/2024-01-03-of-books.md`
- `life/2024-06-20-of-operating-systems.md` (unfinished - raw in-progress voice)

**Balance** (thoughts / opinion / how-to):
- `balance/2023-12-25-of-twitter.html`
- `balance/2023-12-23-ranting.html`
- The 16 legacy `.md` posts dated before `balance/2023-11-29-of-mlbb.md`
  (2003-2023: family, tm-parody-ad, jantan, hearts, browsercrush-clone,
  teng-quora, kontact, self-improvement, orang-kasar, life, teater-neon,
  melihat, thoughts-explosion, not-the-stage-manager, of-workshops, 16-384).

Note: exemplars include both served `.html` and legacy `.md` sources. The `.md`
files are often the purer, pre-editorial voice. Extract voice from prose only;
ignore front matter, Liquid tags, and HTML scaffolding.

## references/lint-checklist.md contents

- **Deterministic grep one-liner** the model can run, e.g.
  `grep -nP '\x{2014}' <files>` for em-dashes and a `grep -n 'x\.com'` for the
  twitter rewrite rule. No build step, no dependencies.
- **Soft checklist** (applied by reading): STE flatness, generic AI-tells
  (e.g. "delve", "moreover", "it's not just X, it's Y", over-tidy tricolons,
  hollow hedging), lost Malay code-switch, emoji overuse.

## Out of scope (YAGNI)

- No automated voice-mining / model-trained style transfer. Voice comes from the
  hand-picked exemplars only.
- No separate top-level `/write-work` etc. skills. One skill, one router.
- No CI hook or pre-commit integration for Lint. Manual invocation only.
- Does not touch or regenerate the `.okf/` bundle.

## Success criteria

- `/write-like-me` on a `work/`, `life/`, or `balance/` file routes to the right
  voice and produces copy the owner recognizes as his, needing light edits.
- Lint reliably catches every em-dash and `x.com` occurrence.
- The skill never emits an em-dash, never flattens to STE, never rewrites
  `twitter.com`.
