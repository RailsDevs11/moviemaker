class CreateFacetTags < ActiveRecord::Migration
  def up
    create_table :facet_tags do |t|
      t.timestamp
      t.string :context
    end
  end

  def down
    drop_table :facet_tags
  end
end
