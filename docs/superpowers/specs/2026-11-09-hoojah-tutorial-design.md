# Hoojah tutorial post — design

Date: 2026-11-09
Status: approved (requested directly by owner)
Deliverable: `balance/2026-11-09-how-to-use-hoojah.md`

## Problem

The site describes Hoojah twice (the 2020 Work case study and the 2021 Rakita
podcast post) but both describe the 2020 React-era product. Hoojah has since been
rebuilt on Rails 8 + Hotwire and gained follows, @mentions, one-on-one debates
with a spectator verdict, badges, trending, blocking, private accounts, a
personal dashboard, passkeys, dark mode and the Spectrum stance palette. Nobody
reading the site can learn how to actually use it today.

## Shape

A **Balance how-to** (Balance already holds the site's tutorials), in the
journal template (`balance/2024-05-09-how-to-validate-an-email-address-in-rails.md`
is the exemplar). Written for a first-time user, not a developer: what to click,
what happens, and why it works that way. Developer internals appear only as a
one-line "why" aside where they explain behaviour a user can see (secret ballot,
derived debate phases, private gate).

Voice: `docs/superpowers/write-like-me-skill`, Balance how-to sub-mode. Hard rule:
no em-dash anywhere.

## Outline

Intro: what Hoojah is in one breath (hujah = claim; agree / neutral / disagree).

1. Sign up and sign in (password, Google, passkey; managing passkeys).
2. Read the feed (global vs Following tab, Trending).
3. Post your first hoojah (`/hoojah/new`, @mentions).
4. Vote, and why your vote is a secret ballot.
5. Respond with a stance (stance-tagged replies, the response filter).
6. Escalate to a debate (challenge, accept/decline, turns and phases, live
   updates, conclude, spectator verdict, 7-day auto-conclude).
7. Your people (follow, private accounts and requests, block).
8. Your corner (profile edit + photo, notifications, dashboard, badges, dark mode).
9. Share and flag.

Closing: soft, open ending (Hotwire Native is next) + links to the Work case
study and the podcast post, guarded on `live_urls`.

## Facts rule

Every feature, route, label and number must be verified against either the live
site (https://hoojah.rudzainy.com) or `hoojah-beta` source on its current
branch. UI labels are quoted as they appear in the views. Anything unverifiable
is cut, not guessed.

## Screenshots

Public screens only (feed, single hoojah, trending, a public profile, a concluded
debate, login), captured from the live site with Playwright into
`images/posts/hoojah-tutorial/`, wrapped in `.smart-image` / `.post-figure`. No
account is created on production; signed-in screens are described in prose.

## Wiring

- Front matter: `layout: post`, `category: balance`, `data_category: balance`,
  `permalink: /balance/2026-11-09-how-to-use-hoojah.html`, tags
  `["hoojah", "tutorial", "ruby on rails"]`.
- `.post-section-head` rule tabs on every h2 (numbered, one Lucide icon, kicker
  decided once for the whole post), first one `.is-first`-free (journal post).
- Card at the top of the 2026 year group in `balance/index.html`, `live_urls`
  guarded.
- Row in `INDEKS.md`.
- No literal Liquid in prose.

## Done when

Jekyll build emits no warnings, `ruby tools/check-links.rb` reports
`Broken (site): 0`, voice lint finds no em-dash, and an independent reviewer
has checked every factual claim against source.
