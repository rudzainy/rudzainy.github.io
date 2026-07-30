# write-like-me Skill Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking. Also load **superpowers:writing-skills** before Task 1 — it governs skill frontmatter and structure conventions.

**Goal:** Build a global Claude Code skill, `/write-like-me`, that drafts, rewrites, lints, and references copy in Rudzainy's voice, routing to Work / Life / Balance category voices built from owner-picked exemplars.

**Architecture:** One skill directory at `~/.claude/skills/write-like-me/`. `SKILL.md` holds the shared voice core, the four jobs (Draft/Rewrite/Lint/Reference), a category router, and guardrails. Three `references/<category>.md` files hold per-category voice fingerprints with verbatim exemplar quotes, loaded one at a time on demand. `references/lint-checklist.md` holds a deterministic grep plus a soft AI-tell checklist. A final step snapshots the finished skill into `docs/superpowers/write-like-me-skill/` (excluded from the Pages build) for version control.

**Tech Stack:** Plain Markdown skill files (Claude Code skill format: YAML frontmatter + Markdown body). No build, no runtime, no dependencies. Verification is by shell (`grep`, `test`, frontmatter inspection).

**Verification model (read this first):** The skill target lives outside any git repo, so tasks do not `git commit` per step. Instead every task ends with an explicit **Verify** step. The single source of truth for "the voice" is the owner's hand-picked exemplars; the binding correctness check for each reference file is that every quoted line appears **verbatim** in its cited source file. TDD discipline is preserved as: state the check → run it → confirm the expected result → only then move on.

**Exemplar sources (do not substitute):**
- Work: `work/2020-09-01-the-hoojah-project.html`, `work/2017-09-01-design-review-jkm-web-portal.md`, `work/2009-08-06-altfa-solution-logo.md`, `work/2011-09-01-malaysia-maritime-association-logo-website.md`
- Life: `life/2021-01-03-kenapa-rudzainy-buat-hoojah.html`, `life/2024-01-06-of-javascript.html`, `life/2024-01-03-of-books.md`, `life/2024-06-20-of-operating-systems.md`
- Balance: `balance/2023-12-25-of-twitter.html`, `balance/2023-12-23-ranting.html`, and the 16 legacy `.md` files dated before `balance/2023-11-29-of-mlbb.md`

All paths above are relative to the repo root `/Users/deepsight/code/rudzainy.github.io`.

---

## File Structure

Created at `~/.claude/skills/write-like-me/`:

| File | Responsibility |
|---|---|
| `SKILL.md` | Frontmatter + voice core + 4 jobs + router + guardrails. Always loaded. |
| `references/work.md` | Work (case-study) fingerprint + verbatim quotes + do/don't. |
| `references/life.md` | Life (personal/journal) fingerprint + verbatim quotes + do/don't. |
| `references/balance.md` | Balance (thoughts/opinion/how-to) fingerprint + verbatim quotes + do/don't. |
| `references/lint-checklist.md` | Deterministic grep one-liners + soft AI-tell checklist. |

Snapshot copy (version-controlled, unshipped): `docs/superpowers/write-like-me-skill/` mirroring the above.

---

## Task 1: Scaffold directory + SKILL.md

**Files:**
- Create: `~/.claude/skills/write-like-me/SKILL.md`
- Create dir: `~/.claude/skills/write-like-me/references/`

- [ ] **Step 1: State the checks this task must pass**

The finished `SKILL.md` must: (a) parse as valid frontmatter with `name: write-like-me`; (b) contain zero em-dash characters (U+2014); (c) name all four jobs; (d) describe the router; (e) restate the three hard rules.

- [ ] **Step 2: Create the directory**

```bash
mkdir -p ~/.claude/skills/write-like-me/references
```

- [ ] **Step 3: Write `SKILL.md`**

Write this exact content:

````markdown
---
name: write-like-me
description: Draft, rewrite, or lint copy in Rudzainy's own voice for the rudzainy.github.io portfolio site. Use when writing or revising site copy, when asked to "write like me" / "in my voice", or when working on any file under work/, life/, or balance/. Routes to a Work, Life, or Balance voice.
trigger: /write-like-me
---

# write-like-me

