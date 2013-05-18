class CreatePrivacyOptions < ActiveRecord::Migration
  def change
    create_table :privacy_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
