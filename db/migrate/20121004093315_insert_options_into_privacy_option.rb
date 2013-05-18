class InsertOptionsIntoPrivacyOption < ActiveRecord::Migration
  def up
  	PrivacyOption.find_or_create_by_name(:name => "Everyone")
    PrivacyOption.find_or_create_by_name(:name => "Public")
    PrivacyOption.find_or_create_by_name(:name => "Private")      
  end

  def down
  	privacy_option = ["Everyone", "Public", "Private"]
    PrivacyOption.delete_all(["name in (?)",privacy_option])
  end
end
