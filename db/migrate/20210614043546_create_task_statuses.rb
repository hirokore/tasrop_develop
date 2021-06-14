class CreateTaskStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :task_statuses do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true
      t.boolean :task_status, null: false, default: false
      t.datetime :implementation_at, null: false, default: -> { "now()" }
      t.integer :permit, null: false, default: 0
      t.references :mentor, foreign_key: true
      t.boolean :use_picture, null: false, default: false
      t.string :picture
      t.boolean :use_comment, null: false, default: false
      t.string :comment

      t.timestamps
    end
  end
end
