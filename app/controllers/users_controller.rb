class UsersController < ApplicationController
  prepend_before_action :require_no_authentication, only: [:cancel ]
  before_action :redirect_to_login, except: [:new, :create]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.order(:id).paginate(page: params[:page])
  end

  def show
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
  end

  def update
    if @user.update(user_params)
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
    if current_user_or_admin?(@user)
      @user.destroy
      flash[:success] = "User deleted."
      redirect_to users_url
    else
      flash[:error] = "Sorry, you do not have access to that part of the site."
      render :show, status: :forbidden
    end
  end


  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :bio
    )
  end

  def correct_user
    find_user
    unless current_user.admin? || current_user?(@user)
      flash[:error] = "Sorry, you do not have access to that part of the site."
      redirect_to root_url
    end
  end
end
