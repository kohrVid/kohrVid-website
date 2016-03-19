class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	ensure_security_headers
	before_action :configure_permitted_parameters, if: :devise_controller?

  include NestHelper

  	def authenticate
	        authenticate_or_request_with_http_basic do |username, password|
			username == ENV['GMAIL_USERNAME'] && password == ENV['GMAIL_PASSWORD']
		end
	end


	private

		def logged_in_user
			unless logged_in?
				store_location
				flash[:error] = "Please log in."
				redirect_to login_url
			end
		end
	   
		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:account_update) { |u| 
				u.permit(:password, :password_confirmation, :current_password) 
			}
		end
end
