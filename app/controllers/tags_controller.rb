class TagsController < ApplicationController
  before_action :set_task, only: [ :edit, :update, :destroy ]

  def edit
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.user_id = current_user.id
    if @tag.save
      redirect_to customs_path, notice: "登録完了"
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @tag.update(tag_params)
      redirect_to customs_path, notice: "編集完了"
    else
      render :new
    end
  end
  
  def destroy
    @tag.destroy
    redirect_to customs_path, notice: "削除完了"
  end

  private
  
  def tag_params
    params.require(:tag).permit(:name, :total_time)
  end
  
  def set_task
    @tag = Tag.find(params[:id])
  end

end
