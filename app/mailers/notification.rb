class Notification < ApplicationMailer
  def new_comment_admin_notification(comment)
    @new_comment = comment
    mail from: "noreply@kohrVid.com"

    mail to: ENV['GMAIL_USERNAME'],
      subject: "New comment posted under '#{@new_comment.post.title }'"
  end
end
