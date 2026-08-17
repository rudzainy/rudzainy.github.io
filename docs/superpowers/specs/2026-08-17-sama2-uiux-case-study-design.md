# Sama² UI/UX case study — design

Date: 2026-08-17
Status: approved (framing, spine and outline signed off in conversation)
Deliverable: `work/2026-08-17-sama2-design-system.html`

## Problem

The Work section has no piece about Sama², which is the project with the most
interesting design history in the workspace: a full design language built,
shipped, and then deliberately killed six weeks later. That decision has a real
argument behind it and it is written down. Nothing on the site tells it.

## Spine

**Neumorphism → Paper as the turn.** The case study is built around one
decision: Sama² shipped a bespoke neumorphic design system in late June 2026 and
replaced it wholesale in mid-August 2026, on the grounds that neumorphism is
hostile to the exact users the product is for. Everything before that decision is
run-up; everything after is consequence.

Rejected alternatives, and why:

- *Chronological, evenly weighted* — comprehensive but thesis-free.
- *Current state first, history as evidence* — reads as a product teardown, and
  buries the one genuinely arguable decision.
- *Design-system-as-engineering-program* — sharpest, but it is a systems piece
  wearing a UI/UX label and it duplicates the shape of the DiveOS case study.

## Registration of fact: the repository is older than the product

`git log` in `sama_sama` reaches back to 2016-11-15 and totals 4,052 commits.
Almost none of that is Sama². Every commit before `7edff0f5` (2025-08-13, the
first by Rudzainy Rahman) is upstream Bullet Train framework history inherited by
cloning the starter repo — including Bullet Train's own 2020-11-26 reboot, its
Tailwind adoption, its Turbolinks→Turbo swap and its webpacker→esbuild migration.

The post must state this plainly rather than quoting the flattering number. The
defensible figure is roughly 1,750 commits of Sama²'s own work since 2025-08-13,
across Rudzainy and agent-authored branches. This mirrors the commit-count caveat
already used in the DiveOS case study, and it is also *more* interesting than the
flattering version: Sama² made no greenfield frontend decisions, because the
frontend arrived already made.

## Structure

Five sections, deliberately macro. Detail appears only where it is evidence for a
decision, never as inventory.

**Summary** — what Sama² is and who it is for.

**Stats strip (4)** — ~12 months of Sama²'s own history · 595 commits in May
2026, the peak month · 6 weeks that neumorphism was alive · 138 visual baselines.
Every figure must be verified against the repo before publication.

1. **What Sama² Is, and Who It's For.** A shared organiser for Malaysian
   families, plus a games hub at `/main`, plus Bento-style public profiles on
   custom domains. The stated audience — people who are not digital natives, at
   the low end of digital adoption — is the fact the whole piece turns on, so it
   is established here and not later.

2. **The First Year: Inherit, Patch, Delete.** No greenfield frontend. UI work
   that is reactive rather than designed. And a repeated habit of building
   something bespoke and deleting it a few months on. Two examples carry it: the
   hand-rolled mobile navigation built 2025-09-21 and deleted 2025-12-27 in
   favour of framework defaults, and the 513-line six-step wizard replaced by a
   single sheet on 2026-05-25. The Bento profile is named as the one visual idea
   that survives every later redesign.

3. **Neumorphism, and the Argument That Killed It.** The first whole-app visual
   identity that was planned before it was built. It shipped. Six weeks later it
   was replaced, because it contradicted the audience established in section 1.
   The argument is quoted directly from `docs/design/sama2-paper/readme.md`. The
   hairline border — kept on every neumorphic surface from the start, because
   pure neumorphism fails contrast — is the tell that the problem was known
   early. **Before/after gallery sits here.**

4. **Paper, and Why the Reversal Was Cheap.** What replaced neumorphism: drawn
   edges doing the structural work, Atkinson Hyperlegible, a 48px touch floor.
   Then the mechanism that made a six-week reversal survivable — every design
   language is a skin, scoped under `data-skin` on `<body>`, with a one-line
   rollback. Include the honest scale of the migration: replacing the visual
   design was about 10% of the work, because the visual language actually lived
   in ~7,700 Tailwind colour utilities across 625 ERB files.

5. **Where It Stands.** Current-state gallery, then the unresolved: the games and
   the Bento profiles are still un-skinned, so the app genuinely has two looks;
   Chinese and Tamil are declared locales carrying five translation files each
   against English's seventy, in a typeface that has no glyphs for either; a
   44px/48px touch-target conflict is still in the tree.

## Images

Captured fresh from a local boot of `sama_sama` at HEAD, not reused from
`docs/`. Both skins are captured **at the same commit**: the current UI under
`data-skin="paper"`, then `default_skin` flipped to `"neumorph"` and the same
screens re-shot.

- Destination: `images/portfolio/sama2/`.
- Viewports: desktop 1400×1000 and mobile 390×844.
- Signed in as the seeded `rudy@sama2.com` in team "Kerajaan Maya Timur".
- Every `<img>` uses the `.smart-image` frame so a missing file degrades to the
  songket placeholder rather than a broken image.

**Known risk, to be resolved by preflight and disclosed in the post if real:**
the `--neu-*` token layer was deleted at SP-7 (`0f5c6a30`). If the surviving
`paper/skins/neumorph.css` does not render faithfully, the before/after is a
reconstruction and the post must say so in a callout rather than implying it is a
period screenshot.

The `sama_sama` working tree is clean at the time of writing and must be clean
again afterwards. The skin flip is a temporary local edit, reverted and verified.

## Voice

Drafted through the `write-like-me` skill on the Work route. First person,
casual, specific. No em-dashes. Claims are grounded: where a number is uncertain
or two sources disagree, the post says so rather than picking the better-looking
one.

## Template

Matches `work/2026-08-11-diveos.html` exactly: nav, `page-header-work` band with
breadcrumb, hero and four-cell meta strip, the `.post-*` section classes from
`si-es-es.css`, prev/next, footer. `<body data-category="work">`. Bootstrap
5.3.8 with the correct `FKyoEFor…` SRI hash, never the broken `ka7Sk0` one.

Meta strip: Project — Sama², by Nasi Forge PLT · Stack — Rails 8 + Bullet Train
1.38 + Hotwire, Tailwind 3, esbuild · Year — 2025–2026 · Links — live at
sama2.my, private repository.

## Out of scope

- The games (Shatranj, Kepung, Persis, Cheritera) beyond naming them as
  un-skinned carve-outs.
- Backend architecture, deployment, and the API.
- Rewriting or re-voicing any existing post.
- Any change to `sama_sama` beyond the temporary, reverted skin flip.

## Done means

- `work/2026-08-17-sama2-design-system.html` renders correctly at desktop and
  mobile with no console errors and no broken images.
- Listed on `work/index.html`, with the prev/next chain updated on the
  neighbouring post so it is reachable.
- Every factual claim traceable to a file, commit or capture.
- `sama_sama` working tree clean.
