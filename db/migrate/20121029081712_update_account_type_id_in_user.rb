class UpdateAccountTypeIdInUser < ActiveRecord::Migration
  def change
  	User.update_all(:account_type_id => 1)
  end
end
