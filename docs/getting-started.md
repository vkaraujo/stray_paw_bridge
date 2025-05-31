# Getting Started 🛠️

Welcome to **StrayPawBridge**! This guide will help you set up the project locally.

## 📋 Requirements

- Ruby 3.2+
- Rails 7
- PostgreSQL
- Redis (for background jobs and Turbo Streams)
- Node.js and Yarn (for asset pipeline)
- ImageMagick (for ActiveStorage image variants)

## 🔧 Setup Instructions

1. **Clone the repository**  
  ```bash
  git clone https://github.com/vkaraujo/stray_paw_bridge.git
  cd stray_paw_bridge
  ```

2. **Install dependencies**
  ```bash
  bundle install
  yarn install
  ```

3. **Set up the database**
  ```bash
  bin/rails db:setup
  ```

4. **Start the server**
  ```bash
  bin/dev
  ```

This runs the Rails server, assets watcher, and Hotwire in one go.

## 📦 Running the Tests
  ```bash
  bundle exec rspec
  ```

To generate a SimpleCov coverage report, run:

  ```bash
  COVERAGE=true bundle exec rspec
  ```
The HTML report will be available at coverage/index.html

## 🌐 Access the App
Visit http://localhost:3000

Use the Devise sign-up flow or seed demo users (if available).

## 🐛 Troubleshooting

If you encounter issues:

  - Ensure PostgreSQL and Redis are running.
  - Check that you're using the correct Ruby version.
  - Run rails db:drop db:create db:migrate if migrations break.

## 🙌 Need Help?

Feel free to open an issue or contact the author directly via GitHub.

