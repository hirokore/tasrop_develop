class AddRoleToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :role, :integer
  end
  def down 
    remove_columns :users, :role
  end
end
