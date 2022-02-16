source 'https://rubygems.org'

ruby '> 3.0.1'
gem 'activerecord-session_store'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
#gem 'brakeman', '~> 3.1', '>= 3.1.2'
gem 'carrierwave', '~> 2.0'
gem 'closure_tree'
gem 'coderay'
gem 'coffee-rails'
gem 'dartsass-rails'
#gem 'dawnscanner', '>= 1.4.2' #run 'dawn -r ./' to use
gem 'devise'
gem 'fog-google', '>= 1.9.1'
gem 'friendly_id', '~> 5.2.4', require: 'friendly_id'
gem 'haml'
gem 'image_processing', '~> 1.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'mail_form'
gem 'mime-types'
gem 'mini_magick'
gem 'pg', '~> 1.2.3'
gem 'puma', '~> 4.3'
gem 'rack-attack', '~> 6.2.2'
gem 'rack-ssl-enforcer'
gem 'rails', '>= 6.0.3.7'
gem 'railties'
gem 'recaptcha'
gem 'remotipart' #Allows for asynchronous file uploads in CarrierWave
gem 'redcarpet'
gem 'sassc-rails'
gem 'turbolinks', '~> 5'
gem 'uglifier'
gem 'webpacker', '~> 4.x'
gem 'will_paginate', '~> 3.2.1'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


group :development, :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_bot_rails', require: false
  gem 'faker'
  gem 'figaro'
  gem 'guard-rspec'
  gem 'guard-shell'
  gem 'launchy'
  gem 'pry-byebug', platform: :mri
  gem 'rails-controller-testing'
  gem 'rspec-html-matchers', '0.7.0'
  gem 'rspec-rails', '~> 4.0.0.beta2'
  gem 'rubocop'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'timecop'
  gem 'webdrivers'
end

group :development do
  gem 'web-console', '~> 3.0'
#  gem 'spring'
end

group :production do
  gem 'dotenv'
  gem "google-cloud-storage", "~> 1.11", require: false
end

