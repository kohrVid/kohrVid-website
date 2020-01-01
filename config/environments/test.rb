Rails.application.configure do

  # Show full error reports and disable caching.
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  config.action_mailer.default_url_options = {
    host: 'localhost:3000'
  }

  # Randomize the order test cases are executed.
  config.active_support.test_order = :random

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  config.cache_classes = true
  config.consider_all_requests_local       = true
  config.eager_load = false
  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  config.public_file_server.enabled = true
  config.public_file_server.headers = { 'Cache-Control' => 'public, max-age=31536000' }
end
