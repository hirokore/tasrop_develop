class Mentor < ApplicationRecord
  belongs_to :user
  # タスクステータス
  has_many :task_statuses, dependent: :destroy
end
