FactoryBot.define do
  factory :client do
    name { "Stranger'sCandy" }
    client_url { "www.takesyouwhereyouwannabe.dep" }

    logo {
      Rack::Test::UploadedFile.new(
        File.join(
          Rails.root, "spec", "public", "uploads", "client", "logo", "logo_image.png"
        )
      )
    }

    image {
      Rack::Test::UploadedFile.new(
        File.join(
          Rails.root, "spec", "public", "uploads", "client", "image", "bg_image.png"
        )
      )
    }

    pdf {
      Rack::Test::UploadedFile.new(
        File.join(
          Rails.root, "spec", "public", "uploads", "client", "pdf", "file.pdf"
        )
      )
    }

    draft { true }
  end
end
