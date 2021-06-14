class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.float :total_time, null: false, default: 0

      t.timestamps
    end
  end
end
