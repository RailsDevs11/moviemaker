class UserUpdate < ActiveRecord::Base
  belongs_to :user
  attr_accessible :status, :user_id

  after_create :generate_feed

  def generate_feed
    UpdateFeed.feed_for_user_status(self)
  end
end
