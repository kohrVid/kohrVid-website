require 'rails_helper'

RSpec.describe Post, type: :model do
	it "must have required fields or be invalid" do
		p = Post.new
		expect(p).to_not be_valid
	end

	it "creates a new post with valid attributes" do
		expect{
			Post.create(FactoryGirl.attributes_for(:post))
		}.to change(Post, :count).by(1)
	end
	
	context ".title" do
		it "must be present" do
			expect{
				Post.create(FactoryGirl.attributes_for(:post, title: ""))
			}.to_not change(Post, :count)
		end

		it "must produce an error if no title is given" do
			p = Post.new
			expect(p.errors[:title]).to_not be_nil
		end
		
		it "must be no more than 50 characters long" do
			expect{
				Post.create(FactoryGirl.attributes_for(:post, title: "m"*51))
			}.to_not change(Post, :count)
		end
		
		it "must be unique" do
			p = FactoryGirl.create(:post)
			expect{
				Post.create(FactoryGirl.attributes_for(:post, body: "New Body"))
			}.to_not change(Post, :count)
			
		end
	end

	context ".body" do
		it "must be present" do
			expect{
				Post.create(FactoryGirl.attributes_for(:post, body: ""))
			}.to_not change(Post, :count)
		end

		it "must produce an error if no email is given" do
			p = Post.new
			expect(p.errors[:body]).to_not be_nil
		end
		
		it "must be at least 4 characters long" do
			expect{
				Post.create(FactoryGirl.attributes_for(:post, body: "m"*3))
			}.to_not change(Post, :count)
		end
		
		it "must be no more than 20000 characters long" do
			expect{
				Post.create(FactoryGirl.attributes_for(:post, body: "m"*20001))
			}.to_not change(Post, :count)
		end
		
		it "must be unique" do
			p = FactoryGirl.create(:post)
			expect{
				Post.create(FactoryGirl.attributes_for(:post, title: "New Title"))
			}.to_not change(Post, :count)
		end
	end

	context "Tags" do
		it "can have tags" do
			expect(Post.new).to respond_to(:tags)
		end
=begin
		it "can have many tags" do
			tag = FactoryGirl.create(:tag)
			tag2 = FactoryGirl.create(:tag, name: "Cats")
			p = FactoryGirl.build(:post, tag: [tag, tag2])
			expect(p).to be_valid
		end

		it "must have at least one tag" do
			p = Post.new
			expect(p).to_not be_valid
			expect(p.errors[:tags]).to be_present 
		end
=end
	end
end
