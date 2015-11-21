FactoryGirl.define do

	factory :user do |u|
		u.name "MagicS" 
		u.email "nangioWah@premiergaou.ci" 
		u.password "onDit1st"			
	end

	factory :client do |c|
		c.client_name "Stranger'sCandy"
		c.client_url "www.takesyouwhereyouwannabe.dep"
		c.logo_url { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec", "public", "uploads", "client", "logo_url", "logo_image.jpg")) } 
		c.image_url { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec", "public", "uploads", "client", "image_url", "bg_image.jpg")) } 
		c.pdf { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec", "public", "uploads", "client", "pdf", "file.pdf")) } 
		
	end
end
