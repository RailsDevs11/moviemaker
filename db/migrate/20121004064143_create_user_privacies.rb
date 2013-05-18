class CreateUserPrivacies < ActiveRecord::Migration
  def change
    create_table :user_privacies do |t|
      t.integer :connection_request
      t.integer :messaging
      t.integer :search_engine
      t.integer :user_id
      
      t.timestamps
    end
  end
end
