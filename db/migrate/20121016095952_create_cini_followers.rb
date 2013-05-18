class CreateCiniFollowers < ActiveRecord::Migration
  def change
    create_table :cini_followers do |t|
      t.references :user
      t.references :cini

      t.timestamps
    end
    add_index :cini_followers, :user_id
    add_index :cini_followers, :cini_id
  end
end
