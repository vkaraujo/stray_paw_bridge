# frozen_string_literal: true
require "open-uri"

puts "🌱 Seeding users..."

User.find_or_create_by!(email: 'admin@straypawbridge.test') do |admin|
  admin.password = 'password'
  admin.role = :admin
end

rescuer = User.find_or_create_by!(email: "rescuer@user.com") do |u|
  u.password = "password"
  u.role = :user
end

User.find_or_create_by!(email: "adopter@user.com") do |a|
  a.password = "password"
  a.role = :user
end

puts "🧹 Cleaning up pets..."
Pet.destroy_all

puts "🌍 Loading fantasy pet data..."

fantasy_dogs = [
  { name: "Nighteyes", breed: "Wolf", source: "Robin Hobb", image: "https://images.unsplash.com/photo-1558788353-f76d92427f16" },
  { name: "Smithy", breed: "Terrier", source: "Robin Hobb", image: "https://images.unsplash.com/photo-1518717758536-85ae29035b6d" },
  { name: "Nosy", breed: "Spaniel", source: "Robin Hobb", image: "https://res.cloudinary.com/dhk8ebunw/image/upload/v1745181186/n3rx1g1jj9a14v7jg4z7qsyilee8.jpg" },
  { name: "Dufas", breed: "Hound", source: "Robin Hobb", image: "https://res.cloudinary.com/dhk8ebunw/image/upload/v1745181276/bafiuiqvmmr9j4382q0scs4ja2bg.jpg" },
  { name: "TenSoon", breed: "Kandra (Wolf Form)", source: "Mistborn", image: "https://images.unsplash.com/photo-1507146426996-ef05306b995a" },
  { name: "Huan", breed: "Elven Hound", source: "Lord of the Rings", image: "https://res.cloudinary.com/dhk8ebunw/image/upload/v1745177063/91volgpfpcxksnbtpcgqbifcno68.avif" },
  { name: "Ghost", breed: "Direwolf", source: "A Song of Ice and Fire", image: "https://images.unsplash.com/photo-1502673530728-f79b4cab31b1" },
  { name: "Nymeria", breed: "Direwolf", source: "A Song of Ice and Fire", image: "https://images.unsplash.com/photo-1525253086316-d0c936c814f8" },
  { name: "Summer", breed: "Direwolf", source: "A Song of Ice and Fire", image: "https://images.unsplash.com/photo-1560807707-8cc77767d783" },
  { name: "Shaggydog", breed: "Direwolf", source: "A Song of Ice and Fire", image: "https://res.cloudinary.com/dhk8ebunw/image/upload/v1745181117/70ui5ltvrdn22qjltv7g4fwkw46j.jpg" }
]

fantasy_cats = [
  { name: "Syrax", breed: "Dragon", source: "ASOIAF", image: "https://images.unsplash.com/photo-1518791841217-8f162f1e1131" },
  { name: "Drogon", breed: "Dragon", source: "ASOIAF", image: "https://images.unsplash.com/photo-1574158622682-e40e69881006" },
  { name: "Rhaegal", breed: "Dragon", source: "ASOIAF", image: "https://plus.unsplash.com/premium_photo-1673967831980-1d377baaded2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y2F0c3xlbnwwfHwwfHx8MA%3D%3D" },
  { name: "Viserion", breed: "Dragon", source: "ASOIAF", image: "https://images.unsplash.com/photo-1592194996308-7b43878e84a6" },
  { name: "Verity", breed: "Elderling Dragon", source: "Robin Hobb", image: "https://plus.unsplash.com/premium_photo-1666612335748-d23dcba788e1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Y2F0c3xlbnwwfHwwfHx8MA%3D%3D" },
  { name: "Tintaglia", breed: "Blue Dragon", source: "Robin Hobb", image: "https://images.unsplash.com/photo-1518791841217-8f162f1e1131?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8Y2F0c3xlbnwwfHwwfHx8MA%3D%3D" },
  { name: "Mercor", breed: "Gold Dragon", source: "Robin Hobb", image: "https://images.unsplash.com/photo-1541781774459-bb2af2f05b55?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGNhdHN8ZW58MHx8MHx8fDA%3D" },
  { name: "Kelsingra", breed: "Silver Dragon", source: "Robin Hobb", image: "https://images.unsplash.com/photo-1532386236358-a33d8a9434e3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGNhdHN8ZW58MHx8MHx8fDA%3D" },
  { name: "Firenzia", breed: "Fire-Scaled Dragon", source: "Original", image: "https://images.unsplash.com/photo-1543852786-1cf6624b9987" },
  { name: "Ashfall", breed: "Charcoal Dragon", source: "Original", image: "https://images.unsplash.com/photo-1589883661923-6476cb0ae9f2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjN8fGNhdHN8ZW58MHx8MHx8fDA%3D" }
]

def random_size
  %w[Small Medium Large].sample
end

def random_age
  rand(1..12)
end

def attach_image_from_url(pet, url)
  file = URI.open(url)
  pet.photo.attach(
    io: file,
    filename: File.basename(URI.parse(url).path),
    content_type: "image/jpeg"
  )
rescue => e
  puts "❌ Failed to attach image for #{pet.name}: #{e.message}"
end

puts "🐶 Creating dogs..."

fantasy_dogs.each do |dog|
  pet = Pet.create!(
    name: dog[:name],
    description: "A loyal #{dog[:breed]} companion from #{dog[:source]}.",
    species: :dog,
    size: random_size,
    age: random_age,
    status: :available,
    user: rescuer
  )
  attach_image_from_url(pet, dog[:image])
end

puts "🐱 Creating cats..."

fantasy_cats.each do |cat|
  pet = Pet.create!(
    name: cat[:name],
    description: "A mysterious #{cat[:breed]} inspired by #{cat[:source]}.",
    species: :cat,
    size: random_size,
    age: random_age,
    status: :available,
    user: rescuer
  )
  attach_image_from_url(pet, cat[:image])
end

puts "✅ Done seeding!"
