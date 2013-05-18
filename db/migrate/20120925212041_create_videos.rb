class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.timestamps
      t.datetime :deleted_at

      t.string :videoable_type
      t.integer :videoable_id

      t.string :ownerable_type
      t.integer :ownerable_id

      t.string :video # carrier wave
      t.text :description
      t.boolean :is_featured, :default => false
      t.integer :thumbnail # Image
    end
  end

  def down
  end
end
