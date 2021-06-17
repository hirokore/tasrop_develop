class Custom < ApplicationRecord
  belongs_to :user
  
  # タスクとの連携
  has_many :tasks
  accepts_nested_attributes_for :tasks, reject_if: :all_blank, allow_destroy: true
  # メンターとの連携
  # belongs_to :mentor

  def self.task_status_create(custom,task_id)
    task = Task.find(task_id)
    user_id = custom.user_id
    use_picture = custom.use_picture
    use_comment = custom.use_comment
    # mentor_id = custom.mentor_id #これも追加すること「mentor_id: mentor_id」
    TaskStatus.create!(user_id: user_id, task_id: task_id, use_picture: use_picture, use_comment: use_comment)
  end
  
  # TaskStatus.update!(user_id: user_id, task_id: task_id, task_status)
  def self.task_status_update(custom, task_id, status)
    task = Task.find(task_id)
    task_status = status
    use_picture = custom.use_picture
    # picture = syori
    use_comment = custom.use_comment
    # comment = shori
    # permit = syori #これも追加すること 「permit: permit」
    # mentor = custom.mentor_id #これも追加すること「mentor_id: mentor」
    TaskStatus.update!(task_status: task_status, task_id: task_id, use_picture: use_picture, use_comment: use_comment, picture: picture, comment: comment)
  end

  # 作り忘れた過去分を設定する機能（未実装）
  def self.task_status_create_old(custom,task_id)
    task = Task.find(task_id)
    user_id = task_id.user_id
    task_id = task_id.id
    implementation_at = DateTime.now #ここをいい感じに変えれば過去分もかけるかなーって感じ
    # mentor_id = custom.mentor_id #これも追加すること「mentor_id: mentor_id」
    TaskStatus.create!(user_id: user_id, task_id: task_id, use_picture: use_picture, use_comment: use_comment, implementation_at: implementation_at )
  end

  # 選択されたマイタスクを削除する際に、関連付けが残っているタスクのidをデフォルトに変更する
  def self.custom_release(custom)
    custom.task_ids.each do |task_id|
      task = Task.find(task_id)
      task.update!(custom_id: 1)
    end
  end
  
  def self.daily_create(user_id)
    customs = Custom.where(user_id: user_id)
    customs.each do |custom|
      custom.task_ids.each do |task_id|
        task_status_create(custom,task_id)
      end
    end
  end
  
end

# !つけると例外が発生する、なんか困ったら外すか