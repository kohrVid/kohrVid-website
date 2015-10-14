class Contact < MailForm::Base
	VALID_EMAIL_REGEX = /\A[^\.]+[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	attribute :name, 	:validate => true,
				:length   => {maximum:50}
	attribute :email, 	:validate => VALID_EMAIL_REGEX,
				:length   => {maximum:255}
	attribute :message, 	:validate => true
	attribute :nickname, 	:captcha  => true

	def headers
		{
			:subject => "kohrVid Contact Form",
			:to => "kohrVid@gmail.com",
			:from => %("#{name}" <#{email}>)

		}
	end
	
end
