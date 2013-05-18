class Credit < ActiveRecord::Base

  acts_as_paranoid
  
  belongs_to :user
  attr_accessible :title, :year, :role, :link
  
  acts_as_taggable
  acts_as_taggable_on :credit_type

  validates :title, :presence => true

  YEARS = [2012,2013,2014,2015,2016]
end
