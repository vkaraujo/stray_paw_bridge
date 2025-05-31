---
title: Contributing
layout: default
---

# 🤝 Contributing to StrayPawBridge

Thank you for considering a contribution to **StrayPawBridge** — a Ruby on Rails platform for connecting pet rescuers and adopters.

This guide will help you get started with development, testing, and submitting improvements.

## 💡 Code Style and Conventions

- Follow standard Ruby and Rails conventions
- Use i18n for any user-facing text (`config/locales`)
- Keep views modular and clean with partials and helpers
- When possible, group related view updates and logic into clearly named components or helpers

## 🧩 Feature Development

If you're adding a feature:

- Open an issue first (if public repo)
- Create a feature branch (`git checkout -b feature/my-feature`)
- Include tests and i18n keys where applicable
- Submit a Pull Request with a clear description of your changes

## 🗃️ Folder Overview

Check out [`docs/architecture.md`](docs/architecture.md) for a breakdown of the project structure and domain logic.

## 🌍 Localization

All user-facing strings should be wrapped with `t("...")` and defined in:

- `config/locales/en.yml`
- `config/locales/pt-BR.yml`

## 📢 Need Help?

If you're unsure how to contribute, feel free to open a draft PR or ask in a GitHub Discussion (if enabled).

Thanks again for contributing! 🐾

