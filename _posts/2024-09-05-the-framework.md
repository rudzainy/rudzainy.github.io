---
layout: post
title: The Framework
date: 2024-09-01 23:54 +2117
description: A modular, privacy-focused digital framework built on open-source tools, designed to support secure messaging, analytics, and community interactions. Emphasizing flexibility, scalability, and empowering community-driven growth and innovation.
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

The sketch above outlines a modular system that integrates open-source solutions to support the needs of Malaysians for digital communications such as private or closed-group messaging, analytics, content sharing, and community interactions. The system is built primarily on **[Ruby on Rails](https://rubyonrails.org)** with integrations into other readily available open-source tools like **Telegram** or **Signal** (for messaging), **Discourse** or **Mastodon** (for community engagement), and analytics platforms. This framework focuses on flexibility, community-driven growth, and scalability while maintaining an emphasis on privacy and openness.

By using a modular approach, the system can easily be customized and expanded to meet various needs, whether for businesses, community groups, or even local governments. Malaysians can rely on this framework to foster safe and private communication channels, build vibrant online communities, and gather meaningful insights through privacy-respecting analytics. This adaptability ensures that the system can keep up with evolving technology and user demands, while its open-source nature encourages collaboration and local innovation.

## Components Breakdown

### 1. **BINA (API Service)**
   - **Built with**: Ruby on Rails (or, really, whichever technology capable of maintaining API services. Rails' *convention over configuration* mantra is the reason it's on the top of my list)
   - **Purpose**: The brain and backbone of the system. BINA is the API layer that connects all the different services, ensuring smooth communication between modules.
   - **How it Works**: All modules send and receive data via BINA, so it functions like a central hub. Need to update a user’s profile in BIODATA? BINA makes it happen. Want analytics from BUFFET? BINA pulls that data.
   - **Why it Matters**: This ensures everything works cohesively, allowing future services to plug in easily. BINA makes the whole system scalable by acting as the glue.

### 2. **BORAK (Messaging Service)**
   - **Platform**: Telegram or Signal
   - **Purpose**: Your communication gateway. BORAK manages messaging between users, admin notifications, and alerts.
   - **How it Works**: Through re-skinning and locally hosting Telegram or Signal servers and clients, BORAK delivers messages securely. Whether users need to text, react with emojis or stickers, *borak* using voice or video calls, receive real-time notifications or admins want to send mass updates, BORAK handles it all.
   - **Why it Matters**: Secure, real-time communication is a must for modern platforms. Integrating with well-established, privacy-focused messaging platforms like Telegram or Signal keeps users connected and engaged without worrying about being monitored.

### 3. **BIODATA (Personal Website, Link in Bio Service)**
   - **Built with**: Ruby on Rails
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

- **BINA ↔ BORAK**: When BINA detects an event (like a milestone for new user joining or an update being pushed), BORAK sends a message through Telegram/Signal, notifying users or admin.
  
- **BINA ↔ BIODATA**: User data, like profile changes or SSO requests, flow through BINA. For example, a user updates their profile picture on BIODATA, and BINA ensures this change is reflected across the entire system.
  
- **BINA ↔ BUFFET**: BUFFET collects analytics data from various services via BINA. For instance, it might pull user engagement metrics from BALAI RAYA and compile a report for admin or other users to review.

- **BINA ↔ BANTU**: BINA can access BANTU to provide up-to-date documentation based on system updates. For example, if a new feature is rolled out, documentation on BANTU is updated accordingly.
  
- **BINA ↔ BALAI RAYA**: Community interactions in BALAI RAYA are monitored and can be analyzed by BUFFET through BINA. If users frequently discuss a particular bug, BUFFET can flag it for further investigation.

## Key Technologies and Ideas Supporting the System

1. **Ruby on Rails**: As the core framework, Ruby on Rails powers the API (BINA) and handles integration between all the other modules. Ruby is easy to learn, and Rails' modularity and scalability make it an ideal choice for this setup.

2. **Telegram/Signal**: Secure and privacy-conscious messaging platforms are integrated into BORAK, ensuring users receive real-time notifications without compromising their security.

3. **Discourse/Mastodon**: These open-source platforms are known for fostering strong community interactions, and they serve as the backbone for BANTU and BALAI RAYA. They allow for easy customization and management of forums and community spaces.

4. **Plausible/Matomo**: Open-source, privacy-focused analytics platforms used in BUFFET ensure that while data is collected and analyzed, user privacy remains intact.

5. **Single Sign-On (SSO)**: Integrated into BIODATA or using Discourse's SSO, allowing users to sign in across multiple services with a single login, improving the user experience and streamlining security.

Pricing Model: Affordable Yearly Subscription + Community Contributions

To maintain a balance between affordability and operational sustainability, the pricing model focuses on offering an inexpensive yearly subscription complemented by community contributions. This approach ensures users have access to essential services while enabling the platform to grow and maintain service uptime. Here’s how the pricing model can be structured:

1. Basic Yearly Subscription: $10/year

	•	What’s included:
	•	Access to core services (messaging, community forums, basic analytics)
	•	Limited data storage (e.g., 5GB)
	•	Basic customer support (email and community-based)
	•	Regular updates and maintenance
	•	Who it’s for: Individuals, small community groups, or startups that need a budget-friendly solution to access essential digital tools for communication and community engagement.

2. Pro Yearly Subscription: $50/year

	•	What’s included:
	•	Everything in the Basic plan
	•	Expanded data storage (e.g., 50GB)
	•	Advanced analytics and reporting tools
	•	Access to priority customer support
	•	Early access to new features and beta testing
	•	Integration with more third-party tools (e.g., social media, custom integrations)
	•	Who it’s for: Businesses, non-profits, and larger communities that require additional resources, advanced analytics, and higher-tier support to scale their digital presence.

3. Enterprise Custom Pricing

	•	What’s included:
	•	Tailored services and solutions for large-scale organizations
	•	Custom storage and server requirements
	•	Dedicated support team
	•	Custom integrations and white-label options
	•	SLA-backed uptime guarantees
	•	Who it’s for: Large organizations or corporations requiring highly customized solutions, dedicated support, and enhanced performance guarantees.

4. Community Contributions

To keep the platform sustainable and inclusive, additional voluntary contributions from the community are encouraged. These contributions help fund new features, service improvements, and keeping operations running smoothly. Contribution options include:

	•	Pay-What-You-Want Donations: Users can voluntarily contribute any amount to support platform maintenance and development.
	•	Crowdfunding Initiatives: Periodic crowdfunding campaigns to fund new features, server upgrades, or innovative projects.
	•	Open Source Contributions: Developers and technical users can contribute code, documentation, or bug fixes to help improve the platform.

5. Sponsorship and Grants

	•	Corporate Sponsorships: Organizations can sponsor specific features or services in exchange for brand recognition or access to tailored services.
	•	Government and NGO Grants: Applications for grants to maintain the open-source nature and support public-interest features, such as privacy enhancements or community-driven features for non-profits.

Operational and Maintenance Costs Covered:

	•	Server Infrastructure: Hosting and maintaining uptime for messaging, forums, and analytics.
	•	Security and Privacy Measures: Keeping user data safe with encryption, regular security updates, and privacy-first practices.
	•	Customer Support: Providing support channels for both free-tier and premium-tier users.
	•	Development and Innovation: Regular feature updates, bug fixes, and adapting to new technologies and user needs.

This pricing model ensures users from all backgrounds can access and benefit from the platform, while community contributions and flexible pricing tiers help maintain services and support growth over time.

## Why This Architecture Works

This architecture is designed with flexibility, privacy, and scalability at its core. By using open-source tools, the system is highly adaptable and can evolve with the needs of the community. Each module operates independently, offering a modular framework where services can be added or updated easily. Everything is tied together through **BINA**, the API service, ensuring all components work seamlessly.

For Malaysians, this framework offers several unique advantages:

1. **Data Sovereignty**: In a digital landscape where personal data is often stored on servers outside of Malaysia, this framework ensures that data can remain within the country, helping users retain control over their personal information. By relying on open-source platforms and privacy-respecting services like **Signal** and **Plausible**, Malaysians can trust that their data isn't being exploited by foreign corporations.

2. **Localization and Customization**: The architecture is built with localization in mind, meaning it can be customized to suit Malaysian cultural and linguistic needs. For example, community engagement tools like **BALAI RAYA** can be tailored to foster discussions in Bahasa Malaysia, promoting local language use in digital communities. This helps build a stronger online presence that reflects the diversity and inclusivity of Malaysia.

3. **Cost-Effectiveness**: With a strong reliance on open-source technologies like **Ruby on Rails**, **Discourse**, and **Mastodon**, this system is highly cost-effective. Open-source solutions reduce licensing costs, making the framework more accessible to small businesses, startups, and independent developers across Malaysia. This allows Malaysians to build and deploy their own systems without worrying about expensive subscription models or vendor lock-in.

4. **Empowering Local Innovation**: By adopting this architecture, Malaysians can contribute to and benefit from a global open-source community. Developers can modify the system to meet local needs, whether for social enterprises, government services, or community-driven platforms. This encourages a culture of innovation and collaboration, allowing Malaysians to create digital ecosystems that are homegrown and culturally relevant.

5. **Community-Centered Design**: The community-centric modules like **BALAI RAYA** and **BANTU** encourage community-driven support and engagement, enabling Malaysians to build self-sustaining online communities. These platforms provide opportunities for local knowledge sharing, tech support, and collaboration, which can strengthen digital literacy and foster a culture of community problem-solving.

6. **Privacy-First Approach**: Malaysians are increasingly aware of data privacy concerns, and this framework uses privacy-conscious tools like **Signal** for messaging and **Plausible** for analytics. These platforms emphasize user privacy, ensuring that Malaysians can use the system without fear of data exploitation or intrusive tracking, something that's becoming increasingly important in Malaysia’s growing digital economy.

## Conclusion

This modular framework is not only built for flexibility and scalability but is also deeply aligned with the unique needs of Malaysians. By utilizing open-source tools like **Ruby on Rails**, **Discourse**, **Mastodon**, and privacy-focused services, the framework ensures that users have control over their data while fostering local innovation. It supports real-time messaging, data analytics, user profiles, and community engagement, creating an ecosystem that prioritizes the privacy, culture, and autonomy of Malaysian users.

This system gives Malaysians the tools to create a digital space that’s truly their own—local, secure, and built around community values. It's designed to grow and adapt as needed, ensuring that Malaysia’s digital future is both independent and protected.
