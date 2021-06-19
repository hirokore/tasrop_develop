class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]
  before_action :irregul_operation, only: [ :show, :edit, :update, :destroy ]
  before_action :move_to_signed_in
  
  def new
    @task = Task.new
    @tags = Tag.where(user_id: current_user.id)
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    @task.custom_id = 1
    if @task.save
      redirect_to customs_path, notice: "登録完了"
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to customs_path, notice: "編集完了"
    else
      render :new
    end
  end

  def index
    @tasks = Task.where(user_id: current_user.id).includes(:user)
  end

  def show
  end

  def edit
    @tags = Tag.where(user_id: current_user.id)
  end

  # リファクタリング必至
  def destroy
    @task.displayed = false
    @task.custom_id = 1
    # 当日分の
    if TaskStatus.where(created_at: Time.zone.now.all_day).find_by(task_id: @task.id).present?
      @status = TaskStatus.where(created_at: Time.zone.now.all_day).find_by(task_id: @task.id)
      @status.task_status = !@status.task_status
      @status.save
    end
    @custom = Custom.find(@task.custom_id)
    new_task_ids = []
    @custom.task_ids.each do |task_id|
      if task_id != @task.id
        new_task_ids << task_id
      end
    end
    @custom.task_ids = new_task_ids
    @task.save
    redirect_to customs_path, notice: "削除完了"
  end

  private

  def task_params
    params.require(:task).permit(:name, :detail, :task_time, :displayed, tag_ids: [])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def irregul_operation
    redirect_to customs_path, notice: "不正操作を記録しました。" unless current_user.id == @task.user.id
  end
  
end
