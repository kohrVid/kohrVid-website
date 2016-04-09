class UsersController < ApplicationController
	prepend_before_filter :require_no_authentication, only: [:cancel ]
	before_action :redirect_to_login, except: [:new, :create]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_is_logged_in, only: :destroy

	def index
		@users = User.order(:id).paginate(page: params[:page])
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
			flash[:success] = "User was created successfully."
			redirect_to user_path(@user)
		else
			flash.now[:error] = "An error has prevented this account from being saved."
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated."
			redirect_to @user
		else
			flash.now[:error] = "Unable to update profile."
			render :edit
		end
	end

	
	def admin_new
		@user = User.new
	end

	def admin_create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "User was created successfully."
			redirect_to user_path(@user)
		else
			flash.now[:error] = "An error has prevented this account from being saved."
			render :new
		end
	end




	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted."
		redirect_to users_url
	end


	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio)
		end

		def correct_user
			unless current_user.admin? || current_user?(@user)
				flash[:error] = "Sorry, you do not have access to that part of the site."
				redirect_to root_url
			end
		end
end
