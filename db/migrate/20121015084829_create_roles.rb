class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :character
      t.integer :age
      t.string :height
      t.string :hair_color
      t.text :description
      t.boolean :gender
      t.integer :cini_id

      t.timestamps
    end
  end
end
