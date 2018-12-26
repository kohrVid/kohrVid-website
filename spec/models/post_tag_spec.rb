require 'rails_helper'

RSpec.describe PostTag, type: :model do
  it "must have required fields or be invalid" do
    pt = PostTag.new
    expect(pt).to_not be_valid
  end

  it "creates a new post_tag relationship with valid attributes" do
    expect{
      PostTag.create(FactoryBot.attributes_for(:post_tag))
    }.to change(PostTag, :count).by(1)
  end

  context "unique records" do
    let(:valid_post) { FactoryBot.create(:post) }
    let(:valid_tag) { FactoryBot.create(:tag) }

    it "must be unique" do
      expect{
        PostTag.create(FactoryBot.attributes_for(:post_tag, post_id: valid_post.id, tag_id: valid_tag.id))
      }.to change(PostTag, :count).by(1)
      expect{
        PostTag.create(FactoryBot.attributes_for(:post_tag, post_id: valid_post.id, tag_id: valid_tag.id))
      }.to_not change(PostTag, :count)
    end
  end
  
  context "post_id" do
    it "must be present" do
      expect{
        PostTag.create(FactoryBot.attributes_for(:post_tag, post_id: nil))
      }.to_not change(PostTag, :count)
    end

    it "must produce an error if no title is given" do
      pt = PostTag.new
      expect(pt.errors[:post_id]).to_not be_nil
    end
  end
  
  context "tag_id" do
    it "must be present" do
      expect{
        PostTag.create(FactoryBot.attributes_for(:post_tag, tag_id: nil))
      }.to_not change(PostTag, :count)
    end

    it "must produce an error if no title is given" do
      pt = PostTag.new
      expect(pt.errors[:tag_id]).to_not be_nil
    end
  end
end
