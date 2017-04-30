source "https://rubygems.org"


#gem "rails", "4.2.5.rc2"
gem 'bcrypt', '~> 3.1.7'
gem "coffee-rails", "~> 4.1.0" #TODO
gem 'haml'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'sass', '~>3.2.19'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem "mail_form" #, "~> 1.5"
gem "carrierwave", "0.10.0"
gem "remotipart" #Allows for asynchronous file uploads in CarrierWave
gem "mini_magick", "~> 3.8.0"
#gem "fog", "~> 1.34.0"
gem "will_paginate", "~> 3.0.7"
gem "fancybox2-rails"
gem "devise"
gem "friendly_id", "~> 5.1", :require => "friendly_id"
gem "redcarpet"
gem "coderay"
gem "closure_tree"

gem "rack-attack", "~> 4.3"
#gem "brakeman", "~> 3.1", ">= 3.1.2"
gem "secure_headers", "~> 2.4", ">= 2.4.3"
#gem "dawnscanner", ">= 1.4.2" #run "dawn -r ./" to use 
gem "activerecord-session_store"  

group :development, :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'figaro'
  gem 'jasmine'
  gem 'launchy'
  gem 'pry-byebug', platform: :mri
  gem 'rails-controller-testing'
  gem "rspec-html-matchers", "0.7.0"
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'simplecov'
  gem "timecop"
end

group :development do
  gem "web-console", "~> 2.0"
#  gem "spring"
end

group :production do
  gem "aws-sdk"
  gem "dotenv"
  gem 'heroku-deflater'
  gem 'ngannotate-rails'
  gem 'rails_12factor'
end

