class CreateUpdateFeeds < ActiveRecord::Migration
  def change
    create_table :update_feeds do |t|
      t.integer :user_id
      t.text :alert
      t.integer :updateable_id
      t.string :updateable_type
      t.timestamps
    end
  end
end
