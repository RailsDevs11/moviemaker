class CreateGalleries < ActiveRecord::Migration
  def up
    create_table :galleries do |t|
      t.timestamps

      t.string   :title
      t.string   :description
      t.datetime :deleted_at
      t.integer  :galleryable_id
      t.string   :galleryable_type
    end
  end

  def down
    drop_table :galleries
  end
end
