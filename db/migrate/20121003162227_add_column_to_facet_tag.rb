class AddColumnToFacetTag < ActiveRecord::Migration
  def up
    add_column :facet_tags, :tag_name, :string
  end
 
  def down
    remove_column :facet_tags, :tag_name
  end
end
