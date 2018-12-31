require "rails_helper"

RSpec.describe Notification, type: :mailer do
  describe "new_comment_admin_notification" do
    let(:comment) { FactoryBot.create(:comment) }
    let(:mail) { Notification.new_comment_admin_notification(comment) }

    it "renders the headers" do
      expect(mail.subject).to eq(
        "New comment posted under '#{comment.post.title}'"
      )

      expect(mail.to).to eq([ENV['GMAIL_USERNAME']])
      expect(mail.from).to eq(['noreply@kohrVid.com'])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include(
        "New comment posted on the kohrVid blog"
      )

      expect(mail.body.encoded).to include(
        "A new comment has been posted on the blog. View the comment"
      )

      expect(mail.body.encoded).to include("blog/posts/#{comment.post.slug}\">")
    end
  end
end
