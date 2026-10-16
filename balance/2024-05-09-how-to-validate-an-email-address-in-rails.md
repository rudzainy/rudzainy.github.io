---
layout: post
title: "How to Validate an Email Address in Rails"
date: 2024-05-09 10:50 +0800
description: "A quick note on validating email addresses in Ruby on Rails."
category: balance
permalink: /balance/2024-05-09-how-to-validate-an-email-address-in-rails.html
data_category: balance
tags: ["ruby on rails", "tutorial"]
---
<!-- Page Header -->
<div class="page-header-balance">
  <nav aria-label="breadcrumb" class="container pt-3">
    <ol class="breadcrumb mb-0">
      <li class="breadcrumb-item"><a href="/">Home</a></li>
      <li class="breadcrumb-item"><a href="/balance/">Balance</a></li>
      <li class="breadcrumb-item active" aria-current="page">How to Validate an Email Address in Rails</li>
    </ol>
  </nav>
  <header class="container mt-3">
    <p class="mb-2" style="font-family:'Unica One',sans-serif;text-transform:uppercase;letter-spacing:0.05em;font-size:14px;color:rgba(255,255,255,0.75)"><time datetime="2024-05-09">09.05.2024</time> &middot; Tutorial</p>
    <h1 class="page-title">How to Validate an Email Address in Rails</h1>
  </header>
</div>
<!-- end Page Header -->

<!-- Main Content Section -->
<main class="container my-5">
  <article class="post-content">
    <p>A quick note on validating email addresses in Rails.</p>
    <p>Rails gives you a couple of clean options here &mdash; a built-in regex approach that covers most cases, and a gem if you need deeper validation (MX record checks, disposable email detection, etc.).</p>
    <div class="post-steps">
      <div class="steps-rail">
        <ol>
          <li>
            <div class="step-num">1</div>
            <div class="step-body">
              <h3>Built-in format validation (usually enough)</h3>
              <p>Rails 7.1+ ships a <code>URI::MailTo::EMAIL_REGEXP</code> constant you can reference directly:</p>
            </div>
          </li>
        </ol>
      </div>
    </div>
    <div class="post-code">
      <div class="code-block">
        <div class="code-header">
          <span class="code-file">app/models/user.rb</span>
          <span class="code-lang">Ruby</span>
        </div>
        <pre><code>class User &lt; ApplicationRecord
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
end</code></pre>
      </div>
    </div>
    <p>On older Rails, use a simple regex:</p>
    <div class="post-code">
      <div class="code-block">
        <div class="code-header">
          <span class="code-file">app/models/user.rb</span>
          <span class="code-lang">Ruby</span>
        </div>
        <pre><code>VALID_EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\.[^@\s]+\z/

validates :email,
  presence: true,
  format: { with: VALID_EMAIL_REGEX }</code></pre>
      </div>
    </div>
    <div class="post-steps">
      <div class="steps-rail">
        <ol>
          <li>
            <div class="step-num">2</div>
            <div class="step-body">
              <h3>Normalise the email before saving</h3>
              <p>It&rsquo;s good practice to downcase and strip whitespace so <code>User@Example.com</code> and <code>user@example.com</code> are treated as the same address:</p>
            </div>
          </li>
        </ol>
      </div>
    </div>
    <div class="post-code">
      <div class="code-block">
        <div class="code-header">
          <span class="code-file">app/models/user.rb</span>
          <span class="code-lang">Ruby</span>
        </div>
        <pre><code>before_validation :normalise_email

private

def normalise_email
  self.email = email.to_s.downcase.strip
end</code></pre>
      </div>
    </div>
    <div class="post-steps">
      <div class="steps-rail">
        <ol>
          <li>
            <div class="step-num">3</div>
            <div class="step-body">
              <h3>Deep validation with the truemail gem</h3>
              <p>If you need to verify the domain actually has MX records (catches typos like <code>@gamil.com</code>), add the gem:</p>
            </div>
          </li>
        </ol>
      </div>
    </div>
    <div class="post-callout is-tip">
      <aside>
        <div class="callout-header">
          <i class="icon-lightbulb" aria-hidden="true"></i>
          Tip
        </div>
        <p class="callout-body">The <strong>truemail</strong> gem goes beyond regex &mdash; it can check that the email domain has valid MX records. Great for cutting bounce rates on transactional flows. Add it with <code>gem "truemail"</code> in your Gemfile.</p>
      </aside>
    </div>
    <div class="post-code">
      <div class="code-block">
        <div class="code-header">
          <span class="code-file">Gemfile</span>
          <span class="code-lang">Ruby</span>
        </div>
        <pre><code>gem "truemail"</code></pre>
      </div>
    </div>
    <div class="post-code">
      <div class="code-block">
        <div class="code-header">
          <span class="code-file">config/initializers/truemail.rb</span>
          <span class="code-lang">Ruby</span>
        </div>
        <pre><code>Truemail.configure do |config|
  config.verifier_email = "hello@yourdomain.com"
  config.validation_type_for = { "gmail.com" =&gt; :regex }
end</code></pre>
      </div>
    </div>
    <p>Then validate on demand:</p>
    <div class="post-code">
      <div class="code-block">
        <div class="code-header">
          <span class="code-file">email.rb</span>
          <span class="code-lang">Ruby</span>
        </div>
        <pre><code>result = Truemail.validate("user@example.com")
result.result.valid?   # =&gt; true / false</code></pre>
      </div>
    </div>
    <p>For most apps, Option 1 + 2 is plenty. Reach for truemail when you need to cut down on bounces on a transactional email flow.</p>
    <div class="post-section-head" aria-hidden="true">
      <span class="head-tab"><i class="icon-book-open"></i><span>01</span></span>
    </div>
    <h2>References</h2>
    <ul>
      <li><a href="https://www.abstractapi.com/guides/email-validation/how-to-validate-an-email-address-in-ruby" target="_blank" rel="noopener">How to Validate an Email Address in Ruby &mdash; Abstract API</a></li>
      <li><a href="https://github.com/truemail-rb/truemail" target="_blank" rel="noopener">truemail on GitHub</a></li>
    </ul>
  </article>
</main>
<!-- end Main Content Section -->
