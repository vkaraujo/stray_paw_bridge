# 📓 Glossary – StrayPawBridge

This document defines key terms used throughout the StrayPawBridge project. It’s meant to help new developers, contributors, and stakeholders understand the domain-specific language used in our codebase and documentation.

### 🐾 Pet

A rescued animal listed for adoption. Pets have attributes like:

- `name`
- `species` (e.g., dog, cat)
- `size` (e.g., small, medium, large)
- `status` (`available`, `pending`, or `adopted`)
- `photo` (optional image)

### 👤 User

A person who creates an account on the platform. All users can:

- List pets for adoption
- Submit adoption requests
- View dashboards and notifications

Some users may have special roles in the future (e.g., admin or institutional accounts).

### 🤝 Adoption Request

A user’s proposal to adopt a specific pet. Each request:

- Belongs to one user and one pet
- Includes an optional message
- Has a `status`:  
  - `pending` – waiting for the pet owner’s response  
  - `approved` – owner has accepted the request  
  - `rejected` – owner has declined  
  - `cancelled` – adopter cancelled before decision  

When a request is approved, the pet’s status becomes `pending`. It becomes `adopted` only when the lister confirms the adoption.

### 📬 Notification

An internal message triggered by events such as:

- Adoption request submitted
- Request approved or rejected
- Chat messages received

Notifications appear in the user’s dashboard and can be marked as read.

### 💬 Chat (Messages)

Once an adoption request is approved, the lister and adopter can chat. This conversation is stored as a list of `Message` records linked to the `AdoptionRequest`.

### 🧑‍⚖️ Admin

An elevated role with permissions to:

- Moderate listings
- Manage user accounts
- Access internal dashboards

Admins are not implemented for general users yet, but the system is ready to support them.

### 🏢 Institutional User *(Planned)*

An upcoming feature to support NGOs, shelters, and organizations that list multiple pets under one profile. These users may also receive reviews and custom dashboards.

---

If you think a term should be added to this list, feel free to open a Pull Request or GitHub Discussion!
