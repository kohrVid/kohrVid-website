class Contact < MailForm::Base
  VALID_EMAIL_REGEX = /\A[^\.]+[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  attribute :name
  attribute :email
  attribute :message 
  attribute :nickname,   captcha: true
  
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email,  presence: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 255 }
  validates :message,   presence: true

  def headers
    {
      subject: "kohrVid Contact Form",
      to: ENV['GMAIL_USERNAME'],
      from: %("#{name}" <#{email}>)
    }
  end
end
