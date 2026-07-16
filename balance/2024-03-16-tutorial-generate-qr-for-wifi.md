---
layout: post
title: Tutorial Generate QR for Wifi
date: 2024-03-16 10:54 +0800
description: Generate a QR code that auto-connects guests to your WiFi using Python and the qrcode library.
image:
category: Work
tags: [python, qrcode, tutorial]
published: false
sitemap: false
---

<!-- AI-DRAFTED: review & edit -->

> Quick guide to setup Python on MacOS

A quick guide to generating a QR code that connects to your WiFi.

Handy for printing and sticking on the fridge so guests can scan and connect without you having to read out a 20-character password.

## 1. Install Pure Python QR Code Generator

```bash
pip3 install qrcode[pil]
```

The `[pil]` extra pulls in Pillow so the library can export PNG files.

## 2. Generate the WiFi QR Code

The WiFi QR format is a standardised string that most phone cameras recognise natively:

```
WIFI:T:<auth-type>;S:<ssid>;P:<password>;;
```

Here's a short script that builds that string and saves a PNG:

```python
# generate_wifi_qr.py
import qrcode

SSID     = "YourNetworkName"
PASSWORD = "YourPassword"
AUTH     = "WPA"   # WPA, WEP, or nopass

wifi_string = f"WIFI:T:{AUTH};S:{SSID};P:{PASSWORD};;"

qr = qrcode.QRCode(
    version=1,
    error_correction=qrcode.constants.ERROR_CORRECT_H,
    box_size=10,
    border=4,
)
qr.add_data(wifi_string)
qr.make(fit=True)

img = qr.make_image(fill_color="black", back_color="white")
img.save("wifi_qr.png")
print("Saved wifi_qr.png")
```

Run it:

```bash
python3 generate_wifi_qr.py
```

Open `wifi_qr.png`, print it, and you're done. Most Android and iOS cameras will decode it and offer to join the network automatically.
