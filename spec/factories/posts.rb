FactoryBot.define do
  factory :post do
    title { Faker::Lorem.words.join(" ") }
    body { Faker::Lorem.paragraph }
    draft { false }
    published_at { Time.now }
  end
end
