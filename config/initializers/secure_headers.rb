::SecureHeaders::Configuration.configure do |config|
  config.hsts = "max-age=631152000; includeSubdomains"
  config.x_frame_options = 'DENY'
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = 'noopen'
  config.x_permitted_cross_domain_policies = 'none'
  config.csp = {
    :default_src => ["https: 'self'"],
    :style_src => ["'self'", "'unsafe-inline'"],
    :script_src => ["'self'", "http://kohrvid.com", "http://www.kohrvid.com"],
    :img_src => ["'self'", "http://kohrvid.com", "http://www.kohrvid.com"],
    :report_uri => ['/csp_reports'],
    :form_action => ["'self' github.com"],
  }
end
