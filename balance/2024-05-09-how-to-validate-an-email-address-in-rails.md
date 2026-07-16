---
layout: post
title: How to Validate an Email Address in Rails
date: 2024-05-09 10:50 +0800
description: A quick note on validating email addresses in Ruby on Rails.
image:
category: Work
tags: [ruby on rails, tutorial]
published: false
sitemap: false
---

<!-- AI-DRAFTED: review & edit -->

A quick note on validating email addresses in Rails.

Rails gives you a couple of clean options here — a built-in regex approach that covers most cases, and a gem if you need deeper validation (MX record checks, disposable email detection, etc.).

## Steps

### Option 1: Built-in format validation (usually enough)

Rails 7.1+ ships a URI::MailTo::EMAIL_REGEXP constant you can reference directly:

```ruby
# app/models/user.rb
class User < ApplicationRecord
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
end
```

On older Rails, use a simple regex:

```ruby
VALID_EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/

validates :email,
  presence: true,
  format: { with: VALID_EMAIL_REGEX }
```

### Option 2: Normalise the email before saving

It's good practice to downcase and strip whitespace so `User@Example.com ` and `user@example.com` are treated as the same address:

```ruby
before_validation :normalise_email

private

def normalise_email
  self.email = email.to_s.downcase.strip
end
```

### Option 3: Deep validation with the truemail gem

If you need to verify the domain actually has MX records (catches typos like `@gamil.com`), add the gem:

```ruby
# Gemfile
gem "truemail"
```

```bash
bundle install
```

Configure it in an initializer:

```ruby
# config/initializers/truemail.rb
Truemail.configure do |config|
  config.verifier_email = "hello@yourdomain.com"
  config.validation_type_for = { "gmail.com" => :regex }
end
```

Then validate on demand:

```ruby
result = Truemail.validate("user@example.com")
result.result.valid?   # => true / false
```

For most apps, Option 1 + 2 is plenty. Reach for truemail when you need to cut down on bounces on a transactional email flow.

## References

- <https://www.abstractapi.com/guides/how-to-validate-an-email-address-in-ruby>
- <https://github.com/truemail-rb/truemail>
