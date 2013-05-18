class Connection < ActiveRecord::Base
  attr_accessible :connection_id, :status, :user_id, :relation

  belongs_to :user
  belongs_to :friend, :class_name => 'User', :foreign_key => "connection_id"
  belongs_to :user_following, :class_name => 'User', :foreign_key => "connection_id"
  belongs_to :follower, :class_name => 'User'
  belongs_to :pending, :class_name => 'User', :foreign_key => "connection_id"
  belongs_to :requester, :class_name => "User"

  scope :get_connection, lambda { |user_id, connection_id| where('(user_id = ? and connection_id = ?) or (user_id = ? and connection_id = ?)', user_id, connection_id, connection_id, user_id) }

end
