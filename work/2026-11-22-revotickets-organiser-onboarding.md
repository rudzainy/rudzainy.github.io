---
layout: post
title: "RevoTickets Organiser Onboarding by Rudzainy Rahman"
date: 2026-11-22
description: "Three small production houses got stuck in the same three places while setting up RevoTickets. This is the onboarding I am designing in response."
category: work
permalink: /work/2026-11-22-revotickets-organiser-onboarding.html
data_category: work
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
    <p>The design has two parts: a start page, and a setup checklist that walks the team through the rest.</p>
    <p><strong>The start page.</strong> It asks the three questions the WhatsApp call to action on the RevoTickets site already asks: the venue, the dates, and roughly how many seats. From the answers it creates the event and its draft shows, all on one page. I made a similar change on Sama², where I replaced a six-step onboarding wizard with a single page, because six screens and a row of progress dots gave people a journey they could fail halfway through.</p>
    <p><strong>The setup checklist.</strong> After the start page, the dashboard shows the remaining steps in the order the data needs them: hall, seat categories, event page, shows, put on sale. Each step is one link, and each tick comes from the data instead of being clicked by hand. The hall step is done when the venue has a hall, seat categories when every seat has one, shows when they exist, and the last step when the event is published. Only one step is marked as next at a time, so a new team always knows what to do first and what comes after it.</p>
    <p><strong>The hall step.</strong> RevoTickets can already share halls between teams. An admin marks a venue as shared, and another team can browse a catalogue and clone its seat-map structure, without pricing, into their own account. In onboarding, that catalogue is the first thing the hall step offers. If the hall is there, the team clones it and moves on. If it isn't, the venue starts as free seating, which the app already supports, and the hall gets drawn properly before the next run. When the builder does become part of a team's first week, it needs its Malay translation first.</p>
    <p><strong>The seat categories step.</strong> Staff name each category, give it a colour and a price (the features page uses VIP, Premium and Standard as its examples), and paint seats onto it in the same view. The builder already counts what's left, from "N seats have no category" down to "Every seat has a category.", and that count becomes the step's progress bar. A cloned hall always lands on this step, because cloning leaves pricing behind, so every new team will do it. For a free-seating venue the step is shorter: a price and a capacity per category.</p>
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
