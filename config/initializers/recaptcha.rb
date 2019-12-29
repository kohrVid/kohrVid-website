Recaptcha.configuration do |config|
  config.site_key  = ENV['RECAPTCHA_SITE_KEY']
  config.secret_key = ENV['RECAPTCHA_SECRET_KEY']
  config.verify_url = ENV['RECAPTCHA_VERIFY_URL']
end
