# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "password" }
    active { true }
    role { :user }
  end
end
