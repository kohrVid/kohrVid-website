require 'rails_helper'

RSpec.describe Comment, type: :model do
	it "must have required fields or be invalid" do
		c = Comment.new
		expect(c).to_not be_valid
	end

	it "creates a new comment with valid attributes" do
		expect{
			Comment.create(FactoryBot.attributes_for(:comment))
		}.to change(Comment, :count).by(1)
	end
	
	context ".body" do
		it "must be present" do
			expect{
				Comment.create(FactoryBot.attributes_for(:comment, body: ""))
			}.to_not change(Comment, :count)
		end

		it "must produce an error if no title is given" do
			c = Comment.new
			expect(c.errors[:body]).to_not be_nil
		end
	end
	
	context ".post_id" do
		it "must be present" do
			expect{
				Comment.create(FactoryBot.attributes_for(:comment, post_id: nil))
			}.to_not change(Comment, :count)
		end

		it "must produce an error if no post ID is given" do
			c = Comment.new
			expect(c.errors[:post_id]).to_not be_nil
		end
	end

	context "@author" do
		it "to be set to Anonymous if no user_id is set" do
			c = FactoryBot.create(:comment, author: "", user_id: "")
			expect(c.author).to eq("Anonymous")
		end
	end
end
