class AddOnesheetidColumnToCini < ActiveRecord::Migration
  def change
    add_column :cinis, :one_sheet_id, :integer
  end
end
