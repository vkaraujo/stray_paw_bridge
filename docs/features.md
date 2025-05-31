# ✨ Features — StrayPawBridge

StrayPawBridge is a platform to connect rescuers and adopters, making pet adoptions easier, safer, and more transparent. Below is a breakdown of the main features the app currently supports.

## 🐾 Pet Listings

- Create and manage listings for dogs and cats
- Add pet details: name, species, size, description, and photos
- Listings have one of three statuses: `Available`, `Pending`, or `Adopted`
- Only the user who created a listing can edit or delete it

## 📝 Adoption Requests

- Any logged-in user can request to adopt a pet
- Rescuer can approve or reject each request
- When approved, pet status becomes `Pending`
- Rescuer must confirm adoption after contact, which sets status to `Adopted`
- Adopted pets are removed from public views

## 💬 Messaging System

- One-on-one chat between adopter and rescuer after approval
- Messages are grouped under the adoption request
- Simple real-time-inspired UI using Turbo + Rails partials
- Chat button appears for both users on approved requests

## 🔔 Notifications

- Users are notified when:
  - Their adoption request is approved, rejected, or canceled
  - A new chat message is received
- Notifications support read/unread states
- Rescuers can open chat or mark notifications as read directly from dashboard

## 📋 User Dashboards

- **My Pets** (for rescuers): Manage all pet listings, update status, or conclude adoptions
- **My Adoptions** (for adopters): Track request status, chat with rescuers, or cancel requests
- Dynamic layout adapts to user’s role and request state

## 🔐 Authentication and Authorization

- Built with Devise
- All actions require authentication
- Only owners of a resource can modify it
- Admin role planned for future moderation

## 🌍 Internationalization

- Fully translated into:
  - English (`en`)
  - Portuguese (`pt-BR`)
- Easy to add new locales via `I18n` keys

## 🧪 Tests and Code Coverage

- RSpec coverage for models, requests, helpers, and partials
- `COVERAGE=true rspec` generates SimpleCov HTML report

Let us know if you want to contribute or suggest a new feature!
