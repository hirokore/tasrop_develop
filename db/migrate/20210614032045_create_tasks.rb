class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :user, foreign_key: true
      t.references :custom, foreign_key: true
      t.string :name, null: false
      t.text :detail
      t.float :task_time
      t.boolean :displayed, null: false, default: true

      t.timestamps
    end
  end
end
