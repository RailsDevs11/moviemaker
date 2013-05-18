class CiniRole < ActiveRecord::Base
  attr_accessible :cini_id, :role_id, :status, :user_id, :requester_id, :is_admin
  belongs_to :user
  belongs_to :cini
  belongs_to :role

  after_create :notification_for_creative_account

  def notification_for_creative_account
    if self.user.is_discover?
      #code for create notification
    end
  end	


  scope :accepted_records, -> { where(status: 'accepted') }
  scope :pending_records, -> { where(status: 'pending') }
end
