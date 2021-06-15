class CustomsController < ApplicationController
  def new
    @custom = Custom.new
  end
  
  def create
    @custom = current_user.custom.new(task_params)
    
  end

  def index
    @customs = Custom.where(user_id: current_user.id).includes(:user)
    @tags = Tag.where(user_id: current_user.id).includes(:user)
    @tasks = Task.where(user_id: current_user.id).includes(:user)
  end

  def show
  end

  def edit
  end

  private

  def task_params
    params.require(:task).permit(:title, :displayed, :use_comment, :use_picture, :mentor)
  end

end
