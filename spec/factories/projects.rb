include ActionDispatch::TestProcess
FactoryBot.define do
  factory :project do
    name { "inqbrd" }
    repo_url { "gitshrub.brd/inky/inqbrd.repo" }
    app_url { "gitshrub.brd/inky/inqbrd" }
    languages { "scala, c++" }
    description { Faker::Lorem.paragraph }

    # This doesn't persist
    image {
      fixture_file_upload(
        File.join(
          Rails.root, "spec", "public", "uploads", "project", "image", "bg_image.jpg"
        )
      )
    }

    draft { true }
  end
end
