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

1. **Never use the em-dash (Unicode U+2014, the long dash).** Use commas,
   periods, colons, or parentheses instead. The shorter en-dash (U+2013) is
   fine only inside numeric ranges (e.g. `2022 – 2023`).
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
