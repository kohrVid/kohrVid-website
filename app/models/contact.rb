class Contact < MailForm::Base
	VALID_EMAIL_REGEX = /\A[^\.]+[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	attribute :name, 	:validate => true,
				:length   => {maximum:50}
	attribute :email, 	:validate => VALID_EMAIL_REGEX,
				:length   => {maximum:255}
	attribute :message
	attribute :nickname, 	:captcha  => true

=begin
	validates :name, 	presence: true,
				length: {maximum: 50}
	validates :email,	presence: true,
				length: {maximum: 255},
				format: {with: VALID_EMAIL_REGEX}
	validates :message, 	presence: true
	validates :nickname,	length: {minimum: 0}
=end
	def headers
		{
			:subject => "kohrVid Contact Form",
			:to => "kohrVid@gmail.com",
			:from => %("#{name}" <#{email}>)

		}
	end
	
end
