class ChangeDataTypeInCiniRoles < ActiveRecord::Migration
  def up
  	change_column :cini_roles, :status, :string, :default => 'pending'
  	add_column :cini_roles, :requester_id, :integer
  end

  def down
  	change_column :cini_roles, :status, :integer
  	remove_column :cini_roles, :requester_id
  end
end
