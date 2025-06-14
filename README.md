# 🐾 StrayPawBridge

StrayPawBridge is a pet adoption platform designed to connect rescuers and adopters. Built with ❤️ for animal lovers, it provides a streamlined experience for listing and adopting rescued pets.

---

## 📚 Documentation

You can explore the full project documentation—including architecture, features, glossary, and contribution guidelines—at:

👉 [https://vkaraujo.github.io/stray_paw_bridge](https://vkaraujo.github.io/stray_paw_bridge)

---

## ✨ Features

- 📋 List pets with photos, descriptions, location, and status (Available, Pending, Adopted)
- 🐶 Filter/search pets by species, size, and location
- 📨 Request, approve, reject, or cancel adoptions
- 🛡 Admin panel for user moderation and pet listing visibility
- 🔔 Notifications and mailers for important actions
- 🌐 Internationalization (i18n) with support for Portuguese and English

---

## 🛠 Technologies

Ruby on Rails 7.1, PostgreSQL, Hotwire (Turbo + Stimulus), Tailwind CSS, Devise, Pundit, RSpec, FactoryBot, SimpleCov, GitHub Actions

---

## 🧪 Test Coverage

![RSpec Tests](https://github.com/vkaraujo/stray_paw_bridge/actions/workflows/ci.yml/badge.svg)
![Coverage](https://img.shields.io/badge/Coverage-92%25-brightgreen)

> Run tests locally with:
```bash
COVERAGE=true bundle exec rspec
```

---

## 🚀 Getting Started

```bash
git clone https://github.com/vkaraujo/stray_paw_bridge.git
cd stray_paw_bridge
bundle install
yarn install
bin/setup
bin/dev
```

---

## 🐕 Sample Data

Seed file includes fantasy-inspired pets (Fluffy the Direwolf 🐺, Mistclaw the Tabby 🐱). Run:

```bash
bin/rails db:seed
```

---

## 📬 Contact

Made with care by [@vkaraujo](https://github.com/vkaraujo). Feel free to contribute or open issues! 🛠
