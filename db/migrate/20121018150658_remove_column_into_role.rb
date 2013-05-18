class RemoveColumnIntoRole < ActiveRecord::Migration
  def up
  	remove_column :roles, :is_admin
  	add_column :cini_roles, :is_admin, :boolean, :default => false
  end

  def down
  	add_column :roles, :is_admin, :boolean, :default => false
  	remove_column :cini_roles, :is_admin
  end
end
