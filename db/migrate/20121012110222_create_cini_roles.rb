class CreateCiniRoles < ActiveRecord::Migration
  def change
    create_table :cini_roles do |t|
      t.integer :cini_id
      t.integer :user_id
      t.integer :role_id
      t.boolean :status

      t.timestamps
    end
  end
end
