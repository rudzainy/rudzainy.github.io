---
layout: post
title: "Add Diagram on Websites using MermaidJS by Rudzainy Rahman"
date: 2024-03-23 08:37 +0800
description: "Quick guide to setup and configure MermaidJS for websites."
category: balance
permalink: /balance/2024-03-23-add-diagram-on-websites-using-mermaidjs.html
data_category: balance
tags: ["mermaidjs", "tutorial"]
---
<!-- Page Header -->
<div class="page-header-balance">
  <nav aria-label="breadcrumb" class="container pt-3">
    <ol class="breadcrumb mb-0">
      <li class="breadcrumb-item"><a href="/">Home</a></li>
      <li class="breadcrumb-item"><a href="/balance/">Balance</a></li>
      <li class="breadcrumb-item active" aria-current="page">Add Diagram on Websites using MermaidJS</li>
    </ol>
  </nav>
  <header class="container mt-3">
    <p class="mb-2" style="font-family:'Unica One',sans-serif;text-transform:uppercase;letter-spacing:0.05em;font-size:14px;color:rgba(255,255,255,0.75)"><time datetime="2024-03-23">23.03.2024</time> &middot; Tutorial</p>
    <h1 class="page-title">Add Diagram on Websites using MermaidJS</h1>
  </header>
</div>
<!-- end Page Header -->

<!-- Main Content Section -->
<main class="container my-5">
  <article class="post-content">
    <p><em>Quick guide to setup and configure MermaidJS for websites.</em></p>
    <div class="post-section-head" aria-hidden="true">
      <span class="head-tab"><i class="icon-code"></i><span>01</span></span>
    </div>
    <h2>This code&hellip;</h2>
    <p>Write your Mermaid diagram source inside a fenced block. The code below is the raw init config and sequence diagram that drives the example:</p>
    <div class="post-code">
      <div class="code-block">
        <div class="code-header">
          <span class="code-file">sequence.md</span>
          <span class="code-lang">Mermaid</span>
        </div>
        <pre><code>%%{
    init: {
        'theme': 'base',
        'wrap': true,
        'fontSize': 10,
        'themeVariables': {
            'darkMode': false,
            'primaryColor': '#6CA142',
            'primaryTextColor': '#E8F0E0',
            'primaryBorderColor': '#245228',
            'lineColor': '#F8B229',
            'secondaryColor': '#006100',
            'tertiaryColor': '#fff',
            'signalColor': '#E8F0E0'
        }
    }
}%%

sequenceDiagram
    Donor-&gt;&gt;Project Coordinator: 1. Donor makes inquiry regarding the Masjid project.
    Project Coordinator-&gt;&gt;Donor: 2. Provides information regarding options available for Masjids to donor.
    Donor-&gt;&gt;Project Coordinator: 3. Donor learns and decide country and size of the Masjid they would prefer.
    Project Coordinator-&gt;&gt;Donor: 4. When the donor decides, a written agreement is made &amp; payment is finalized.
    Donor-&gt;&gt;Project Coordinator: 5. Donor signs the agreement and pays in full or as 3 phases.
    Project Coordinator-&gt;&gt;Partner Side: 6. Then Geo Location is requested.
    Partner Side-&gt;&gt;Project Coordinator: 7. Location is provided.
    Project Coordinator-&gt;&gt;Donor: 8. Banners &amp; posters are made &amp; shared with donors.
    Donor-&gt;&gt;Project Coordinator: 9. Banners &amp; posters are approved.
    Project Coordinator-&gt;&gt;Partner Side: 10. Masjid is given for construction along with approved banners.
    Partner Side-&gt;&gt;Project Coordinator: 11. Construction updates are shared.
    Project Coordinator-&gt;&gt;Donor: 12. Updates &amp; completion photos are shared to donors.
    Donor-&gt;&gt;Project Coordinator: 13. The Masjid Project is completed &amp; final media is received.
    Partner Side-&gt;&gt;Project Coordinator: 14. Payment is requested for the Masjid.
    Project Coordinator-&gt;&gt;Finance Dept.: 15. Payment request is crosschecked with data.
    Finance Dept.-&gt;&gt;Partner Side: 16. Payment is processed and sent to partner.</code></pre>
      </div>
    </div>
    <div class="post-section-head" aria-hidden="true">
      <span class="head-tab"><i class="icon-workflow"></i><span>02</span></span>
    </div>
    <h2>&hellip;will generate this chart.</h2>
    <p>When MermaidJS is loaded on the page, the block below renders as a live interactive diagram. The fenced <code>mermaid</code> class triggers automatic rendering by the Mermaid script.</p>
    <div class="post-code">
      <div class="code-block">
        <div class="code-header">
          <span class="code-file">index.html &mdash; rendered mermaid block</span>
          <span class="code-lang">HTML</span>
        </div>
        <pre><code>&lt;pre class="mermaid"&gt;
%%{
    init: {
        'theme': 'base',
        'wrap': true,
        'fontSize': 10,
        'darkMode': false,
        'themeVariables': {
            'primaryColor': '#6CA142',
            'primaryTextColor': '#E8F0E0',
            'primaryBorderColor': '#245228',
            'lineColor': '#F8B229',
            'secondaryColor': '#006100',
            'tertiaryColor': '#fff',
            'signalColor': '#E8F0E0'
        }
    }
}%%

sequenceDiagram
    Donor-&gt;&gt;Project Coordinator: 1. Donor makes inquiry regarding the Masjid project.
    Project Coordinator-&gt;&gt;Donor: 2. Provides information regarding options available for Masjids to donor.
    Donor-&gt;&gt;Project Coordinator: 3. Donor learns and decide country and size of the Masjid they would prefer.
    Project Coordinator-&gt;&gt;Donor: 4. When the donor decides, a written agreement is made &amp; payment is finalized.
    Donor-&gt;&gt;Project Coordinator: 5. Donor signs the agreement and pays in full or as 3 phases.
    Project Coordinator-&gt;&gt;Partner Side: 6. Then Geo Location is requested.
    Partner Side-&gt;&gt;Project Coordinator: 7. Location is provided.
    Project Coordinator-&gt;&gt;Donor: 8. Banners &amp; posters are made &amp; shared with donors.
    Donor-&gt;&gt;Project Coordinator: 9. Banners &amp; posters are approved.
    Project Coordinator-&gt;&gt;Partner Side: 10. Masjid is given for construction along with approved banners.
    Partner Side-&gt;&gt;Project Coordinator: 11. Construction updates are shared.
    Project Coordinator-&gt;&gt;Donor: 12. Updates &amp; completion photos are shared to donors.
    Donor-&gt;&gt;Project Coordinator: 13. The Masjid Project is completed &amp; final media is received.
    Partner Side-&gt;&gt;Project Coordinator: 14. Payment is requested for the Masjid.
    Project Coordinator-&gt;&gt;Finance Dept.: 15. Payment request is crosschecked with data.
    Finance Dept.-&gt;&gt;Partner Side: 16. Payment is processed and sent to partner.
&lt;/pre&gt;</code></pre>
      </div>
    </div>
    <p>To wire up MermaidJS, add the CDN script to your page&rsquo;s <code>&lt;head&gt;</code> or just before <code>&lt;/body&gt;</code>:</p>
    <div class="post-code">
      <div class="code-block">
        <div class="code-header">
          <span class="code-file">index.html</span>
          <span class="code-lang">HTML</span>
        </div>
        <pre><code>&lt;script type="module"&gt;
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true });
&lt;/script&gt;</code></pre>
      </div>
    </div>
  </article>
</main>
<!-- end Main Content Section -->
