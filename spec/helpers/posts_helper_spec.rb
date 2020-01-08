require 'rails_helper'

RSpec.describe PostsHelper, type: :helper do
  let(:html_content) { "<div>#{Faker::Lorem.sentence}</div>" }
  let(:content) { ActionText::Content.new(html_content) }
  let(:rich_text_body) { ActionText::RichText.new(body: content) }

  context "truncate_body" do
    it "should not attempt to truncate a rich text body if it is null" do
      subject = truncate_body(nil)
      expect(subject).to eq nil
    end

    it "should truncate rich text based on the length attribute" do
      subject = truncate_body(rich_text_body, 10)

      expect(strip_doctype_tags(subject).split("...").first.length).to eq 10
    end

    context "unclosed tags" do
      let(:html_content) { "<b>memwew</b>" }

      it "should close any open html tags by default" do
        subject = truncate_body(rich_text_body, 6)

        expect(strip_doctype_tags(subject)).to_not eq "<b>mem..."
        expect(strip_doctype_tags(subject)).to eq "<b>mem...</b>"
      end
    end
  end

  private

  def strip_doctype_tags(truncated_body)
    truncated_body
      .gsub(
        "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\" \"http://www.w3.org/TR/REC-html40/loose.dtd\">\n<html><body>",
        ""
      )
      .gsub("</body></html>", "")
  end
end
