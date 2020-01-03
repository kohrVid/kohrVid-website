FactoryBot.define do
  post_body =Faker::Lorem.paragraph
  factory :post do
    title { Faker::Lorem.words.join(" ") }
    body { post_body }
    rich_text_body { ActionText::Content.new("<div>#{post_body}</div>") }
    draft { false }
    published_at { Time.now }
  end
end
