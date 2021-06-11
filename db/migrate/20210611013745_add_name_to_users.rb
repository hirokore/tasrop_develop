class AddNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :last_target, :text
    add_column :users, :notice, :boolean, null: false, default: false
    add_column :users, :notice_time, :time, default: "20:00"
    add_column :users, :name_tag, :integer, null: false
    add_column :users, :picture, :string
  end
end
