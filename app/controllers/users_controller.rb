class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :init_user, only: [:show, :edit, :update]

  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def show
    @activities_feed = @user.activities.recent.paginate page: params[:page]
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "stactic.welcome"
      redirect_to @user
    else
      render "new"
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "edit_user.profile_update"
      redirect_to @user
    else
      render "edit"
    end
  end

  private
  def init_user
    @user = User.find params[:id]
  end 

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :avatar
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "edit_user.log_in"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless current_user? @user
  end
end
