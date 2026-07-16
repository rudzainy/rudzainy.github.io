---
layout: post
title: Setup Python 3 on MacOS
date: 2024-03-16 16:20 +0800
description: Install Python 3 on macOS using Homebrew and set up pip so you can start running Python scripts right away.
image:
category: Work
tags: [python, macos, tutorial]
published: false
sitemap: false
---

<!-- AI-DRAFTED: review & edit -->

# Quick guide to setup Python 3 on MacOS using Homebrew

## 1. Why Homebrew

macOS ships with Python 2 (or a stub that asks you to install Xcode tools) — neither is what you want for modern Python work. Homebrew gives you a clean, up-to-date Python 3 install that's easy to update and doesn't touch any system files. It's the path of least pain.

## 2. Install Homebrew (if you haven't already)

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow the prompts. After it finishes, run `brew doctor` to confirm everything is healthy.

## 3. Install Python 3

```bash
brew install python
```

Homebrew installs Python 3 as `python3` and `pip3`. Check it worked:

```bash
python3 --version
pip3 --version
```

You should see something like `Python 3.12.x`.

## 4. (Optional) Make `python` point to Python 3

By default `python` may still resolve to the system stub. Add this to your `~/.zshrc` or `~/.bash_profile`:

```bash
alias python=python3
alias pip=pip3
```

Then reload: `source ~/.zshrc`

## 5. Verify and use pip

Install a package to confirm pip is working:

```bash
pip3 install qrcode
```

You should see Downloading / Installing output and no errors. From here you can install any package from PyPI the same way.

That's it — you're ready to run Python 3 scripts on your Mac.
