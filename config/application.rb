require File.expand_path('../boot', __FILE__)

require 'rails/all'
require "action_mailer/railtie"

Bundler.require(*Rails.groups)

module KohrVid
  class Application < Rails::Application
     config.time_zone = 'London'

    config.active_record.raise_in_transactional_callbacks = true
    config.assets.enabled = true
    config.assets.initialized_on_precompile = true
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.middleware.use Rack::Attack
    config.action_controller.perform_caching = true 
  end
end
