require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "must have required fields or be invalid" do
    t = Tag.new
    expect(t).to_not be_valid
  end

  it "creates a new tag with valid attributes" do
    expect{
      Tag.create(FactoryBot.attributes_for(:tag))
    }.to change(Tag, :count).by(1)
  end
  
  context "Name" do
    it "must be present" do
      expect{
        Tag.create(FactoryBot.attributes_for(:tag, name: ""))
      }.to_not change(Tag, :count)
    end

    it "must produce an error if no name is given" do
      t = Tag.new
      expect(t.errors[:name]).to_not be_nil
    end
    
    it "must be no more than 15 characters long" do
      expect{
        Tag.create(FactoryBot.attributes_for(:tag, name: "m"*16))
      }.to_not change(Tag, :count)
    end
    
    it "must be unique" do
      t = FactoryBot.create(:tag)
      expect{
        Tag.create(FactoryBot.attributes_for(:tag))
      }.to_not change(Tag, :count)
      
    end
  end
  
  context "Posts" do
    it "can have posts" do
      expect(Tag.new).to respond_to(:posts)
    end
  end
end
