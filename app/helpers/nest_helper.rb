module NestHelper
	def admin_is_logged_in
		@admin_is_logged_in = current_user && current_user.admin?
	end

	def current_user?(user)
		user == current_user
	end

	def store_location
		session[:forwarding_url] = request.url if request.get?
	end

	#Devise Helpers
	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end
end
