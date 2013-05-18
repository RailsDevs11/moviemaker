class CreateCini < ActiveRecord::Migration
  def up
    create_table :cinis do |t|
      t.timestamps
      t.string   :one_sheet
      t.text     :synopsis
      t.string   :location
      t.text     :log_line
      t.string   :title
      t.boolean  :is_hidden, :default => true
      t.boolean  :is_published, :default => false
      t.datetime :deleted_at
      t.integer  :user_id
    end
  end

  def down
    drop_table :cinis
  end
end
