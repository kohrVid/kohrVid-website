class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_sign_up_params, if: :devise_controller?
  before_action :configure_account_update_params, if: :devise_controller?

  #include Devise::Controllers::Helpers
  include CommentsHelper
  include NestHelper
  private
  #def after_sign_in_path_for(resource_or_scope)
    #scope = Devise::Mapping.find_scope!(resource_or_scope)
    #home_path = :"#{scope}_root_path"
    ##respond_to?(admin_home_path) ? send(admin_home_path) : admin_home_path
  #end

  def configure_sign_up_params
    permitted_params(:sign_up)
  end

  def configure_account_update_params
    permitted_params(:account_update)
  end

  def permitted_params(action)
    devise_parameter_sanitizer.permit(
      action,
      keys: [
        :name,
        :email,
        :password,
        :password_confirmation,
        :bio
      ]
    )
  end
end
