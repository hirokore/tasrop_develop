class CustomsController < ApplicationController
  before_action :set_custom, only: [ :edit, :update, :destroy ]
  def new
    @custom = Custom.new
    @tasks = Task.where(user_id: current_user.id)
  end
  
  def create
    @custom = Custom.new(custom_params)
    @custom.user_id = current_user.id
    if @custom.save
      redirect_to customs_path, notice: "登録完了"
    else
      render :new
    end

  end

  def index
    @customs = Custom.where(user_id: current_user.id).includes(:user)
    @tags = Tag.where(user_id: current_user.id).includes(:user)
    @tasks = Task.where(user_id: current_user.id).includes(:user)
  end

  def show
    @custom = Custom.find_by(user_id: params[:id])
    @customs = Custom.all
  end

  def edit
    @tasks = Task.where(user_id: current_user.id)
  end

  def destroy
    @custom.destroy
    redirect_to customs_path, notice: "削除完了"
  end

  def update
    if @custom.update(custom_params)
      redirect_to customs_path, notice: "編集完了"
    else
      render :new
    end
  end

  private

  def custom_params
    params.require(:custom).permit(:title, :displayed, :use_comment, :use_picture, :mentor, task_ids: [])
  end

  def set_custom
    @custom = Custom.find(params[:id])
  end

end
