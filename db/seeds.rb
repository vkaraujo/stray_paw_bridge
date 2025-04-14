# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.find_or_create_by!(email: 'admin@straypawbridge.test') do |admin|
  admin.password = 'password'
  admin.role = :admin
end

user = User.find_or_create_by!(email: "sample@user.com") do |u|
  u.password = "password"
  u.role = :user
end

3.times do |i|
  Pet.create!(
    name: "Buddy ##{i + 1}",
    description: "A friendly dog looking for a forever home.",
    species: :dog,
    size: %w[Small Medium Large].sample,
    age: rand(1..5),
    status: :available,
    user: user
  )
end
