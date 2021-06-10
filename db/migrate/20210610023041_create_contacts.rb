class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.text :email, null: false
      t.text :content, null: false
      t.string :title

      t.timestamps
    end
  end
end
