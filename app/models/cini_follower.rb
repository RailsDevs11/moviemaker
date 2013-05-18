class CiniFollower < ActiveRecord::Base
  belongs_to :user
  belongs_to :follower,:class_name => 'User', :foreign_key => "user_id"
  belongs_to :cini_following,:class_name => 'Cini', :foreign_key => "cini_id"
  attr_accessible :user_id, :cini_id
end
