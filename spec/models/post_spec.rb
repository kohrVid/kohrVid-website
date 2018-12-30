require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.create(:post) }

  it "must have required fields or be invalid" do
    expect(Post.new).to_not be_valid
  end

  it "creates a new post with valid attributes" do
    expect {
      Post.create(FactoryBot.attributes_for(:post))
    }.to change(Post, :count).by(1)
  end

  context "#title" do
    it "must be present" do
      expect {
        Post.create(FactoryBot.attributes_for(:post, title: ""))
      }.to_not change(Post, :count)
    end

    it "must produce an error if no title is given" do
      p = Post.new
      expect(p.errors[:title]).to_not be_nil
    end

    it "must be no more than 50 characters long" do
      expect {
        Post.create(FactoryBot.attributes_for(:post, title: "m"*51))
      }.to_not change(Post, :count)
    end

    it "must be unique" do
      post
      expect {
        Post.create(FactoryBot.attributes_for(
          :post, title: post.title, body: "New Body"
        ))
      }.to_not change(Post, :count)
    end
  end

  context "#body" do
    it "must be present" do
      expect {
        Post.create(FactoryBot.attributes_for(:post, body: ""))
      }.to_not change(Post, :count)
    end

    it "must produce an error if no email is given" do
      p = Post.new
      expect(p.errors[:body]).to_not be_nil
    end

    it "must be at least 4 characters long" do
      expect {
        Post.create(FactoryBot.attributes_for(:post, body: "m"*3))
      }.to_not change(Post, :count)
    end

    it "must be no more than 20000 characters long" do
      expect {
        Post.create(FactoryBot.attributes_for(:post, body: "m"*20001))
      }.to_not change(Post, :count)
    end

    it "must be unique" do
      post
      expect {
        Post.create(FactoryBot.attributes_for(
          :post, title: "New Title", body: post.body
        ))
      }.to_not change(Post, :count)
    end
  end

  describe 'scopes' do
    let(:post1) { FactoryBot.create(:post, draft: true) }
    let(:post2) { FactoryBot.create(:post) }
    let(:post3) { FactoryBot.create(:post, draft: true) }
    let(:post4) { FactoryBot.create(:post) }

    before do
      post1
      post2
      post3
      post4
    end

    context ".draft" do
      subject { Post.drafts }

      it 'should contain all draft posts' do
        is_expected.to include(post1)
        is_expected.to include(post3)
      end

      it 'should not contain any public posts' do
        is_expected.to_not include(post2)
        is_expected.to_not include(post4)
      end
    end

    context ".published" do
      subject { Post.published }

      it 'should contain all published posts' do
        is_expected.to include(post2)
        is_expected.to include(post4)
      end

      it 'should not contain any draft posts' do
        is_expected.to_not include(post1)
        is_expected.to_not include(post3)
      end
    end
  end

  context "Tags" do
    let(:tag1) { FactoryBot.create(:tag) }
    let(:tag2) { FactoryBot.create(:tag, name: "Cats") }

    let(:post_tag1) do
      FactoryBot.build(:post_tag, post_id: post.id, tag_id: tag1.id)
    end

    let(:post_tag2) do
      FactoryBot.build(:post_tag, post_id: post.id, tag_id: tag2.id)
    end

    it "can have tags" do
      expect(Post.new).to respond_to(:tags)
    end

    it "can have many tags" do
      expect(post_tag1).to be_valid
      expect(post_tag2).to be_valid
    end

=begin
    it "must have at least one tag" do
            p = Post.new
            expect(p).to_not be_valid
            expect(p.errors[:tags]).to be_present
    end
=end
  end
end
