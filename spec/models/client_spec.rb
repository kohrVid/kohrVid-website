require 'rails_helper'

RSpec.describe Client, type: :model do
	before do
		@valid_attributes = {
			client_name: "Stranger'sCandy",
			client_url: "www.takesyouwhereyouwannabe.dep",
			logo_url: File.open(File.join(Rails.root, "/spec/public/uploads/client/logo_url/logo_image.jpg")),
			image_url: File.open(File.join(Rails.root, "/spec/public/uploads/client/image_url/bg_image.jpg")),
			pdf: File.open(File.join(Rails.root, "/spec/public/uploads/client/pdf/file.pdf"))
		}
	end

	it "must have required fields or be invalid" do
		c = Client.new
		expect(c).to_not be_valid
	end

	it "creates a new client with valid attributes" do
		expect(lambda{
			Client.create(@valid_attributes)
		}).to change(Client, :count).by(1)
	end

	context "Name" do
		it "must be present" do
			expect(lambda{
				Client.create(client_name: "", client_url: "www.takesyouwhereyouwannabe.dep")
			}).to_not change(Client, :count)
		end

		it "must produce an error if no name is given" do
			c = Client.new
			expect(c.errors[:client_name]).to_not be_nil
		end
	end
	
	context "URL" do
		it "must be present" do
			expect(lambda{
				Client.create(client_name: "Stranger'sCandy", client_url: "")
			}).to_not change(Client, :count)
		end

		it "must produce an error if no URL is given" do
			c = Client.new
			expect(c.errors[:client_url]).to_not be_nil
		end
	end



end
