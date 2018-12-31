class Notification < ApplicationMailer
  def new_comment_admin_notification(comment)
    @comment = comment
    mail from: "noreply@kohrVid.com"
    mail to: ENV['GMAIL_USERNAME'],
      subject: "New comment posted under '#{Post.find(@comment.post_id).title }'"
  end
end
