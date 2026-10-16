---
layout: post
title: Tutorial Ruby on Rails
date: 2024-02-25 18:51 +0800
description: A quick reference for spinning up a new Ruby on Rails project from scratch.
image:
category: Work
tags: [ruby, rails, tutorial]
published: false
sitemap: false
---

<!-- AI-DRAFTED: review & edit -->

A quick Ruby on Rails tutorial / reference for getting a new project going.

## 1. Generate command for `rails new`

A sensible starting point for a modern Rails 7/8 app with PostgreSQL and no legacy JS bundler:

```bash
rails new my_app \
  --database=postgresql \
  --asset-pipeline=propshaft \
  --javascript=importmap \
  --css=tailwind
```

Adjust flags to taste — swap `tailwind` for `bootstrap`, or add `--api` for an API-only build. The [Daily Dev Tools generator](https://dailydevtools.com/rails_command_generator?v2) is handy for exploring all the options.

## 2. Next Steps

### Create and seed the database

```bash
cd my_app
rails db:create
rails db:migrate
```

### Start the dev server

```bash
bin/dev
```

This runs Foreman/Overmind with the `Procfile.dev` — it starts the Rails server, the CSS watcher, and any other watchers together. Don't use `rails s` alone or you'll miss asset compilation.

### Generate a scaffold to see things working

```bash
rails generate scaffold Post title:string body:text published:boolean
rails db:migrate
```

Then visit `http://localhost:3000/posts`.

### Run the test suite

```bash
bin/rails test
```

### Useful one-liners

```bash
rails routes            # list all routes
rails console           # open an IRB session against your app
rails db:seed           # run db/seeds.rb
rails generate --help   # see all generators
```

That's the bare minimum to go from zero to a running Rails app. Everything else builds on top of these fundamentals.
