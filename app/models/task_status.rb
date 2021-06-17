class TaskStatus < ApplicationRecord
  # 写真利用機能
  mount_uploader :picture, ImageUploader
  
  belongs_to :user
  belongs_to :task
end
