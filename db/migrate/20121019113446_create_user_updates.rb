class CreateUserUpdates < ActiveRecord::Migration
  def change
    create_table :user_updates do |t|
      t.string :status
      t.references :user

      t.timestamps
    end
    add_index :user_updates, :user_id
  end
end
