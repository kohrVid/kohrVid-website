class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :configure_permitted_parameters, if: :devise_controller?

  #include Devise::Controllers::Helpers
  include CommentsHelper
  include NestHelper
  #include PostsHelper
  private
    #def after_sign_in_path_for(resource_or_scope)
      #scope = Devise::Mapping.find_scope!(resource_or_scope)
      #home_path = :"#{scope}_root_path"
      ##respond_to?(admin_home_path) ? send(admin_home_path) : admin_home_path
    #end

          #def configure_permitted_parameters
                  #devise_parameter_sanitizer.for(:account_update) { |u| 
                          #u.permit(:name, :email, :password, :password_confirmation, :current_password, :bio) 
                  #}
                  #devise_parameter_sanitizer.for(:sign_up) { |u| 
                          #u.permit(:name, :email, :password, :password_confirmation, :current_password, :bio) 
                  #}
          #end
end
