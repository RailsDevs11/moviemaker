class AddTitleToImage < ActiveRecord::Migration
  def up
    add_column :images, :title, :string
    add_column :images, :description, :string
  end
 
  def down
    remove_column :images, :title
    remove_column :images, :description
  end
end
