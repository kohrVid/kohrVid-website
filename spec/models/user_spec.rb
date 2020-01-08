require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user, :reader) }

  it "must have required fields or be invalid" do
    expect(User.new).to_not be_valid
    end

  it "creates a new user with valid attributes" do
    expect{
      User.create(FactoryBot.attributes_for(:user, :reader))
    }.to change(User, :count).by(1)
  end

  context "Name" do
    it "must be present" do
      expect{
        User.create(FactoryBot.attributes_for(:user, :reader, name: ""))
      }.to_not change(User, :count)
    end

    it "must produce an error if no name is given" do
      u = User.new
      u.save
      expect(u.errors[:name]).to_not be_nil
      expect(u.errors[:name]).to_not be_empty
    end

    it "must be no more than 50 characters long" do
      expect{
        User.create(FactoryBot.attributes_for(:user, :reader, name: "m"*51))
      }.to_not change(User, :count)
    end

    it "should not be in the list of banned usernames" do
      user = FactoryBot.build(:user, :reader, name: "anonymous")
      expect(user).to_not be_valid
    end

    it "should not be case sensitive" do
      user
      new_user = FactoryBot.build(
        :user, :reader, name: user.name.upcase, email: "test@something.com"
      )

      expect(new_user).to_not be_valid
    end
  end

  context "Email" do
    it "must be present" do
      expect{
        User.create(FactoryBot.attributes_for(:user, :reader, email: ""))
      }.to_not change(User, :count)
    end

    it "must produce an error if no email is given" do
      u = User.new
      u.save
      expect(u.errors[:email]).to_not be_nil
      expect(u.errors[:email]).to_not be_empty
    end

    it "must be no more than 255 characters long" do
      expect{
        User.create(FactoryBot.attributes_for(
          :user, :reader, email: "m"*241+"@premiergaou.ci"
        ))
      }.to_not change(User, :count)
    end

    it "must be a valid email address" do
      valid_email_address = %w[user@example.com USER@foo.COM A_US-ER@Foo.bar.org first.last@foo.jp alice+bob@baz.cn user@an.example.com 12@example.com]
      valid_email_address.each do |email_address|
        expect{
          User.create(FactoryBot.attributes_for(
            :user,
            :reader,
            email: email_address,
            name: [*'A'...'z'].sample(3).join
          ))
        }.to change(User, :count).by(1)
      end
    end

    it "must not be an invalid email address" do
      invalid_email_address = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com .@example.com foo@bar..com]
      invalid_email_address.each do |email_address|
        expect{
          User.create(FactoryBot.attributes_for(
            :user,
            :reader,
            email: email_address,
            name: [*'A'...'z'].sample(3).join
          ))
        }.to_not change(User, :count)
      end
    end

    it "must be unique" do
      user
      expect {
        User.create(FactoryBot.attributes_for(
          :user,
          :reader,
          name: "Raine",
          password: "cest2nd",
          password_confirmation: "cest2nd",
          admin: false
        ))
      }.to_not change(User, :count)
    end

    it "must be case insensitive" do
      user
      expect {
        User.create(
          name: "Raine",
          email: user.email.swapcase,
          password: "cest2nd",
          password_confirmation: "cest2nd",
          admin: false
        )
      }.to_not change(User, :count)
    end
  end

  context "Password" do
    let(:short_password) { 'five5' }

    it "must be present" do
      expect{
        User.create(FactoryBot.attributes_for(:user, :reader, password: ""))
      }.to_not change(User, :count)
    end

    it "must produce an error if no password is given" do
      u = User.new
      u.save
      expect(u.errors[:password]).to_not be_nil
      expect(u.errors[:password]).to_not be_empty
    end

    it "must be at least six characters long" do
      expect(
        FactoryBot.build(
          :user, :reader,
          password: short_password,
          password_confirmation: short_password
        )
      ).to_not be_valid
    end
  end
end
