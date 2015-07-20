class Admin::UsersController < ApplicationController
  before_action :init_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.paginate page:params[:id], per_page: Settings.paginate_per_page
  end

  def update
    @user.update_attributes user_params
    flash[:success] = t "set_admin_message"
    redirect_to admin_users_path
  end

  def destroy
    @user.destroy
    flash[:success] = t "destroy_message"
    redirect_to admin_users_path	
  end

  private
  def init_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :admin
  end
end
