---
layout: post
title: Rails Image Tag
date: 2024-01-11 11:02 +0800
description: How to use the image_tag helper in Rails to display images from app/assets and the public folder.
image:
category: Work
tags: [rails, tutorial, ruby]
published: false
sitemap: false
---

<!-- AI-DRAFTED: review & edit -->

A quick note on using the `image_tag` helper in Rails.

The `image_tag` helper generates an HTML `<img>` tag and handles asset paths for you — much cleaner than writing raw HTML.

## Steps

### 1. Images in app/assets/images

Drop your image into `app/assets/images/`, then reference it by filename:

```erb
<%= image_tag "logo.png" %>
```

Rails resolves the asset pipeline path automatically. You can pass standard HTML attributes as options:

```erb
<%= image_tag "logo.png", alt: "Company logo", class: "img-fluid", width: 200 %>
```

### 2. Images in the public folder

For files under `public/images/`, pass the path starting with `/`:

```erb
<%= image_tag "/images/banner.jpg", alt: "Banner" %>
```

### 3. Dynamic image paths

When the filename comes from a database record, use string interpolation:

```erb
<%= image_tag "products/#{@product.image_filename}", alt: @product.name %>
```

Or with Active Storage:

```erb
<%= image_tag @product.photo if @product.photo.attached? %>
```

### 4. Placeholder / missing image

Provide a fallback so broken images degrade gracefully:

```erb
<%= image_tag(@product.image.present? ? @product.image : "placeholder.png") %>
```

That's it — `image_tag` keeps your views clean and lets Rails handle cache-busting fingerprints automatically.

## Reference

<https://patrickkarsh.medium.com/image-tags-ruby-on-rails-basics-ad53585656ff>
