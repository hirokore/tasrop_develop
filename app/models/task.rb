class Task < ApplicationRecord
  belongs_to :user
  belongs_to :custom
  # タスクステータス
  has_many :task_statuses
end
