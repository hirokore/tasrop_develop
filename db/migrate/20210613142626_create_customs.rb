class CreateCustoms < ActiveRecord::Migration[5.2]
  def change
    create_table :customs do |t|
      t.references :user, foreign_key: true
      t.string :title, null: false
      t.boolean :displayed, null: false, default: true
      t.boolean :use_comment, null: false, default: false
      t.boolean :use_picture, null: false, default: false
      t.string :mentor

      t.timestamps
    end
  end
end
