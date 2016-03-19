class UsersController < ApplicationController
	before_action :redirect_to_login, except: [:new, :create]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_is_logged_in, only: :destroy

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		@user = User.find(params[:id])
	end
	
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			@user.send_activation_email
			flash[:notice] = "Please check your email to activate your account"
			redirect_to root_url
		else
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			flash.now[:error] = "Unable to update profile"
			render :edit
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted"
		redirect_to users_url
	end


	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio)
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user.admin?
		end
		
		def redirect_to_login
			if !user_signed_in?
				flash[:error] = "Please log in"
				redirect_to(new_user_session_url)
			end
		end
end
