class AddRelationToConnection < ActiveRecord::Migration
  def change
    rename_column :connections, :connection_status, :status
    add_column :connections, :relation, :string
  end
end
