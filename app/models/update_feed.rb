class UpdateFeed < ActiveRecord::Base
  attr_accessible :alert, :user_id
  #belongs_to :user_id
  belongs_to :updateable, :polymorphic => true

  scope :user_updates, lambda { |user_ids| where("updateable_id IN (?) and updateable_type = ?", user_ids, 'User') } 
  scope :cini_updates, lambda { |role_id| where("updateable_id IN (?) and updateable_type = ?", role_id, 'Role') } 

  def self.feed_for_user_status(status)
    status.user.update_feeds.create(:alert => "update status: <span>#{status.status}</span>")
  end

  def self.feed_for_cini_role_status(status)
    status.update_feeds.create(:alert => "update status: <span> create role: #{status.character} </span>")
  end
end
