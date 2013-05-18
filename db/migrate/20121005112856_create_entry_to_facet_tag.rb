class CreateEntryToFacetTag < ActiveRecord::Migration
  def up
  	FacetTag.create(:context => "iamas",  :tag_name => "Producer")
  	FacetTag.create(:context => "iamas",  :tag_name => "Director")
  	FacetTag.create(:context => "iamas",  :tag_name => "Actor")
  	FacetTag.create(:context => "unions", :tag_name => "Student")
  	FacetTag.create(:context => "unions", :tag_name => "Worker")
 	FacetTag.create(:context => "unions", :tag_name => "Employee")
  end

end
