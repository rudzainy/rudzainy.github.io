---
layout: post
title: The Framework
date: 2024-09-05 23:54 +2117
description: The framework Ranting is a link-in-bio platform that allows any Malaysian creators to showcase their work and social media profiles in a single, easy-to-share link.
image: /assets/img/posts/ranting/sketch.png
category: Work
tags: [rails, framework, open source, malaysia, ranting, gugel, portfolio]
published: true
sitemap: true
pin: true
---

## Overview

I imagined a framework for how Malaysians can communicate better.

{% responsive_image path: assets/img/posts/ranting/sketch.png alt: "Rough idea of a digital communication framework that has the potential to check a bunch of boxes." %}
_Rough idea of a digital communication framework that has the potential to check a bunch of boxes._

The image above outlines a modular system that integrates open-source solutions to support messaging, analytics, user profiles, and community interactions. The system is built primarily on **[Ruby on Rails](https://rubyonrails.org)** with integrations into open-source tools like **Telegram** or **Signal** (for messaging), **Discourse** or **Mastodon** (for community engagement), and analytics platforms. This framework focuses on flexibility, community-driven growth, and scalability while maintaining an emphasis on privacy and openness.

## Components Breakdown

### 1. **BINA (API Service)**
   - **Built with**: Ruby on Rails
   - **Purpose**: The brain and backbone of the system. BINA is the API layer that connects all the different services, ensuring smooth communication between modules.
   - **How it Works**: All modules send and receive data via BINA, so it functions like a central hub. Need to update a user’s profile in BIODATA? BINA makes it happen. Want analytics from BUFFET? BINA pulls that data.
   - **Why it Matters**: This ensures everything works cohesively, allowing future services to plug in easily. BINA makes the whole system scalable by acting as the glue.

### 2. **BORAK (Messaging Service)**
   - **Platform**: Telegram or Signal
   - **Purpose**: Your communication gateway. BORAK manages messaging between users, admin notifications, and alerts.
   - **How it Works**: Through Telegram or Signal, BORAK delivers messages securely. Whether users need to receive real-time notifications or admins want to send mass updates, BORAK handles it all. For example, it could notify users of new features or community updates.
   - **Why it Matters**: Secure, real-time communication is a must for modern platforms. Integrating with well-established, privacy-focused messaging platforms like Telegram or Signal keeps users connected and engaged.

### 3. **BIODATA (Link in Bio Service)**
   - **Built with**: Ruby on Rails, powered by open-source feature management tools like **BulletTrain**
   - **Purpose**: Profile and identity management. BIODATA lets users link external profiles and manage their public presence.
   - **How it Works**: Users can customize their profiles and integrate various external services, like social media links or custom domains via DNS. BIODATA also offers **Single Sign-On (SSO)**, allowing users to log in to multiple services seamlessly.
   - **Why it Matters**: Personalization is key. Whether a user is building a personal brand or simply needs a centralized identity across the system, BIODATA empowers them to manage their presence with ease. The SSO feature enhances user experience by eliminating repetitive logins.

### 4. **BUFFET (Analytics Service)**
   - **Platform**: Ruby on Rails, with open-source analytics solutions like **Plausible** or **Matomo**
   - **Purpose**: Data insights and analytics. BUFFET collects and analyzes data to provide insights into user behavior, system performance, and activity trends.
   - **How it Works**: BUFFET pulls data from other modules through BINA and displays it on customizable dashboards. This allows admins to track metrics like user activity, engagement rates, or system load. BUFFET ensures that privacy is respected, using tools like Plausible or Matomo that are built with user privacy in mind.
   - **Why it Matters**: Data is essential for decision-making. BUFFET gives you the numbers without compromising user privacy, so you can optimize the system, track growth, and stay informed on how the platform is used.

### 5. **BANTU (Documentation & Support)**
   - **Platform**: Discourse (or similar open-source forum)
   - **Purpose**: User support and documentation. BANTU is the go-to place for users to find help, share knowledge, and troubleshoot issues.
   - **How it Works**: Built on **Discourse**, BANTU offers a collaborative forum where users can access documentation, ask questions, and receive community-driven support. It could include how-tos, troubleshooting guides, or FAQs, all neatly organized.
   - **Why it Matters**: Documentation is essential for users to make the most out of the platform. BANTU combines structured documentation with an interactive forum for user-generated content, creating a robust support ecosystem.

### 6. **BALAI RAYA (Community Platform)**
   - **Platform**: Discourse or Mastodon
   - **Purpose**: A social space for community building. BALAI RAYA fosters interaction, collaboration, and engagement among users.
   - **How it Works**: Think of BALAI RAYA as a digital town square. Built on **Discourse** or **Mastodon**, it offers forums, discussion threads, and collaboration spaces. Users can share feedback, report bugs, or simply engage in open discussions.
   - **Why it Matters**: The community keeps platforms alive. BALAI RAYA allows users to connect and interact, creating a self-sustaining ecosystem where knowledge and support flow organically.

## Workflow and Interactions

Let’s take a closer look at how these modules work together:

- **BINA ↔ BORAK**: When BINA detects an event (like a new user joining or an update being pushed), BORAK sends a message through Telegram/Signal, notifying users or admin.
  
- **BINA ↔ BIODATA**: User data, like profile changes or SSO requests, flow through BINA. For example, a user updates their profile picture on BIODATA, and BINA ensures this change is reflected across the entire system.
  
- **BINA ↔ BUFFET**: BUFFET collects analytics data from various services via BINA. For instance, it might pull user engagement metrics from BALAI RAYA and compile a report for admin to review.

- **BINA ↔ BANTU**: BINA can access BANTU to provide up-to-date documentation based on system updates. For example, if a new feature is rolled out, documentation on BANTU is updated accordingly.
  
- **BINA ↔ BALAI RAYA**: Community interactions in BALAI RAYA are monitored and can be analyzed by BUFFET through BINA. If users frequently discuss a particular bug, BUFFET can flag it for further investigation.

## Key Technologies and Ideas Supporting the System

1. **Ruby on Rails**: As the core framework, Ruby on Rails powers the API (BINA) and handles integration between all the other modules. Rails’ modularity and scalability make it an ideal choice for this setup.

2. **Telegram/Signal**: Secure and privacy-conscious messaging platforms are integrated into BORAK, ensuring users receive real-time notifications without compromising their security.

3. **Discourse/Mastodon**: These open-source platforms are known for fostering strong community interactions, and they serve as the backbone for BANTU and BALAI RAYA. They allow for easy customization and management of forums and community spaces.

4. **Plausible/Matomo**: Open-source, privacy-focused analytics platforms used in BUFFET ensure that while data is collected and analyzed, user privacy remains intact.

5. **BulletTrain**: A Ruby on Rails tool used in BIODATA to help manage feature flags and rollout strategies, making the system easily adaptable and future-proof.

6. **Single Sign-On (SSO)**: Integrated into BIODATA, allowing users to sign in across multiple services with a single login, improving the user experience and streamlining security.

## Why This Architecture Works

This architecture is built with flexibility, privacy, and scalability in mind. By leveraging open-source tools, the system is highly adaptable and can easily grow with the community. Each module operates independently, making the framework modular, yet it all ties together through BINA, the API service, ensuring cohesive functionality.

The system can be expanded by plugging in new services, integrating third-party tools, or adding more open-source solutions to keep the platform modern and user-friendly. Moreover, privacy-conscious platforms like Telegram, Signal, Plausible, and Matomo show a strong focus on respecting user data, a crucial factor in today's digital landscape.

## Conclusion

This modular framework allows for seamless integration of various functionalities while keeping things flexible, scalable, and privacy-focused. Built on open-source foundations like Ruby on Rails, Discourse, Mastodon, and more, it supports real-time messaging, data analytics, user profiles, and community engagement, creating a holistic, open-source-driven ecosystem.
