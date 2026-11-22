---
layout: post
title: "RevoTickets Organiser Onboarding by Rudzainy Rahman"
date: 2026-11-22
description: "Three small production houses got stuck in the same three places while setting up RevoTickets. This is the onboarding I am designing in response."
category: work
permalink: /work/2026-11-22-revotickets-organiser-onboarding.html
data_category: work
head_extra: |2
  <style>
    /* Mockup frames. The screens are live HTML with sample data, in a UI sans
       so the product's type stays apart from the portfolio's serif. */
    .mock { font-family: -apple-system, BlinkMacSystemFont, 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 13px; line-height: 1.5; color: var(--color-ink); }
    .mock-window { background: var(--color-surface); border: 1px solid rgba(0,0,0,0.175); border-radius: var(--radius-md); overflow: hidden; box-shadow: var(--shadow-hover); }
    .mock-chrome { display: flex; align-items: center; gap: 8px; padding: 8px 14px; background: #EAE6DD; border-bottom: 1px solid rgba(0,0,0,0.1); }
    .mock-dot { width: 9px; height: 9px; border-radius: 50%; background: #CBC6BC; }
    .mock-url { margin-left: 10px; font-family: ui-monospace, SFMono-Regular, Menlo, monospace; font-size: 11px; color: var(--color-muted); }
    .mock-title { font-size: 20px; font-weight: 700; line-height: 1.25; }
    .mock-sub { margin: 2px 0 0; color: var(--color-muted); }
    .mock-label { margin-bottom: 6px; font-size: 11px; letter-spacing: 0.08em; text-transform: uppercase; color: var(--color-muted); }
    .mock-input { display: flex; align-items: center; gap: 8px; padding: 9px 12px; background: var(--color-surface); border: 1px solid rgba(0,0,0,0.2); border-radius: var(--radius-sm); }
    .mock-input i { color: var(--color-muted); }
    .mock-chip { display: inline-flex; align-items: center; gap: 6px; padding: 5px 12px; border: 1px solid var(--cat-border); border-radius: 999px; background: var(--cat-subtle); color: var(--cat-ink); }
    .mock-chip.is-add { background: transparent; border-style: dashed; border-color: rgba(0,0,0,0.25); color: var(--color-muted); }
    .mock-btn { display: inline-flex; align-items: center; gap: 6px; padding: 8px 14px; border-radius: var(--radius-sm); background: var(--color-work); color: #fff; font-weight: 600; white-space: nowrap; }
    .mock-btn.is-ghost { background: transparent; color: var(--color-ink); border: 1px solid rgba(0,0,0,0.2); font-weight: 500; }
    .mock-footer { display: flex; align-items: center; justify-content: space-between; gap: 16px; flex-wrap: wrap; margin-top: 26px; padding-top: 18px; border-top: 1px solid rgba(0,0,0,0.1); }
    .mock-card { background: var(--color-surface); border: 1px solid rgba(0,0,0,0.14); border-radius: var(--radius-sm); overflow: hidden; }
    .mock-card-head { display: flex; justify-content: space-between; padding: 9px 16px; background: var(--color-neutral); border-bottom: 1px solid rgba(0,0,0,0.08); font-size: 11px; letter-spacing: 0.08em; text-transform: uppercase; color: var(--color-muted); }
    .mock-card-foot { display: flex; align-items: center; gap: 8px; padding: 11px 16px; border-top: 1px solid rgba(0,0,0,0.08); color: var(--color-life-ink); font-weight: 600; }
    .mock-step { display: flex; align-items: center; gap: 14px; padding: 12px 16px; border-top: 1px solid rgba(0,0,0,0.07); color: var(--color-muted); }
    .mock-card-head + .mock-step { border-top: 0; }
    .mock-tick { flex: 0 0 26px; height: 26px; display: inline-flex; align-items: center; justify-content: center; border-radius: 50%; border: 1.5px solid rgba(0,0,0,0.2); font-size: 12px; font-weight: 600; }
    .mock-step-name { font-weight: 600; color: var(--color-ink); display: flex; align-items: center; gap: 8px; }
    .mock-step-meta { font-size: 12px; }
    .mock-step.is-done .mock-tick { background: var(--color-life); border-color: var(--color-life); color: #fff; }
    .mock-step.is-done .mock-step-name { color: var(--color-muted); }
    .mock-step.is-next { background: var(--cat-subtle); box-shadow: inset 3px 0 0 var(--color-work); }
    .mock-step.is-next .mock-tick { background: var(--color-work); border-color: var(--color-work); color: #fff; }
    .mock-tag { padding: 1px 7px; border-radius: 4px; background: var(--color-work); color: #fff; font-size: 10px; letter-spacing: 0.06em; text-transform: uppercase; }
    .mock-bar { height: 8px; background: #EAE6DD; border-radius: 999px; overflow: hidden; }
    .mock-bar span { display: block; height: 100%; background: var(--color-life); border-radius: 999px; }
    .mock-stat { padding: 10px 12px; background: var(--color-surface); border: 1px solid rgba(0,0,0,0.12); border-radius: var(--radius-sm); }
    .mock-stat span { display: block; font-size: 11px; color: var(--color-muted); }
    .mock-stat b { font-size: 18px; }
    .mock-help { display: flex; gap: 10px; align-items: flex-start; padding: 11px 14px; background: var(--cat-subtle); border: 1px solid var(--cat-border); border-radius: var(--radius-sm); color: var(--cat-ink); }
    .mock-help i { margin-top: 2px; }
    .mock-cat { display: flex; align-items: center; gap: 8px; padding: 6px 10px; border: 1px solid rgba(0,0,0,0.12); border-radius: 999px; }
    .mock-cat em { margin-left: auto; font-style: normal; font-size: 12px; color: var(--color-muted); }
    .mock-cat.is-active { border-color: var(--color-ink); box-shadow: 0 0 0 1px var(--color-ink); font-weight: 600; }
    .mock-cat .swatch { width: 12px; height: 12px; border-radius: 3px; }
    .mock-cat.is-none .swatch { border: 1.5px dashed #9A93A3; }
    .mock-seg { display: inline-flex; border: 1px solid rgba(0,0,0,0.2); border-radius: var(--radius-sm); overflow: hidden; }
    .mock-seg span { padding: 5px 14px; }
    .mock-seg .is-on { background: var(--color-ink); color: #fff; }
    .mock-stage { margin: 0 auto 18px; max-width: 70%; padding: 5px; text-align: center; background: #EAE6DD; border-radius: 0 0 40px 40px; font-size: 11px; letter-spacing: 0.12em; text-transform: uppercase; color: var(--color-muted); }
    .seat-map { display: flex; flex-direction: column; gap: 6px; align-items: center; }
    .seat-row { display: flex; align-items: center; gap: 5px; }
    .seat-row b { width: 14px; font-size: 10px; font-weight: 400; text-align: center; color: var(--color-muted); }
    .seat { width: 16px; height: 15px; border-radius: 4px 4px 6px 6px; }
    .seat.is-vip { background: #C56A12; }
    .seat.is-premium { background: #2A4BA0; }
    .seat.is-standard { background: #1E7A54; }
    .seat.is-none { background: var(--color-surface); border: 1.5px dashed #9A93A3; }
    .aisle { width: 14px; }
  </style>
---
<!-- Page Header Band (solid category colour) -->
<div class="page-header-work" style="padding-bottom:0">
  <div style="max-width:1140px;margin:0 auto;padding:20px 24px 0">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb mb-0" style="font-family:var(--font-display);text-transform:uppercase;letter-spacing:var(--tracking-display);font-size:14px">
        <li class="breadcrumb-item"><a href="/">Home</a></li>
        <li class="breadcrumb-item"><a href="/work/">Work</a></li>
        <li class="breadcrumb-item active" aria-current="page">RevoTickets Organiser Onboarding</li>
      </ol>
    </nav>
    <!-- end Breadcrumb -->
    <!-- Hero: kicker + title + standfirst -->
    <div style="padding:36px 0 44px">
      <p style="margin:0 0 8px;font-family:var(--font-display);text-transform:uppercase;letter-spacing:var(--tracking-display);font-size:14px;color:rgba(255,255,255,0.75)">UX case study · RevoTickets · 2026</p>
      <h1 class="page-title" style="display:block;font-size:clamp(2.5rem,1.1rem + 4.5vw,4.5rem);line-height:1.05;text-wrap:balance">Designing onboarding for production houses</h1>
      <p style="margin:16px 0 0;font-size:var(--type-lead);color:rgba(255,255,255,0.92);max-width:54ch">Three small production houses got stuck in the same three places while setting up RevoTickets. This is the onboarding I am designing in response.</p>
    </div>
    <!-- Featured meta strip (overlaps the band) -->
    <div class="header-meta-strip" style="background:var(--color-surface);border:1px solid rgba(0,0,0,0.175);border-radius:var(--radius-md);box-shadow:var(--shadow-active);display:grid;grid-template-columns:repeat(4,1fr);position:relative;transform:translateY(56px);margin-top:-56px">
      <div style="padding:16px 20px">
        <div style="font-family:var(--font-display);text-transform:uppercase;letter-spacing:var(--tracking-display);font-size:12px;color:var(--cat-ink);margin-bottom:6px">Responsibilities</div>
        <p style="margin:0">Product, UX</p>
      </div>
      <div style="padding:16px 20px;border-left:1px solid rgba(0,0,0,0.1)">
        <div style="font-family:var(--font-display);text-transform:uppercase;letter-spacing:var(--tracking-display);font-size:12px;color:var(--cat-ink);margin-bottom:6px">Product</div>
        <p style="margin:0">RevoTickets, for Revolution Stage</p>
      </div>
      <div style="padding:16px 20px;border-left:1px solid rgba(0,0,0,0.1)">
        <div style="font-family:var(--font-display);text-transform:uppercase;letter-spacing:var(--tracking-display);font-size:12px;color:var(--cat-ink);margin-bottom:6px">Year</div>
        <p style="margin:0"><time datetime="2026">2026</time></p>
      </div>
      <div style="padding:16px 20px;border-left:1px solid rgba(0,0,0,0.1)">
        <div style="font-family:var(--font-display);text-transform:uppercase;letter-spacing:var(--tracking-display);font-size:12px;color:var(--cat-ink);margin-bottom:6px">Status</div>
        <div style="display:flex;flex-direction:column;gap:8px;align-items:flex-start">
          <span class="meta-link text-muted"><i class="icon-compass" aria-hidden="true"></i>Design proposal, not built yet</span>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- end Page Header Band -->

<main style="max-width:1140px;margin:0 auto;padding:104px 24px 32px">
  <article style="max-width:var(--measure);margin:0 auto">
    <div class="post-section-head is-first" aria-hidden="true">
      <span class="head-tab"><i class="icon-circle-help"></i><span>01 &middot; where they got stuck</span></span>
    </div>
    <h2>Where they got stuck</h2>
    <p class="lead">Three small indie production houses besides Revolution Stage have signed up to RevoTickets. Each of them signed up through a link I sent, explored on their own, and messaged me when they got stuck. They got stuck in the same three places: the hall builder, setting up seat categories, and not knowing what to do first, or what comes after that.</p>
    <p>A team that signs up lands in the default onboarding of Bullet Train, the Rails framework RevoTickets is built on, and then an empty dashboard with four counts, a table of recent bookings and a New event button. Behind that button is a chain of work: a venue, a hall drawn level by level and section by section, seat categories with prices, an event page, and shows that each pick a hall and a configuration before their seats are generated. The dashboard never says which of those comes next.</p>
    <p>The hall builder is the most demanding screen in the app. It also has English strings only, while the storefront, the organiser dashboard and check-in are all in English and Malay. Seat categories are set up in two places. You create them on the venue, then go into the hall builder, pick a category chip, switch to Paint and click seats to assign them, so the second half of the job happens inside the hall builder.</p>
  </article>
  <article style="max-width:var(--measure);margin:0 auto">
    <div class="post-section-head" aria-hidden="true">
      <span class="head-tab"><i class="icon-list-checks"></i><span>02 &middot; the design</span></span>
    </div>
    <h2>The design</h2>
    <p>The design has two parts: a start page, and a setup checklist that walks the team through the rest. The screens below are HTML mockups with sample data. Dewan Contoh is a made-up venue, and the prices are placeholders.</p>
    <p><strong>The start page.</strong> It asks the three questions the WhatsApp call to action on the RevoTickets site already asks: the venue, the dates, and roughly how many seats. From the answers it creates the event and its draft shows, all on one page. I made a similar change on Sama², where I replaced a six-step onboarding wizard with a single page, because six screens and a row of progress dots gave people a journey they could fail halfway through.</p>
  </article>
  <!-- Mockup: start page -->
  <div class="post-figure" style="margin-top:8px">
    <figure style="max-width:48rem">
      <div class="mock-window">
        <div class="mock-chrome">
          <span class="mock-dot"></span><span class="mock-dot"></span><span class="mock-dot"></span>
          <span class="mock-url">revotickets · start page</span>
        </div>
        <div class="mock" style="padding:28px 32px 24px">
          <div class="mock-title">Set up your first event</div>
          <p class="mock-sub">You can change all of this later.</p>
          <div style="display:flex;flex-direction:column;gap:18px;margin-top:22px">
            <div>
              <div class="mock-label">Venue</div>
              <div class="mock-input"><i class="icon-map-pin" aria-hidden="true"></i>Dewan Contoh</div>
            </div>
            <div>
              <div class="mock-label">Dates</div>
              <div style="display:flex;flex-wrap:wrap;gap:8px">
                <span class="mock-chip"><i class="icon-calendar" aria-hidden="true"></i>Fri 12 Mar 2027 · 8:30pm</span>
                <span class="mock-chip"><i class="icon-calendar" aria-hidden="true"></i>Sat 13 Mar 2027 · 3:00pm</span>
                <span class="mock-chip"><i class="icon-calendar" aria-hidden="true"></i>Sat 13 Mar 2027 · 8:30pm</span>
                <span class="mock-chip is-add"><i class="icon-plus" aria-hidden="true"></i>Add a date</span>
              </div>
            </div>
            <div>
              <div class="mock-label">Roughly how many seats</div>
              <div class="mock-input" style="max-width:140px">110</div>
            </div>
          </div>
          <div class="mock-footer">
            <span style="color:var(--color-muted)">This creates 1 event and 3 draft shows.</span>
            <span class="mock-btn">Create event<i class="icon-arrow-right" aria-hidden="true"></i></span>
          </div>
        </div>
      </div>
      <figcaption>The start page. The three fields match the questions on the RevoTickets site.</figcaption>
    </figure>
  </div>
  <article style="max-width:var(--measure);margin:0 auto">
    <p><strong>The setup checklist.</strong> After the start page, the dashboard shows the remaining steps in the order the data needs them: hall, seat categories, event page, shows, put on sale. Each step is one link, and each tick comes from the data instead of being clicked by hand. The hall step is done when the venue has a hall, seat categories when every seat has one, shows when they exist, and the last step when the event is published. Only one step is marked as next at a time, so a new team always knows what to do first and what comes after it.</p>
  </article>
  <!-- Mockup: dashboard with setup checklist -->
  <div class="post-figure" style="margin-top:8px">
    <figure style="max-width:60rem">
      <div class="mock-window">
        <div class="mock-chrome">
          <span class="mock-dot"></span><span class="mock-dot"></span><span class="mock-dot"></span>
          <span class="mock-url">revotickets · dashboard</span>
        </div>
        <div style="overflow-x:auto">
          <div class="mock" style="min-width:640px;padding:22px 26px 24px">
            <div style="display:flex;align-items:flex-end;justify-content:space-between;gap:16px">
              <div>
                <div class="mock-title">Dashboard</div>
                <p class="mock-sub">Your team at a glance</p>
              </div>
              <span class="mock-btn is-ghost"><i class="icon-plus" aria-hidden="true"></i>New event</span>
            </div>
            <div class="mock-card" style="margin-top:18px">
              <div class="mock-card-head">
                <span>Setup checklist</span>
                <span style="color:var(--color-muted);text-transform:none;letter-spacing:0">2 of 5 done</span>
              </div>
              <div class="mock-step is-done">
                <span class="mock-tick"><i class="icon-check" aria-hidden="true"></i></span>
                <div><div class="mock-step-name">Hall</div><div class="mock-step-meta">Dewan Contoh, cloned from Shared Venues</div></div>
              </div>
              <div class="mock-step is-next">
                <span class="mock-tick">2</span>
                <div style="flex:1">
                  <div class="mock-step-name">Seat categories <span class="mock-tag">Next</span></div>
                  <div class="mock-step-meta">22 seats have no category</div>
                  <div class="mock-bar" style="margin-top:8px;max-width:320px"><span style="width:80%"></span></div>
                </div>
                <span class="mock-btn">Continue<i class="icon-arrow-right" aria-hidden="true"></i></span>
              </div>
              <div class="mock-step">
                <span class="mock-tick">3</span>
                <div><div class="mock-step-name">Event page</div><div class="mock-step-meta">Not started</div></div>
              </div>
              <div class="mock-step is-done">
                <span class="mock-tick"><i class="icon-check" aria-hidden="true"></i></span>
                <div><div class="mock-step-name">Shows</div><div class="mock-step-meta">3 draft shows from the start page</div></div>
              </div>
              <div class="mock-step">
                <span class="mock-tick">5</span>
                <div><div class="mock-step-name">Put on sale</div><div class="mock-step-meta">Publish the event when the steps above are done</div></div>
              </div>
              <div class="mock-card-foot"><i class="icon-message-circle" aria-hidden="true"></i>Stuck? Message us on WhatsApp</div>
            </div>
            <div style="display:grid;grid-template-columns:repeat(4,1fr);gap:10px;margin-top:14px;opacity:0.6">
              <div class="mock-stat"><span>Events</span><b>1</b></div>
              <div class="mock-stat"><span>Upcoming shows</span><b>3</b></div>
              <div class="mock-stat"><span>Bookings</span><b>0</b></div>
              <div class="mock-stat"><span>Venues</span><b>1</b></div>
            </div>
          </div>
        </div>
      </div>
      <figcaption>The dashboard with the setup checklist. The four counts from today's dashboard sit underneath it.</figcaption>
    </figure>
  </div>
  <article style="max-width:var(--measure);margin:0 auto">
    <p><strong>The hall step.</strong> RevoTickets can already share halls between teams. An admin marks a venue as shared, and another team can browse a catalogue and clone its seat-map structure, without pricing, into their own account. In onboarding, that catalogue is the first thing the hall step offers. If the hall is there, the team clones it and moves on. If it isn't, the venue starts as free seating, which the app already supports, and the hall gets drawn properly before the next run. When the builder does become part of a team's first week, it needs its Malay translation first.</p>
  </article>
  <!-- Mockup: hall step -->
  <div class="post-figure" style="margin-top:8px">
    <figure style="max-width:60rem">
      <div class="mock-window">
        <div class="mock-chrome">
          <span class="mock-dot"></span><span class="mock-dot"></span><span class="mock-dot"></span>
          <span class="mock-url">revotickets · setup · hall</span>
        </div>
        <div style="overflow-x:auto">
          <div class="mock" style="min-width:640px;padding:22px 26px 24px">
            <div class="mock-label">Step 1 of 5</div>
            <div class="mock-title">Hall</div>
            <div class="mock-help" style="margin-top:12px">
              <i class="icon-info" aria-hidden="true"></i>
              <div>The hall is the seat map buyers pick their seats from. This step is done when Dewan Contoh has a hall.</div>
            </div>
            <div style="display:grid;grid-template-columns:3fr 2fr;gap:14px;margin-top:16px">
              <div class="mock-card">
                <div class="mock-card-head"><span>Shared Venues</span></div>
                <div style="padding:14px 16px">
                  <p class="mock-sub" style="margin:0 0 12px">Browse seat maps other teams have shared, and clone one into your team.</p>
                  <div style="border:1px solid rgba(0,0,0,0.12);border-radius:var(--radius-sm);padding:12px 14px">
                    <div style="font-weight:600">Dewan Contoh</div>
                    <div style="color:var(--color-muted);font-size:12px">by Contoh Productions</div>
                    <div style="display:flex;gap:14px;margin-top:8px;font-size:12px;color:var(--color-muted)">
                      <span><i class="icon-house" aria-hidden="true"></i> 2 halls</span>
                      <span><i class="icon-layers" aria-hidden="true"></i> 3 levels</span>
                      <span><i class="icon-ticket" aria-hidden="true"></i> 112 seats</span>
                    </div>
                    <div style="margin-top:12px"><span class="mock-btn">Clone to my team</span></div>
                  </div>
                </div>
              </div>
              <div class="mock-card">
                <div class="mock-card-head"><span>Not in the list?</span></div>
                <div style="padding:14px 16px">
                  <div style="font-weight:600">Free seating</div>
                  <p class="mock-sub" style="margin:2px 0 12px">Sold by capacity — no seat picking.</p>
                  <span class="mock-btn is-ghost">Use free seating</span>
                </div>
              </div>
            </div>
            <div class="mock-card-foot" style="border:0;padding:14px 0 0"><i class="icon-message-circle" aria-hidden="true"></i>Stuck? Message us on WhatsApp</div>
          </div>
        </div>
      </div>
      <figcaption>The hall step. The catalogue card and the free seating line use the app's current wording.</figcaption>
    </figure>
  </div>
  <article style="max-width:var(--measure);margin:0 auto">
    <p><strong>The seat categories step.</strong> Staff name each category, give it a colour and a price (the features page uses VIP, Premium and Standard as its examples), and paint seats onto it in the same view. The builder already counts what's left, from "N seats have no category" down to "Every seat has a category.", and that count becomes the step's progress bar. A cloned hall always lands on this step, because cloning leaves pricing behind, so every new team will do it. For a free-seating venue the step is shorter: a price and a capacity per category.</p>
  </article>
  <!-- Mockup: seat categories step -->
  <div class="post-figure" style="margin-top:8px">
    <figure style="max-width:60rem">
      <div class="mock-window">
        <div class="mock-chrome">
          <span class="mock-dot"></span><span class="mock-dot"></span><span class="mock-dot"></span>
          <span class="mock-url">revotickets · setup · seat categories</span>
        </div>
        <div style="overflow-x:auto">
          <div class="mock" style="min-width:700px;padding:22px 26px 24px">
            <div class="mock-label">Step 2 of 5</div>
            <div class="mock-title">Seat categories</div>
            <div class="mock-help" style="margin-top:12px">
              <i class="icon-info" aria-hidden="true"></i>
              <div>Each category has a colour and a price, and buyers see it on the seat map. This step is done when every seat has a category.</div>
            </div>
            <div style="display:grid;grid-template-columns:230px 1fr;gap:16px;margin-top:16px">
              <div class="mock-card" style="padding:14px 16px">
                <div class="mock-label">Seat categories</div>
                <div style="display:flex;flex-direction:column;gap:8px">
                  <span class="mock-cat is-active"><span class="swatch" style="background:#C56A12"></span>VIP<em>RM 120</em></span>
                  <span class="mock-cat"><span class="swatch" style="background:#2A4BA0"></span>Premium<em>RM 80</em></span>
                  <span class="mock-cat"><span class="swatch" style="background:#1E7A54"></span>Standard<em>RM 50</em></span>
                  <span class="mock-cat is-none"><span class="swatch"></span>Uncategorised<em>22</em></span>
                  <span class="mock-chip is-add" style="align-self:flex-start"><i class="icon-plus" aria-hidden="true"></i>Add category</span>
                </div>
                <div class="mock-label" style="margin-top:16px">Tool</div>
                <div class="mock-seg"><span>Select</span><span class="is-on">Paint</span></div>
                <p class="mock-sub" style="margin:10px 0 0;font-size:12px">Pick a chip, switch to Paint, then click seats to recategorise them.</p>
              </div>
              <div class="mock-card" style="padding:16px;display:flex;flex-direction:column;justify-content:center">
                <div class="mock-stage">Stage</div>
                <div class="seat-map">
                    <div class="seat-row"><b>A</b><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="aisle"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><b>A</b></div>
                    <div class="seat-row"><b>B</b><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="aisle"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><span class="seat is-vip"></span><b>B</b></div>
                    <div class="seat-row"><b>C</b><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="aisle"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><b>C</b></div>
                    <div class="seat-row"><b>D</b><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="aisle"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><b>D</b></div>
                    <div class="seat-row"><b>E</b><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="aisle"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><span class="seat is-premium"></span><b>E</b></div>
                    <div class="seat-row"><b>F</b><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="aisle"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><b>F</b></div>
                    <div class="seat-row"><b>G</b><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-standard"></span><span class="seat is-none"></span><span class="aisle"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><b>G</b></div>
                    <div class="seat-row"><b>H</b><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="aisle"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><span class="seat is-none"></span><b>H</b></div>
                </div>
                <div style="margin-top:16px">
                  <div style="display:flex;justify-content:space-between;font-size:12px;margin-bottom:6px"><span><strong>22 seats have no category</strong></span><span style="color:var(--color-muted)">90 of 112</span></div>
                  <div class="mock-bar"><span style="width:80%"></span></div>
                </div>
              </div>
            </div>
            <div class="mock-card-foot" style="border:0;padding:14px 0 0"><i class="icon-message-circle" aria-hidden="true"></i>Stuck? Message us on WhatsApp</div>
          </div>
        </div>
      </div>
      <figcaption>The seat categories step. The hint and the count are strings the hall builder already shows.</figcaption>
    </figure>
  </div>
  <article style="max-width:var(--measure);margin:0 auto">
    <p><strong>Help on each step.</strong> An in-app help centre is still on my to-do list, so today there is no in-product help for staff at all. The hall and seat category steps each get a short explanation of what the step is for and what "done" looks like. Each step also has a "stuck? message us on WhatsApp" link, so when someone asks for help I can see which step they were on.</p>
    <p>Everything the design uses already exists in the app: the shared catalogue, free seating, the seat-category counts, the publish toggle and the WhatsApp link. The new work is the start page, the checklist, and putting the seat-category painting into its own step.</p>
  </article>
  <article style="max-width:var(--measure);margin:0 auto">
    <div class="post-section-head" aria-hidden="true">
      <span class="head-tab"><i class="icon-arrow-right"></i><span>03 &middot; what comes next</span></span>
    </div>
    <h2>What comes next</h2>
    <p>Two smaller fixes come with the design. When a new team invites people, the invite screen should describe roles as jobs the team already has. Admins handle money (bookings, coupons, marking a booking paid), editors manage events and shows, and everyone else can read. Described that way, they become the producer, the person running the event pages, and the door crew.</p>
    <p>The second fix is copy on the public features page. It describes the settlement summary as "Gross, fees and net, with the payout schedule laid out", but the settlement tab in the app says fees, net payout and settled refunds aren't tracked yet. A production house moving off a spreadsheet will ask about money early, so that page should describe what the settlement tab actually shows today.</p>
    <p>None of this is built yet. Until it is, new teams keep exploring on their own and messaging me, and each stuck message is worth noting against the step it came from, so the next version of this design starts from a list instead of my memory.</p>
  </article>
  <article style="max-width:var(--measure);margin:0 auto">
    <!-- Prev / Next -->
    {%- assign live_urls = site.pages | map: "url" %}
    <div class="post-nav">
      <nav aria-label="More work">
        <a href="/work/" class="nav-card is-prev">
          <span class="nav-dir"><i class="icon-arrow-left" aria-hidden="true"></i>Back</span>
          <span class="nav-title">All Work</span>
          <span class="nav-date">The full portfolio</span>
        </a>
        {%- if live_urls contains "/work/2026-08-12-rombak-lyn-forum.html" %}
        <a href="/work/2026-08-12-rombak-lyn-forum.html" class="nav-card is-next">
          <span class="nav-dir">Next<i class="icon-arrow-right" aria-hidden="true"></i></span>
          <span class="nav-title">Rombak LYN Forum</span>
          <span class="nav-date"><time datetime="2026-08-12">12.08.2026</time></span>
        </a>
        {%- else %}
        <span></span>
        {%- endif %}
      </nav>
    </div>
  </article>
  <p class="text-center" style="max-width:var(--measure);margin:var(--space-5) auto 0"><a class="text-dark" href="https://sama2.nasiforge.com/si/rudzainy" aria-label="Sama²" target="_blank" title="View my Sama² profile, and create your own! 🤙"><i class="icon-heart me-2"></i><span class="visually-hidden">Sama²</span></a></p>
</main>
