module NestHelper
	def admin_is_logged_in
		@admin_is_logged_in = current_user && current_user.admin?
	end

	def current_user?(user)
		user == current_user
	end
	
	def redirect_to_login
		unless user_signed_in?
			flash[:error] = "Please log in"
			redirect_to(new_user_session_url)
		end
	end

	def admin_user_404
		unless current_user && current_user.admin?
			raise ActionController::RoutingError.new('Not Found')
			#render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
		end
	end
=begin
	def store_location
		session[:forwarding_url] = request.url if request.get?
	end
=end

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
