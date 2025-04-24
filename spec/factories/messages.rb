FactoryBot.define do
  factory :message do
    content { "MyText" }
    user { nil }
    adoption_request { nil }
  end
end
