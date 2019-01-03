FactoryBot.define do
  factory :project do
    name { "inqbrd" }
    repo_url { "gitshrub.brd/inky/inqbrd" }
    languages { "scala, c++" }
    description { Faker::Lorem.paragraph }
    image { "inqbrd.jpg" }
    draft { true }
  end
end
