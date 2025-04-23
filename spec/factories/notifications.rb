# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    user
    message { "You have a new update." }
    read { false }
  end
end
