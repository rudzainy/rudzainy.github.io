---
layout: post
title: Rails Drag and Drop
date: 2024-01-11 11:51 +0800
description: Add drag-and-drop list reordering to a Rails app using Stimulus and SortableJS, persisted via an AJAX patch.
image:
category: Work
tags: [rails, stimulus, tutorial]
published: false
sitemap: false
---

<!-- AI-DRAFTED: review & edit -->

A quick note on adding drag-and-drop sorting to a Rails app.

The cleanest approach I've found: SortableJS handles the drag interaction, a Stimulus controller listens for the `end` event and fires a `fetch` PATCH to persist the new position, and Rails updates the record. No extra gems needed.

## Steps

### 1. Install SortableJS

```bash
yarn add sortablejs
```

Or via importmap:

```bash
bin/importmap pin sortablejs
```

### 2. Add a `position` column to your model

```bash
rails generate migration AddPositionToItems position:integer
rails db:migrate
```

In the model, set a default scope so records come out ordered:

```ruby
# app/models/item.rb
class Item < ApplicationRecord
  belongs_to :list
  default_scope { order(:position) }
end
```

### 3. Add a `reorder` action to the controller

```ruby
# app/controllers/items_controller.rb
def reorder
  params[:order].each_with_index do |id, index|
    Item.where(id: id).update_all(position: index + 1)
  end
  head :ok
end
```

Wire it in routes:

```ruby
# config/routes.rb
resources :lists do
  resources :items do
    collection { patch :reorder }
  end
end
```

### 4. Generate the Stimulus controller

```bash
rails generate stimulus sortable
```

### 5. Write the Stimulus controller

```js
// app/javascript/controllers/sortable_controller.js
import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      onEnd: this.onEnd.bind(this)
    })
  }

  disconnect() {
    this.sortable.destroy()
  }

  onEnd() {
    const order = Array.from(this.element.children).map(el => el.dataset.id)
    fetch(this.urlValue, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ order })
    })
  }
}
```

### 6. Update the view

```erb
<%# app/views/lists/show.html.erb %>
<ul data-controller="sortable"
    data-sortable-url-value="<%= reorder_list_items_path(@list) %>">
  <% @list.items.each do |item| %>
    <li data-id="<%= item.id %>">
      <%= item.name %>
    </li>
  <% end %>
</ul>
```

Drag an item and the order persists immediately — no page reload needed.

## Reference

<https://www.cjav.dev/articles/quick-drag-and-drop-sorting-with-rails-using-stimulus-and-shopify-draggable>
