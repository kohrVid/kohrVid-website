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
  end
end
