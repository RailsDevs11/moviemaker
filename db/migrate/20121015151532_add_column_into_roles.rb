class AddColumnIntoRoles < ActiveRecord::Migration
  def up
  	add_column :roles, :is_admin, :boolean, :default => false
  end

  def down
  	remove_column :roles, :is_admin
  end
end
