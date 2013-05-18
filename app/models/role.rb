class Role < ActiveRecord::Base
  #acts_as_paranoid

  attr_accessible :age, :character, :description, :gender, :hair_color, :height, :cini_id, :images_attributes, :is_admin
  has_many :images, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :images, :allow_destroy => true

  #belongs_to :user
  belongs_to :cini
  has_many :cini_roles, :dependent => :destroy

  validates :character, :description, :presence => true
  has_many :update_feeds, :as => :updateable

  after_create :generate_cini_role_feed

  def generate_cini_role_feed
    UpdateFeed.feed_for_cini_role_status(self)
  end

  def get_role_status
    cini_role = self.cini_roles.accepted_records[0]
    cini_role.blank? ? "Apply" : "#{cini_role.user.first_name} #{cini_role.user.last_name}"
  end 

  def user_image_to_public_role
    cini_role = self.cini_roles.accepted_records[0]
    cini_role.blank? ? "/assets/ciniAvatar-A.png" : "#{cini_role.user.user_profile_image}"
  end

  def role_pedding_status(user_id)
    cini_role = self.cini_roles.where('user_id =?', user_id)[0]
    cini_role.blank? ? "Apply for Role" : ((cini_role.requester_id == user_id) ? "Requested" : "Invited")
  end
 
  def get_cini_role_for_user(user_id, cini_id)
    self.cini_roles.where("cini_id = ? and user_id = ? and status = ?", cini_id, user_id, 'pending')[0]
  end
  
  def is_unfill?
    !self.cini_roles.where("status = ?", 'accepted')[0]
  end

end
