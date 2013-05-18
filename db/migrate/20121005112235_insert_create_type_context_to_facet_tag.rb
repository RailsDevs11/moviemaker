class InsertCreateTypeContextToFacetTag < ActiveRecord::Migration
  def up
  	FacetTag.find_or_create_by_tag_name(:context =>'credit_type', :tag_name => "TV")
    FacetTag.find_or_create_by_tag_name(:context =>'credit_type',:tag_name => "Film")
    FacetTag.find_or_create_by_tag_name(:context =>'credit_type',:tag_name => "Music Videos")      
    FacetTag.find_or_create_by_tag_name(:context =>'credit_type',:tag_name => "Commercials")
  end

  def down
  	tag_option = ["TV", "Film", "Music Videos", "Commercials"]
    FacetTag.delete_all(["tag_name in (?)",tag_option])
  end
end
