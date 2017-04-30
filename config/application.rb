require File.expand_path('../boot', __FILE__)

require 'rails/all'
require "action_mailer/railtie"

Bundler.require(*Rails.groups)

module KohrVid
  class Application < Rails::Application
    config.action_controller.perform_caching = true
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.active_record.raise_in_transactional_callbacks = true
    config.assets.enabled = true
    config.assets.initialized_on_precompile = true
    config.assets.paths << Rails.root.join('node_modules')
    config.middleware.use Rack::Attack
    config.middleware.use Rack::Deflater
    config.public_file_server.headers = { 'Cache-Control' => 'public, max-age=31536000' }
    config.time_zone = 'London'
  end
end
