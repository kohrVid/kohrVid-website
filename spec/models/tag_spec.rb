require 'rails_helper'

RSpec.describe Tag, type: :model do
  let(:object) { FactoryBot.create(:post, tag_list: "ruby, scala") }

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

  context "tag relationships" do
    let(:tag_relationships) do
      Tag.add_tag_relationships(object, ["ruby", "scala", "go"])
    end

    context ".add_tag_relationships" do
      it "should add any new tags" do
        tag_relationships

        [ "ruby", "scala", "go" ].each do |tag_name|
          expect(
            Tag.where(name: tag_name).to_a
          ).to_not be_empty 
        end
      end

      it "should add new rows in the relevant through table" do
        tag_relationships.map(&:tag_id).each do |tag_id|
          expect(
            PostTag.where(post_id: object.id, tag_id: tag_id).to_a
          ).to_not be_empty
        end
      end
    end

    context ".remove_old_tag_relationships" do
      let(:tags) { Tag.where("name in (?)", ["ruby", "scala"]) }
      let(:current_tag_relationships) do
        Tag.add_tag_relationships(object, ["ruby", "scala"])
      end

      before(:each) do
        tag_relationships
        Tag.remove_old_tag_relationships(object, current_tag_relationships)
      end

      it "should delete any old relationships" do
        tag_id = Tag.where(name: "go").first.id
    
        expect(
          PostTag.where(post_id: object.id, tag_id: tag_id).to_a
        ).to be_empty
      end

      it "should not delete current relationships" do
        tags.map(&:id).each do |tag_id|
          expect(
            PostTag.where(post_id: object.id, tag_id: tag_id).to_a
          ).to_not be_empty
        end
      end
    end

    context "tag_relationship" do
      before(:each) do
        tag_relationships
      end

      it "should not create duplicate relationships" do
        Tag.tag_relationship(object)
        current_tag_ids = Tag.where("name in (?)", ["ruby", "scala"]).map(&:id)

        current_tag_ids.each do |tag_id|
          expect(
            PostTag.where(post_id: object.id, tag_id: tag_id).count
          ).to eq 1
        end
      end
    end

    context ".handle_through_table" do
      it "should return the right class name for the through table" do
        expect(Tag.handle_through_table(Post).first).to eq(PostTag)
      end

      it "should return the right column name for the through table" do
        expect(Tag.handle_through_table(Post).second).to eq("post_id")
      end
    end

    context ".clean_tag_names_list" do
      it "should only return lower case tag names" do
        ["ruby", "go", "scala"].each do |tag_name|
          expect(
            Tag.clean_tag_names_list("RUBY, gO, Scala")
          ).to include(tag_name)
        end
      end

      it "should not return blank tags" do
        tags = Tag.clean_tag_names_list(" , RUBY,,")
        expect(tags.count).to eq 1
        expect(tags).to include("ruby")
      end
    end
  end

end
