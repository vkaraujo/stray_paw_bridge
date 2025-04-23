# frozen_string_literal: true

FactoryBot.define do
  factory :pet do
    association :user
    name { "Fluffy" }
    species { :dog }
    size { "Medium" }
    age { rand(1..10) }
    status { :available }
    address { "123 Pet Street, São Paulo, Brazil" }
  end
end
