FactoryBot.define do
  factory :project do
    name { "inqbrd" }
    repo_url { "gitshrub.brd/inky/inqbrd.repo" }
    app_url { "gitshrub.brd/inky/inqbrd" }
    languages { "scala, c++" }
    description { Faker::Lorem.paragraph }

    # This doesn't persist
    image {
      Rack::Test::UploadedFile.new(
        File.join(
          Rails.root, "spec", "public", "uploads", "project", "image", "bg_image.jpg"
        )
      )
    }

    draft { true }
  end
end
