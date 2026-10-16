---
layout: post
title: "Restarting Postgres for Rails on MacOS by Rudzainy Rahman"
date: 2023-12-25 08:46 +0800
description: "Restarting Postgres for Rails on MacOS"
category: balance
permalink: /balance/2023-12-25-restarting-postgres-for-rails-on-macos.html
tags: ["rails", "postgres", "error"]
image: /images/posts/Screenshot_2023-12-25_at_9-34-08_AM.png
---
<!-- Page Header -->
<div class="page-header-balance">
	<nav aria-label="breadcrumb" class="container pt-3">
		<ol class="breadcrumb mb-0">
			<li class="breadcrumb-item"><a href="/">Home</a></li>
			<li class="breadcrumb-item"><a href="/balance/">Balance</a></li>
			<li class="breadcrumb-item active" aria-current="page">Restarting Postgres for Rails on MacOS</li>
		</ol>
	</nav>
	<header class="container mt-4">
		<section class="d-flex flex-wrap flex-row align-items-center gap-3 gap-lg-5">
		<h1 class="page-title">Restarting Postgres for Rails on MacOS</h1>
		</section>
	</header>
</div>
<!-- end Page Header -->

<!-- Main Content Section -->
<main class="container my-5">
	<article class="post-content">
<p>Last night I encountered this error message while building <a href="/balance/2023-12-23-ranting.html">Ranting</a>:</p>
<p><code>bash
ActiveRecord::ConnectionNotEstablished (connection to server on socket "/tmp/.s.PGSQL.5432" failed: No such file or directory
        Is the server running locally and accepting connections on that socket?
):
</code></p>
<p>I vaguely remember encountering this error message a while back 🤔. I’m not certain what actually caused the error, however I figured restatrting Postgress would solve this. Here’s how to do it.</p>
<div class="post-section-head" aria-hidden="true">
  <span class="head-tab"><i class="icon-search"></i><span>01</span></span>
</div>
<h2 id="look-for-postgres-installation">Look for Postgres Installation</h2>
<p>My current setup has Postgres installed with Homebrew.</p>
<p><code>bash
  $ brew list
  ==&gt; Formulae
  ...
  cairo         liblqr          poppler
  coreutils     libnghttp2      postgresql@14
  docbook       libomp          protobuf
  ...
</code></p>
<p>Seems that I have <code>postgresql@14</code> installed.</p>
<div class="post-section-head" aria-hidden="true">
  <span class="head-tab"><i class="icon-refresh-cw"></i><span>02</span></span>
</div>
<h2 id="restart-postgres">Restart Postgres</h2>
<p>Now, navigate to this folder:</p>
<p><code>bash
  $ cd /usr/local/var
</code></p>
<p>Look for the same Postgres installation folder as in Homebrew list above.</p>
<p><code>bash
  $ ls
  cache		homebrew	mysql		run
  db		log		postgresql@14
</code></p>
<p><code>cd</code> into the Postgres folder and look for a file called <code>postmaster.pid</code>.</p>
<p><code>bash
  $ cd postgresql@14
</code></p>
<p>```bash
  $ ls
  PG_VERSION		pg_ident.conf		pg_snapshots		pg_wal
  base			pg_logical		pg_stat			pg_xact
  global                pg_multixact            pg_stat_tmp             postgresql.auto.conf
  pg_commit_ts		pg_notify		pg_subtrans		postgresql.conf
  pg_dynshmem		pg_replslot		pg_tblspc		postmaster.opts
  pg_hba.conf		pg_serial		pg_twophase		postmaster.pid</p>
<p>```</p>
<p>Found it! Next, backup the <code>postmaster.pid</code> file to another folder (eg. the Desktop folder) and restart Postgres.</p>
<p><code>bash
  $ mv postmaster.pid ~/Desktop
</code></p>
<p><code>bash
  $ brew services restart postgresql@14
  Stopping `postgresql@14`... (might take a while)
  ==&gt; Successfully stopped `postgresql@14` (label: homebrew.mxcl.postgresql@14)
  ==&gt; Successfully started `postgresql@14` (label: homebrew.mxcl.postgresql@14)
</code></p>
<div class="post-section-head" aria-hidden="true">
  <span class="head-tab"><i class="icon-circle-check"></i><span>03</span></span>
</div>
<h2 id="move-on-with-life">Move On with Life</h2>
<p>Run Rails server again and that should resolve the error.</p>
<p>It should be safe now to delete the <code>postmaster.pid</code> that was backed up earlier.</p>
	</article>
</main>
<!-- end Main Content Section -->
