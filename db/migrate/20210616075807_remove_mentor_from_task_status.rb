class RemoveMentorFromTaskStatus < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :task_statuses, :mentors
    remove_reference :task_statuses, :mentor, index: true
  end
end
