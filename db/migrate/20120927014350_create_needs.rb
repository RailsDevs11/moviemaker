class CreateNeeds < ActiveRecord::Migration
  def up
    create_table :needs do |t|
      t.timestamps
      t.integer :cini_id
      t.datetime :needed_on
      t.string :location
      t.string :title
    end
  end

  def down
    drop_table :needs
  end
end
