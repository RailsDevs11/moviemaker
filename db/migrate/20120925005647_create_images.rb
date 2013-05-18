class CreateImages < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.timestamps

      t.string   :image
      t.string   :imageable_type
      t.integer  :imageable_id
      t.datetime :deleted_at
    end
  end

  def down
    drop_table :images
  end
end
