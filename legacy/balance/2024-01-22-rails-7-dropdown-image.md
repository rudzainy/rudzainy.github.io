---
layout: post
title: Rails 7 Dropdown Image
date: 2024-01-22 19:15 +0800
description: How to build a select dropdown that displays images alongside option labels in a Rails 7 form.
image:
category: Work
tags: [rails, tutorial, forms]
published: false
sitemap: false
---

<!-- AI-DRAFTED: review & edit -->

A quick note on adding an image dropdown in Rails 7.

Sometimes you want a `<select>` where each option shows a small image next to the label — for example, picking a country flag or a product variant. A pure `<select>` can't render images inside options, so the cleanest approach is a custom Stimulus controller that replaces the native select with a styled list.

## User Flow

1. User goes to show page.
2. User clicks edit.
3. A form appears with a styled dropdown; each option shows a thumbnail image + label.
4. User picks an option; the hidden `<select>` value updates so the form submits normally.

## Steps

### 1. Keep a hidden native select in the form

```erb
<%# app/views/products/_form.html.erb %>
<%= form.select :variant_id,
      @variants.map { |v| [v.name, v.id, { "data-image": v.image_url }] },
      {},
      { id: "variant-select", class: "d-none", data: { controller: "image-select", image_select_target: "select" } } %>
```

The `data-image` attribute on each `<option>` carries the URL. The native select is hidden; the Stimulus controller builds the visible UI.

### 2. Generate the Stimulus controller

```bash
rails generate stimulus image-select
```

### 3. Write the controller

```js
// app/javascript/controllers/image_select_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select"]

  connect() {
    this.buildDropdown()
  }

  buildDropdown() {
    const select = this.selectTarget
    const wrapper = document.createElement("div")
    wrapper.className = "image-select"

    const button = document.createElement("button")
    button.type = "button"
    button.className = "image-select__toggle"

    const list = document.createElement("ul")
    list.className = "image-select__list"
    list.hidden = true

    Array.from(select.options).forEach((opt) => {
      const li = document.createElement("li")
      li.dataset.value = opt.value
      li.innerHTML = `<img src="${opt.dataset.image}" alt="" width="24"> ${opt.text}`
      li.addEventListener("click", () => {
        select.value = opt.value
        button.innerHTML = li.innerHTML
        list.hidden = true
      })
      list.appendChild(li)
    })

    button.addEventListener("click", () => { list.hidden = !list.hidden })

    // Set initial display to the selected option
    const selected = select.options[select.selectedIndex]
    button.innerHTML = `<img src="${selected.dataset.image}" alt="" width="24"> ${selected.text}`

    wrapper.appendChild(button)
    wrapper.appendChild(list)
    select.insertAdjacentElement("afterend", wrapper)
  }
}
```

### 4. Add minimal CSS

```css
/* app/assets/stylesheets/image_select.css */
.image-select { position: relative; display: inline-block; }
.image-select__toggle { display: flex; align-items: center; gap: 8px; cursor: pointer; }
.image-select__list { position: absolute; background: #fff; border: 1px solid #ccc; list-style: none; padding: 4px 0; margin: 0; z-index: 10; }
.image-select__list li { display: flex; align-items: center; gap: 8px; padding: 6px 12px; cursor: pointer; }
.image-select__list li:hover { background: #f0f0f0; }
```

The hidden native `<select>` still submits with the form, so no changes needed on the controller or model side.
