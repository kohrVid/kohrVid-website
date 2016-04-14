# Preview all emails at http://localhost:3000/rails/mailers/notification
class NotificationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification/new_comment_notification
  def new_comment_notification
    Notification.new_comment_notification
  end

end
