# frozen_string_literal: true

FactoryBot.define do
  factory :adoption_request do
    user
    pet
    status { :pending }
    message { "I'd love to adopt this pet!" }
  end
end
