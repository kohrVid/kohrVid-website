require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
require 'rack/ssl-enforcer'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups) if defined?(Bundler)

module KohrVid
  class Application < Rails::Application
    config.action_controller.perform_caching = true
    config.action_view.embed_authenticity_token_in_remote_forms = true
    #config.active_record.raise_in_transactional_callbacks = true
    config.assets.enabled = true
    #config.assets.paths << Rails.root.join('node_modules')
    config.generators.system_tests = nil
    config.load_defaults 6.0
    config.middleware.insert_before ActionDispatch::Cookies, Rack::SslEnforcer,
      only_environments: 'production'
    config.middleware.use Rack::Attack
    config.middleware.use Rack::Deflater
    config.public_file_server.enabled = true
    config.public_file_server.headers = { 'Cache-Control' => 'public, max-age=31536000' }
    config.time_zone = 'London'
  end
end