Write copy in Rudzainy's voice for the portfolio site. The site's public copy is
his own voice: casual, playful, first-person, a little self-deprecating, Malay
woven in, emoji as accents. AI-flat or formal drafts read wrong. This skill puts
that voice to work.

## Voice core (applies to every category)

- Casual, playful, first-person. A little self-deprecating.
- Malay woven in naturally (code-switch, don't translate it out).
- Emoji as occasional accents, not on every line.
- Rhythm: short punchy sentences mixed with longer riffs.

### Hard rules (never break these)

1. **Never use the em-dash `—` (U+2014).** Use commas, periods, colons, or
   parentheses instead. The en-dash `–` is fine only inside numeric ranges
   (e.g. `2022 – 2023`).
2. **No STE / controlled-language flattening.** Don't robotify the prose. If
   asked for a "simplified / technical English" pass, confirm the tone first.
3. **Keep `twitter.com`.** Never rewrite `twitter.com` links or mentions to
   `x.com`.

## Router: pick the category first

1. If the target file is under `work/`, `life/`, or `balance/`, use that category.
2. Otherwise ask which category (Work / Life / Balance), or use voice-core only
   for general copy like the homepage.
3. Read the matching `references/<category>.md` for the fingerprint and quotes.
   Load only that one. For the Lint job, also read `references/lint-checklist.md`.

## Jobs

### Draft
Produce new copy from a brief, in the routed category voice. For personal /
intimate posts, draft freely but treat the output as a starting draft the owner
rewrites (clay), and say so. This job runs only when explicitly invoked; it is
not license to fill personal posts unprompted elsewhere.

### Rewrite
Re-voice flat / formal / AI-sounding text into the owner's voice. Change the
wording, not the meaning. Preserve facts, links, and structure.

### Lint
Read `references/lint-checklist.md`. Run its grep one-liners for the deterministic
hits (em-dash, `x.com`), then apply the soft checklist by reading. Report each hit
with its location. Do not auto-fix unless asked.

### Reference
Answer "how would I phrase X" or explain a voice choice, without producing a full
draft.

## Guardrails (restated)

- No em-dash. En-dash only in numeric ranges.
- No STE flattening without confirming tone.
- Keep `twitter.com`.
- Personal/intimate drafts are clay, and you flag them as such.
````

- [ ] **Step 4: Verify**

```bash
D=~/.claude/skills/write-like-me
test -d "$D/references" && echo "DIR OK"
head -1 "$D/SKILL.md" | grep -q '^---$' && echo "FRONTMATTER OK"
grep -q '^name: write-like-me$' "$D/SKILL.md" && echo "NAME OK"
grep -Pc '\x{2014}' "$D/SKILL.md" | grep -q '^0$' && echo "NO EM-DASH OK"
for j in Draft Rewrite Lint Reference; do grep -q "### $j" "$D/SKILL.md" || echo "MISSING JOB: $j"; done
echo "checks done"
```
Expected: `DIR OK`, `FRONTMATTER OK`, `NAME OK`, `NO EM-DASH OK`, `checks done`, and no `MISSING JOB` lines.

---

## Task 2: references/work.md (case-study voice)

**Files:**
- Create: `~/.claude/skills/write-like-me/references/work.md`
- Read (sources): the four Work exemplars listed in the header.

- [ ] **Step 1: Read the Work exemplars**

```bash
cd /Users/deepsight/code/rudzainy.github.io
for f in work/2020-09-01-the-hoojah-project.html work/2017-09-01-design-review-jkm-web-portal.md work/2009-08-06-altfa-solution-logo.md work/2011-09-01-malaysia-maritime-association-logo-website.md; do echo "===== $f ====="; cat "$f"; done
```
Read the prose only. Ignore YAML front matter, Liquid tags (`{% ... %}`), and HTML scaffolding (tags, class names, script). You are extracting how he writes about his own work.

- [ ] **Step 2: Write `references/work.md`**

Use this exact skeleton and fill the bracketed slots from what you read. Pick **3-4 short quoted lines that appear verbatim in the sources** (copy them exactly, including his spelling/casing/Malay). Keep the whole file under ~120 lines.

```markdown
# Work voice (case studies / portfolio)

## Fingerprint
- **Tone:** [1-2 lines: how he frames his own work. Proud but plain? Wry?]
- **Rhythm:** [sentence length pattern you observed]
- **Vocabulary:** [recurring words, design/dev jargon he actually uses, Malay code-switch if present]
- **Structure:** [how a piece opens, how it walks through a project, how it closes]
- **Signature quirks:** [emoji use, asides, self-deprecation, specific tics]

## Verbatim calibration quotes
> [exact line 1 from a source]
> [exact line 2 from a source]
> [exact line 3 from a source]

## Do
- [3-5 concrete instructions specific to Work copy]

## Don't
- [3-5 things that would read wrong in Work copy, e.g. marketing gloss, STE flatness]
```

- [ ] **Step 3: Verify every quote is verbatim**

For each quoted line you used, confirm it exists in one of the four source files. Example (repeat per quote, substituting the exact string):

```bash
cd /Users/deepsight/code/rudzainy.github.io
grep -Fq "PASTE THE EXACT QUOTED LINE" work/2020-09-01-the-hoojah-project.html work/2017-09-01-design-review-jkm-web-portal.md work/2009-08-06-altfa-solution-logo.md work/2011-09-01-malaysia-maritime-association-logo-website.md && echo "QUOTE FOUND" || echo "QUOTE NOT FOUND - fix it"
```
Expected: `QUOTE FOUND` for every quote. Any `QUOTE NOT FOUND` means the line was paraphrased; replace it with a real one.

- [ ] **Step 4: Verify no em-dash**

```bash
grep -Pc '\x{2014}' ~/.claude/skills/write-like-me/references/work.md | grep -q '^0$' && echo "NO EM-DASH OK"
```
Expected: `NO EM-DASH OK`. (A quote that itself contains an em-dash is the one allowed exception, since it is his verbatim text; if that happens, keep the quote and note it. Otherwise the count must be 0.)

---

## Task 3: references/life.md (personal / journal voice)

**Files:**
- Create: `~/.claude/skills/write-like-me/references/life.md`
- Read (sources): the four Life exemplars listed in the header.

- [ ] **Step 1: Read the Life exemplars**

```bash
cd /Users/deepsight/code/rudzainy.github.io
for f in life/2021-01-03-kenapa-rudzainy-buat-hoojah.html life/2024-01-06-of-javascript.html life/2024-01-03-of-books.md life/2024-06-20-of-operating-systems.md; do echo "===== $f ====="; cat "$f"; done
```
`of-operating-systems.md` is unfinished; treat it as the rawest, most unedited sample of his in-progress voice. `kenapa-rudzainy-buat-hoojah` is Malay-heavy; capture the code-switch, don't flatten it.

- [ ] **Step 2: Write `references/life.md`**

Same skeleton as Task 2 Step 2, but titled `# Life voice (personal / journal)` and filled from the Life sources. The "Don't" section MUST include: *don't manufacture his private feelings; on intimate posts, Draft output is clay he rewrites, and you say so.*

```markdown
# Life voice (personal / journal)

## Fingerprint
- **Tone:** [...]
- **Rhythm:** [...]
- **Vocabulary:** [note the Malay/English code-switch balance in this category]
- **Structure:** [the "of X" reflective essay shape, if present]
- **Signature quirks:** [...]

## Verbatim calibration quotes
> [exact line 1]
> [exact line 2]
> [exact line 3]

## Do
- [3-5 concrete instructions for Life copy]

## Don't
- Don't manufacture his private feelings. On intimate posts, a Draft is clay he
  rewrites, and you say so.
- [others]
```

- [ ] **Step 3: Verify every quote is verbatim**

Repeat the per-quote `grep -Fq` check from Task 2 Step 3, against the four Life source files. Expected `QUOTE FOUND` for each.

- [ ] **Step 4: Verify no em-dash**

```bash
grep -Pc '\x{2014}' ~/.claude/skills/write-like-me/references/life.md | grep -q '^0$' && echo "NO EM-DASH OK"
```
Expected: `NO EM-DASH OK` (same verbatim-quote exception as Task 2).

---

## Task 4: references/balance.md (thoughts / opinion / how-to voice)

**Files:**
- Create: `~/.claude/skills/write-like-me/references/balance.md`
- Read (sources): `of-twitter.html`, `ranting.html`, and the 16 pre-mlbb legacy `.md` files.

- [ ] **Step 1: List and read the Balance exemplars**

```bash
cd /Users/deepsight/code/rudzainy.github.io
cat balance/2023-12-25-of-twitter.html balance/2023-12-23-ranting.html
echo "===== legacy pre-mlbb .md ====="
ls -1 balance/*.md | sort | awk '/of-mlbb/{exit} {print}' | while read -r f; do echo "===== $f ====="; cat "$f"; done
```
This is the widest corpus (2003-2023). Note that Balance spans two registers: hot opinion/rant (of-twitter, ranting, orang-kasar, jantan) and calm how-to/reflection (self-improvement, melihat, 16-384). Capture both in the fingerprint as sub-modes.

- [ ] **Step 2: Write `references/balance.md`**

Same skeleton, titled `# Balance voice (thoughts / opinion / how-to)`. Add a short note distinguishing the two sub-modes (opinion vs. how-to) so the Draft/Rewrite jobs can pick the right register. Use 4 verbatim quotes: at least one from the opinion mode and one from the how-to/reflection mode.

```markdown
# Balance voice (thoughts / opinion / how-to)

## Fingerprint
- **Tone:** [note the two registers]
- **Two sub-modes:**
  - **Opinion / rant:** [when, and how it reads]
  - **How-to / reflection:** [when, and how it reads]
- **Rhythm:** [...]
- **Vocabulary:** [...]
- **Structure:** [...]
- **Signature quirks:** [...]

## Verbatim calibration quotes
> [opinion-mode quote]
> [how-to/reflection-mode quote]
> [quote 3]
> [quote 4]

## Do
- [3-5 instructions]

## Don't
- [3-5 things to avoid]
```

- [ ] **Step 3: Verify every quote is verbatim**

Per-quote `grep -Fq` check as before, against the Balance source set:

```bash
cd /Users/deepsight/code/rudzainy.github.io
BAL="balance/2023-12-25-of-twitter.html balance/2023-12-23-ranting.html $(ls -1 balance/*.md | sort | awk '/of-mlbb/{exit} {print}' | tr '\n' ' ')"
grep -Fq "PASTE THE EXACT QUOTED LINE" $BAL && echo "QUOTE FOUND" || echo "QUOTE NOT FOUND - fix it"
```
Expected: `QUOTE FOUND` per quote.

- [ ] **Step 4: Verify no em-dash**

```bash
grep -Pc '\x{2014}' ~/.claude/skills/write-like-me/references/balance.md | grep -q '^0$' && echo "NO EM-DASH OK"
```
Expected: `NO EM-DASH OK`.

---

## Task 5: references/lint-checklist.md

**Files:**
- Create: `~/.claude/skills/write-like-me/references/lint-checklist.md`

- [ ] **Step 1: Write `references/lint-checklist.md`**

Write this exact content:

````markdown
# Lint checklist

Run the deterministic greps first, then read for the soft tells.

## Deterministic (run these)

Em-dash (must be zero hits in his copy):
```bash
grep -nP '\x{2014}' <file(s)>
```

twitter.com rewritten to x.com (must be zero hits):
```bash
grep -nE '\bx\.com\b' <file(s)>
```

Report every line number returned. These are hard-rule violations.

## Soft tells (read and judge)

- **STE / robotic flattening:** copy stripped of personality, all sentences the
  same length, no asides. His voice is not this.
- **Generic AI tells:** "delve", "moreover", "furthermore", "it's not just X,
  it's Y", "in today's fast-paced world", over-tidy rule-of-three lists, hollow
  hedging ("it's worth noting that").
- **Lost code-switch:** Malay that got translated out to plain English where he
  would have kept it.
- **Emoji overuse:** emoji on nearly every line, or as decoration rather than
  accent.
- **Marketing gloss:** superlatives and pitch language in place of his plain,
  slightly wry framing.

For each soft tell found, quote the offending text and name the tell. Do not
auto-fix unless asked.
````

- [ ] **Step 2: Verify**

```bash
F=~/.claude/skills/write-like-me/references/lint-checklist.md
grep -qF 'x{2014}' "$F" && echo "EMDASH GREP OK"   # matches the \x{2014} pattern in the file
grep -qF 'x.com' "$F" && echo "XCOM GREP OK"        # matches "rewritten to x.com" + the grep pattern
grep -Pc '\x{2014}' "$F" | grep -q '^0$' && echo "NO EM-DASH OK"
```
Expected: `EMDASH GREP OK`, `XCOM GREP OK`, `NO EM-DASH OK`.

---

## Task 6: Integration self-test

**Files:** none created; this exercises the finished skill.

- [ ] **Step 1: Whole-skill em-dash sweep**

```bash
grep -rPl '\x{2014}' ~/.claude/skills/write-like-me/ ; echo "exit: $?"
```
Expected: no file paths printed, `exit: 1` (grep found nothing). If any path prints, that file has an em-dash. It is only acceptable if it is inside a verbatim `>` quote block; otherwise fix it.

- [ ] **Step 2: Confirm structure**

```bash
D=~/.claude/skills/write-like-me
for f in SKILL.md references/work.md references/life.md references/balance.md references/lint-checklist.md; do test -f "$D/$f" && echo "OK $f" || echo "MISSING $f"; done
```
Expected: five `OK` lines, no `MISSING`.

- [ ] **Step 3: Dry-run the router (Rewrite job) on a real snippet**

Take one flattened test sentence and manually walk the skill: read `SKILL.md`, route by an imagined `life/` path, read `references/life.md`, rewrite. Input to rewrite:

```
It is worth noting that JavaScript is a versatile language which enables many possibilities for the modern developer.
```

Confirm the rewritten output: (a) contains no em-dash; (b) sounds like the Life fingerprint (first-person, casual, code-switch allowed); (c) drops the AI tells ("It is worth noting", "versatile", "modern developer"). This is a human-judged check, not a scripted one. Record the before/after in your task notes.

- [ ] **Step 4: Dry-run the Lint job**

Run the lint greps from `references/lint-checklist.md` against a file that is known to be clean, and against a throwaway string containing an em-dash, to confirm the grep catches one and not the other:

```bash
printf 'clean line\nbad — line\n' > /private/tmp/claude-501/-Users-deepsight-code-rudzainy-github-io/e8e87c27-5e49-4ab2-8aca-75a02e2d0a20/scratchpad/lint-test.txt
grep -nP '\x{2014}' /private/tmp/claude-501/-Users-deepsight-code-rudzainy-github-io/e8e87c27-5e49-4ab2-8aca-75a02e2d0a20/scratchpad/lint-test.txt
```
Expected: exactly one hit, on line 2.

---

## Task 7: Version-control snapshot (provenance)

**Files:**
- Create: `docs/superpowers/write-like-me-skill/` (mirror of the finished skill)

- [ ] **Step 1: Copy the finished skill into the repo (excluded from Pages)**

```bash
cd /Users/deepsight/code/rudzainy.github.io
rm -rf docs/superpowers/write-like-me-skill
cp -R ~/.claude/skills/write-like-me docs/superpowers/write-like-me-skill
```

- [ ] **Step 2: Confirm the snapshot is under the Pages exclude**

```bash
grep -q 'docs/superpowers' _config.yml && echo "EXCLUDED OK"
ls docs/superpowers/write-like-me-skill/references/
```
Expected: `EXCLUDED OK` and the four reference files listed.

- [ ] **Step 3: Commit**

```bash
cd /Users/deepsight/code/rudzainy.github.io
git add docs/superpowers/write-like-me-skill docs/superpowers/plans/2026-07-30-write-like-me-skill.md
git commit -m "Add write-like-me skill (snapshot) + implementation plan"
```
(No Claude/Anthropic trailer, per workspace convention.)

- [ ] **Step 4: Verify the live skill is installed**

```bash
test -f ~/.claude/skills/write-like-me/SKILL.md && echo "LIVE SKILL INSTALLED"
```
Expected: `LIVE SKILL INSTALLED`. The user can now invoke `/write-like-me`.

---

## Notes for the implementer

- **Do not paraphrase in the fingerprints.** The value is in real, verbatim
  quotes. If a quote won't pass the `grep -Fq` check, it is not usable, find one
  that does.
- **Malay stays.** Never translate his code-switch out in any quote or instruction.
- **Keep files focused and short.** Each reference file ~120 lines max. If one
  balloons, you are over-describing, trim to the sharpest observations.
- **Voice-core hard rules are load-bearing.** The skill's own files must obey them
  (no em-dash outside verbatim quotes), or the skill undercuts its own rule.
