# Hoojah tutorial post — plan

Spec: `docs/superpowers/specs/2026-11-09-hoojah-tutorial-design.md`
Method: subagent-driven (implementer → independent review → batched fixes → re-verify).

## Task 1 — Feature brief (research subagent)
Walk the live site and `hoojah-beta` source (routes, views, policies, FEATURES.md,
HANDOVER.md). Output a verified brief: per outline section, the exact routes, button
and tab labels, flows, limits (e.g. 5-vote suppression, 7-day timeout), and the
"why" behind visible behaviour. Flag anything in FEATURES.md the live site
contradicts. Capture public-screen screenshots.

## Task 2 — Draft the post (implementer subagent)
From the brief, write `balance/2026-11-09-how-to-use-hoojah.md` in the journal
template and Balance how-to voice, add the guarded index card and the INDEKS row.
Build and run the link checker.

## Task 3 — Review (reviewer subagent)
Independently check: spec compliance, every factual claim against source, voice
lint (em-dash grep, `x.com`), template contract (`.post-section-head` siblings,
guards), build and link check. Report findings; do not fix.

## Task 4 — Fixes and re-verify
Apply batched fixes, rebuild, re-run link check, commit and push.
