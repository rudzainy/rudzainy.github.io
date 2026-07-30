# Voice Lint Report + Action Plan (2026-07-30)

> **STATUS UPDATE (same day):** Tiers A, B, and C are all DONE (commit
> `dfd8917`). Re-voiced `users-vs-corporations` and
> `malaysia-communication-framework` (byline/"I envision" confirmed the substance
> was the owner's), de-glossed `dxc-bionix-design-system`, and drafted all 10
> owner TODOs on `dxc-bionix-central` as `DRAFT for owner review` comments
> (kept in comments, not shipped, awaiting the owner's real facts). Also fixed
> the wrong `ka7Sk0` Bootstrap hash on the two Tier-A files. Only the 3 confirmed
> false positives remain flagged, left alone on purpose. Nothing pushed.

Ran the `/write-like-me` Lint job across all **53 served** `.html` posts
(`work/` 20, `life/` 10, `balance/` 23). The 29 `_`-prefixed `.html` files are
**not served** (Jekyll skips leading-underscore files), so they were excluded.

Method: deterministic greps (em-dash U+2014, `x.com`) plus an AI-tell phrase
list, deliberately **excluding the author's genuine design-crit verbs**
(encapsulate, signify, underscore, illustrate) so his real voice isn't flagged.

## Headline numbers

- **Visible em-dashes: 0** across all served posts (was 21 across 7 files).
- **`x.com` rewrites: 0** (twitter.com rule intact everywhere).
- 39/53 posts were clean at the start; after this pass, **7 files remain
  flagged**, all soft-tell (no em-dash), 3 of which are confirmed false
  positives.

## Fixed this pass (committed, not pushed)

`ccb4a94` re-voiced the Hoojah case study (separate, heavier job).
`13e9240` low-hanging fixes across 10 posts:

| File | What was fixed |
|---|---|
| `work/2019-09-01-dxc-bionix-central.html` | 3 visible em-dashes (stub page; 4 more live in owner TODO comments, left alone) |
| `work/2019-09-01-dxc-bionix-design-system.html` | 6 em-dashes (residual gloss deferred to Tier B) |
| `work/2025-09-11-day-food-catalogue.html` | 2 em-dashes + "leverages/leveraged" glossy summary |
| `work/2011-09-01-malaysia-maritime-association-logo-website.html` | 1 em-dash (kept "North Star", it's his genuine logo copy) |
| `life/2021-01-03-kenapa-rudzainy-buat-hoojah.html` | 2 em-dashes + softened "deep dive" card blurb |
| `life/2024-01-03-of-video-games.html` | 2 em-dashes |
| `life/2024-01-03-of-books.html` | 1 em-dash |
| `life/2023-12-04-of-maritime-academy.html` | "fostering a"/"cultivate holistic growth and enhance overall learning" gloss |
| `balance/2024-09-05-the-framework.html` | "empowering"/"seamlessly" |
| `balance/2024-06-16-...windows-vs-macos.html` | "seamless" |

## Action plan for what remains

### Tier A — full re-voice (reads AI-authored; use `/write-like-me` Rewrite per page)
1. **`balance/2023-12-04-users-vs-corporations-in-digital-communication.html`**
   (score 21: realm of ×2, empowerment ×2, furthermore, seamless integration,
   cutting-edge). Whole essay reads generated. Highest priority. Balance voice,
   opinion sub-mode. Confirm with the owner whether the *argument* is his before
   re-voicing, this one may be AI-authored end to end, not just AI-polished.
2. **`work/2017-01-01-malaysia-communication-framework.html`**
   (score 12: rich tapestry, leveraging technology, moreover, empowered ...
   fostering unity). Classic AI gloss. Work voice, but this is a conceptual
   framework piece, confirm the substance is his.

### Tier B — light targeted de-gloss (1-2 sentences, not a full rewrite)
3. **`work/2019-09-01-dxc-bionix-design-system.html`** — em-dashes already gone.
   Left: "a well-structured design system isn't just about visual consistency,
   it's about creating a shared language", "the best design work happens at the
   intersection", "the value of adaptability ... we pivoted to solutions",
   "Empower the user through direct and effortless experiences" (a stated design
   principle, arguably fine). Soften the first three; leave the maxim if he likes
   it.

### Tier C — housekeeping
4. **`work/2019-09-01-dxc-bionix-central.html`** is an unfinished stub with
   `<!-- owner: ... -->` TODO comments that contain 4 em-dashes. Not shipped copy.
   When the page is finished, drop the em-dashes and remove the TODO comments.

### No action — confirmed false positives (his genuine voice, leave as-is)
- `balance/2023-12-23-ranting.html` "when it comes to" (a voice exemplar).
- `work/2011-09-01-mma-logo.html` "North Star / guiding light" (his literary
  logo copy; it's in the Work fingerprint).
- `life/2023-09-01-let-s-work-together.html` "whether you're" / "the power of
  collaboration" (he hand-voiced this hire-me page recently, on purpose).

## Tooling follow-up
- Add an author allowlist to the skill so confirmed-genuine phrases ("when it
  comes to", "North Star", "the power of collaboration", his design-crit verbs)
  aren't re-flagged. Candidate home: a `references/lint-allowlist.md` the Lint
  job consults.
- Re-run this sweep after any `_`-prefixed draft is un-prefixed for publishing.
