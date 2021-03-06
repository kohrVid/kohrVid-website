Rails.application.config.content_security_policy do |p|
  p.default_src :self, :https, "http://localhost:3000"
  p.font_src    :self, :https, :data

  p.img_src     :self, :https, :data, :blob, "http://kohrvid.com",
    "http://www.kohrvid.com",
    "http://kohrvid-website-static.storage.googleapis.com"

  p.object_src  :none

  p.script_src  :self, :https, "http://kohrvid.com", "http://www.kohrvid.com",
    "http://localhost:3000"

  p.connect_src :self, :https, "http://localhost:3035",
    "ws://localhost:3035" if Rails.env.development?

  p.style_src   :self, :https, :unsafe_inline

  # Specify URI for violation reports
  p.report_uri  "/csp_reports"
end
