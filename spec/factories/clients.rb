FactoryBot.define do
  factory :client do
    client_name { "Stranger'sCandy" }
    client_url { "www.takesyouwhereyouwannabe.dep" }

    logo_url {
      Rack::Test::UploadedFile.new(
        File.join(
          Rails.root, "spec", "public", "uploads", "client", "logo_url", "logo_image.jpg"
        )
      )
    }

    image_url {
      Rack::Test::UploadedFile.new(
        File.join(
          Rails.root, "spec", "public", "uploads", "client", "image_url", "bg_image.jpg"
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

  end
end
