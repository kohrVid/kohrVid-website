class Notification < ApplicationMailer
	def new_comment_notification(comment)
		@comment = comment
		mail from: "noreply@kohrVid.com"
		mail to: "kohrVid@gmail.com", subject: "New comment posted under '#{Post.find(@comment.post_id).title }'"
  end
end
