class TaskStatus < ApplicationRecord
  belongs_to :user
  belongs_to :task
  belongs_to :mentor
end
