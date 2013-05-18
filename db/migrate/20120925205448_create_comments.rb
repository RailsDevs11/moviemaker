class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.timestamps

      t.string   :commentable_type
      t.integer  :commentable_id

      t.string   :ownerable_type
      t.integer  :ownerable_id

      t.text     :comment
      t.datetime :deleted_at
    end
  end

  def down
    drop_table :comments
  end
end
