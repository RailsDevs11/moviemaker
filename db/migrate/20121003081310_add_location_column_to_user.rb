class AddLocationColumnToUser < ActiveRecord::Migration
  def up
    add_column :users, :primary_location, :string
    add_column :users, :secondary_location, :string
  end
 
  def down
    remove_column :users, :primary_location
    remove_column :users, :secondary_location
  end
end
