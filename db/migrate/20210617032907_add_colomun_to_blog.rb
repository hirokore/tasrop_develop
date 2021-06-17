class AddColomunToBlog < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :private, :boolean, default: false
  end
end
