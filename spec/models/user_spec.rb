require 'rails_helper'

RSpec.describe User, type: :model do
	before do
		@valid_attributes = {
				name: "MagicS", 
				email: "nangioWah@premiergaou.ci", 
				password: "onDit1st"			
		}
	end
	
	it "must have required fields or be invalid" do
		u = User.new
		expect(u).to_not be_valid
	end

	it "creates a new user with valid attributes" do
		expect(lambda{
			User.create(@valid_attributes)
		}).to change(User, :count).by(1)
	end
	
	context "Name" do
		it "must be present" do
			expect(lambda{
				User.create(name: "", email: "nangioWah@premiergaou.ci", password: "onDit1st")
			}).to_not change(User, :count)
		end

		it "must produce an error if no name is given" do
			u = User.new
			expect(u.errors[:name]).to_not be_nil
		end
		
		it "must be no more than 50 characters long" do
			expect(lambda{
				User.create(name: "m"*51, email: "nangioWah@premiergaou.ci", password: "onDit1st")
			}).to_not change(User, :count)
		end
	end

	context "Email" do
		it "must be present" do
			expect(lambda{
				User.create(name: "MagicS", email: "", password: "onDit1st")
			}).to_not change(User, :count)
		end

		it "must produce an error if no email is given" do
			u = User.new
			expect(u.errors[:email]).to_not be_nil
		end
		
		it "must be no more than 255 characters long" do
			expect(lambda{
				User.create(name: "MagicS", email: "m"*241+"@premiergaou.ci", password: "onDit1st")
			}).to_not change(User, :count)
		end
		
		it "must be a valid email address" do
			valid_email_address = %w[user@example.com USER@foo.COM A_US-ER@Foo.bar.org first.last@foo.jp alice+bob@baz.cn user@an.example.com 12@example.com]
			valid_email_address.each do |email_address|
				expect(lambda{
					User.create(name: "MagicS", email: email_address, password: "onDit1st")
				}).to change(User, :count).by(1)
			end
		end
		
		it "must not be an invalid email address" do
			invalid_email_address = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com .@example.com foo@bar..com]
			invalid_email_address.each do |email_address|
				expect(lambda{
					User.create(name: "MagicS", email: email_address, password: "onDit1st")
				}).to_not change(User, :count)
			end
		end

		it "must be unique" do
			p = FactoryGirl.create(:user)
			expect(lambda{
				User.create(name: "Princess", email: "nangioWah@premiergaou.ci", password: "cest2nd")
			}).to_not change(User, :count)
			
		end
		
		it "must be case insensitive" do
			p = FactoryGirl.create(:user)
			expect(lambda{
				User.create(name: "Princess", email: "NANGIOwAH@PREMIERGAOU.CI", password: "cest2nd")
			}).to_not change(User, :count)
		end
	end

	context "Password" do
		it "must be present" do
			expect(lambda{
				User.create(name: "MagicS", email: "nangiowa@premiergaou.ci", password: "")
			}).to_not change(User, :count)
		end

		it "must produce an error if no password is given" do
			u = User.new
			expect(u.errors[:password]).to_not be_nil
		end

		it "must be at least six characters long" do
			u = FactoryGirl.build(:user) 
			u.password = "five5"
			u.password_confirmation = u.password
			expect(u).to_not be_valid
		end
	end

	context "Authentication" do
		it "must return false if user has a nil digest" do
			u = FactoryGirl.build(:user) 
			expect(u).to_not be_authenticate(:remember, "")

		end
	end
	
end
