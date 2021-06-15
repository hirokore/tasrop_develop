class CustomsController < ApplicationController
  def new
    @custom = Custom.new
  end
  
  def create
    @custom = current_user.custom.new(task_params)
    
  end

  def index
    @customs = Custom.all
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
