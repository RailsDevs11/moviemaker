class AddDeletedAtToNeed < ActiveRecord::Migration
  def change
    add_column :needs, :deleted_at, :datetime
  end
end
