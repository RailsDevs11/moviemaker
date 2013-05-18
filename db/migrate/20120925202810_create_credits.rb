class CreateCredits < ActiveRecord::Migration
  def up
    create_table :credits do |t|
      t.timestamps
      t.datetime :deleted_at
      t.integer  :user_id
      t.string   :title
      t.integer  :year
      t.string   :role
      t.string   :link
    end
  end

  def down
    drop_table :credits
  end
end
