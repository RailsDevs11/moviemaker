class CreateAccountTypes < ActiveRecord::Migration
  def change
    unless AccountType.table_exists?
      create_table :account_types do |t|
        t.string  :name
        t.timestamps
      end
      add_column :users, :account_type_id, :integer 
    end  
    AccountType.find_or_create_by_name(:name=> "creative")
    AccountType.find_or_create_by_name(:name=> "discover")
  end
end
