source "https://rubygems.org"


gem "rails", "4.2.5.rc2"
gem "pg"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
gem "capistrano", "~> 2.1"
gem "passenger"
gem "rubber"
gem "therubyracer", platforms: :ruby
gem "jquery-rails"
gem "turbolinks"
gem "jbuilder", "~> 2.0"

gem "sdoc", "~> 0.4.0", group: :doc

gem "bcrypt", "~> 3.1.7"


gem "mail_form" #, "~> 1.5"
gem "carrierwave", "0.10.0"
gem "remotipart" #Allows for asynchronous file uploads in CarrierWave
gem "mini_magick", "~> 3.8.0"
gem "fog", "~> 1.34.0"
gem "will_paginate", "~> 3.0.7"
gem "fancybox2-rails"
gem "devise"
gem "friendly_id", "~> 5.1", :require => "friendly_id"
gem "jquery-ui-rails"
gem "redcarpet"
gem "coderay"
gem "closure_tree"

gem "rspec-rails"
gem "factory_girl_rails", "~> 4.0"
gem "rack-attack", "~> 4.3"
gem "brakeman", "~> 3.1", ">= 3.1.2"
gem "secure_headers", "~> 2.4", ">= 2.4.3"
gem "dawnscanner", ">= 1.4.2" #run "dawn -r ./" to use 
gem "figaro", "0.7.0"
gem "activerecord-session_store"  

group :development, :test do
  gem "byebug"
  gem "guard-rspec"
  gem "rspec-html-matchers", "0.7.0"
  gem "capybara"
  gem "timecop"
  gem "database_cleaner"
  gem "simplecov", :require => false, :group => :test
end

group :development do
  gem "web-console", "~> 2.0"
#  gem "spring"
end

group :production do
  gem "dotenv"
  gem "puma", "~> 2.11.1"
  gem "aws-sdk"
end

