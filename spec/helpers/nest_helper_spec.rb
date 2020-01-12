require "rails_helper"

RSpec.describe NestHelper, type: :helper do
  describe "#meta_keywords" do
    subject { meta_keywords }

    it "returns the correct string on a normal page" do
      is_expected.to eq(
        "kohrVid,Jessica,Ete,Developer,Rubyist,Scala,Go"
      )
    end

    context "blog posts" do
      before do
        @post = FactoryBot.create(:post)
      end

      it "returns the correct string with blog post tags included" do
        allow_any_instance_of(Post).to receive(:tag_names)
          .and_return(["cats","magic"])

        is_expected.to eq(
          "kohrVid,Jessica,Ete,Developer,Rubyist,Scala,Go,cats,magic"
        )
      end

      it "returns a string of unique items" do
        allow_any_instance_of(Post).to receive(:tag_names)
          .and_return(["scala","ruby","go"])

        is_expected.to eq("kohrVid,Jessica,Ete,Developer,Rubyist,Scala,Go,ruby")
      end
    end

    context "list_current_errors" do
      it "should return an empty list if there is no model" do
        expect(list_current_errors).to be_empty
      end

      it "should return an empty list if there are no errors" do
        @tag = FactoryBot.build(:tag)
        @tag.errors

        expect(list_current_errors).to be_empty
      end

      it "should list errors if a model with errors ispresent" do
        @tag = Tag.new
        @tag.save

        expect(list_current_errors).to include "Name can't be blank"
      end
    end
  end
end
