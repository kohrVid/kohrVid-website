FactoryBot.define do
  factory :post do
    title { Faker::Lorem.words.join(" ") }
    rich_text_body { "<div>#{Faker::Lorem.paragraph}</div>" }
    draft { false }
    published_at { Time.now }
  end
end
