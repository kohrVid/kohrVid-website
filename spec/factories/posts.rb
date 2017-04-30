FactoryGirl.define do
  factory :post do
    title Faker::Lorem.words.join(" ")
    body Faker::Lorem.paragraph
    draft false
    #slug "this-is-my-first-blog-post"
    published_at Time.now#Time.new(2016, 03, 21, 11, 05, 00)
  end
end
