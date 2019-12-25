require 'rails_helper'

RSpec.describe PostTag, type: :model do
  let(:valid_post_tag) { FactoryBot.create(:post_tag) }

  it "must have required fields or be invalid" do
    expect(PostTag.new).to_not be_valid
  end

  it "creates a new post_tag relationship with valid attributes" do
    expect {
      FactoryBot.build(:post_tag).save
    }.to change(PostTag, :count).by(1)
  end

  context "unique records" do
    it "must be unique" do
      valid_post_tag

      expect {
        PostTag.create(
          FactoryBot.attributes_for(
            :post_tag,
            post: valid_post_tag.post,
            tag: valid_post_tag.tag
          )
        )
      }.to_not change(PostTag, :count)
    end
  end

  context "post_id" do
    it "must be present" do
      expect {
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
      expect {
        PostTag.create(FactoryBot.attributes_for(:post_tag, tag_id: nil))
      }.to_not change(PostTag, :count)
    end

    it "must produce an error if no title is given" do
      pt = PostTag.new
      expect(pt.errors[:tag_id]).to_not be_nil
    end
  end
end
