class UsersController < ApplicationController
  before_action :set_user, only: %i[ show follow followed ]
  before_action :move_to_signed_in
  
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    role_change!(@user,params[:role])
    redirect_to users_path, notice: "権限変更完了"
  end
  

  def show
  end

  def follow
  end

  def followed
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :role, :image, :name, :name_tag, :last_target, :notice, :notice_time)
    end
end
