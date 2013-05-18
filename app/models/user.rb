class User < ActiveRecord::Base

  acts_as_ordered_taggable_on :iamas, :unions, :primaries, :secondaries, :tertiaries

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :about, :avatar, :height, :age, :current_password, :primary_location, :secondary_location, :account_type_id, :videos_attributes, :credits_attributes  
  I_AM_A = ["Actor", "Director", "Producer"]
  UNIONS = ["Employee", "Student", "Worker"]
  CREATIVE, DISCOVER = "creative", "discover"
  validates :first_name, :last_name, :account_type_id, :presence => true
  # A user has an avatar with is an Image
  belongs_to :avatar, :class_name => "Image"
  belongs_to :account_type
  has_many :connections
  has_many :friends,   :through => :connections, :conditions => {"connections.relation" => "friend"}
  has_many :pendings,  :through => :connections, :conditions => {"connections.status" => "pending"}
  has_many :user_followings,  :through => :connections, :conditions => {"connections.relation" => "follower"}  
  has_many :inverse_connections, :class_name => "Connection", :foreign_key => "connection_id"
  has_many :inverse_requesters, :through => :inverse_connections, :source => :user, :conditions => {"connections.status" => "pending"}
  has_many :inverse_followers, :through => :inverse_connections, :source => :user, :conditions => {"connections.relation" => "follower"}
  
  has_many :cini_followers
  has_many :cini_followings, :through => :cini_followers
  
  has_many :user_updates

  # A user can have images attached to it
  has_many :images, :as => :imageable
  # A user can have galleries attached to it
  has_many :galleries, :as => :galleryable
  # A user can have credits attached to it
  has_many :credits
  has_many :exist_credits, :class_name => "Credit"
  accepts_nested_attributes_for :credits, :allow_destroy => true
  # A user can own comments
  has_many :comments, :as => :ownerable
  # A user can own videos
  has_many :videos, :as => :ownerable

  accepts_nested_attributes_for :videos, :reject_if => :all_blank, :allow_destroy => true

  has_many :cinis
  has_one :user_privacy
  
  has_many :cini_roles, :dependent => :destroy
  has_many :requested_cinis, :class_name => "Cini", :through => :cini_roles
  has_many :update_feeds, :as => :updateable

  after_save :save_privacy_setting
  before_create :set_account_type

  def get_top_status
    user_updates.blank? ? "" : user_updates.last.status
  end

  #callback for set account type, if account type is not selected
  def set_account_type
    self.account_type_id = AccountType.find_by_name(DISCOVER).id if self.account_type_id.blank?
  end
   
  scope :get_cinimakers, lambda { |user_id| where("id != ? and account_type_id = ?", user_id, AccountType.find_by_name(CREATIVE).id) } 

  def self.remove_connection_records(user_id, connection_id)
    user_connections = Connection.get_connection(user_id, connection_id)
    user_connections.delete_all if user_connections.present?
  end

  def get_approved_connections
    connections.where("status = 'friend'")
  end

  def get_managable_cinis
    role_cinis = self.cini_roles.select {|cini_role| cini_role.is_admin }.collect {|cini_role| cini_role.cini}.delete_if { |x| x.nil?} 
    (role_cinis + self.cinis).uniq 
  end  
 
 
  def get_publiced_cinis_count
    get_managable_cinis.select {|cini| cini.is_published }.count 
  end  

  def pendding_role_request
    self.cini_roles.where('status =?', 'pending')
  end

  def reject_all_role_requests
    pendding_role_request.update_all(:status => 'rejected')
  end

  def save_privacy_setting
    public_option = PrivacyOption.find_by_name("Public")
    UserPrivacy.create(:user_id => self.id, :connection_request => public_option.id, :messaging => public_option.id, :search_engine => public_option.id, :public_option => public_option.id) unless public_option.nil?
  end

   #return role status for a particular user
  def is_invited?(role, cini)
    cini_role = role.get_cini_role_for_user(self.id, cini.id)
    return false if cini_role.blank?
    return ((cini_role.status != 'pending') ? cini_role.status : ((cini_role.requester_id != self.id) ? "Request" : "pending"))
  end


  def get_unions
    nil
  end

  def get_i_am_as
   nil
  end

# return own created published cinis and assigned as role published cinis 
  def get_cinis
    ((self.cini_roles.accepted_records.collect {|cini_role| cini_role.cini}.delete_if {|c| c.nil?} + self.cinis).uniq).select{ |cini| cini.is_published }
  end


  def is_creative?
    account_type.name == CREATIVE
  end

  def is_discover?
    account_type.name == DISCOVER
  end

  def change_discover_to_creative
    self.update_attribute(:account_type_id, AccountType.find_by_name(CREATIVE))
    #user_type == "discover"
    false
  end

  def is_cini_admin?(cini)
    !!self.cini_roles.where('cini_id=? and is_admin=?', cini.id, true)[0]
  end  


  def cini_follow(cini_id)
    self.cini_followers.create(:cini_id => cini_id)
  end
  
  def cini_unfollow(cini_id)
    cini_follow = self.cini_followers.where(:cini_id => cini_id)
    cini_follow[0].destroy unless cini_follow[0].blank?
  end

  def is_followed?(cini_id)
    !!self.cini_followers.where(:cini_id => cini_id)[0]
  end

  def followed_status(cini_id)
    self.is_followed?(cini_id) ? 'unfollow' : 'follow'
  end

  def get_priority_tag(priorty, context)
    return send("#{context}_list") & send("#{priorty}_list")
  end


  def return_followed_path(cini_id)
    "/cinis/#{cini_id}/cini_#{self.followed_status(cini_id)}_on_public"
  end
  
  def user_feed_image
    (self.avatar.present? and self.avatar.image.user_feed.present?) ? self.avatar.image.user_feed.url : "/assets/ciniAvatar1.png"
  end

  def user_profile_image
    (self.avatar.present? and self.avatar.image.medium.present?) ? self.avatar.image.medium.url : "/assets/ciniAvatar1.png"
  end

  def user_small_image
    (self.avatar.present? and self.avatar.image.thumb.present?) ? self.avatar.image.thumb.url : "/assets/user-a1.png"
  end
   
  def user_image_for_following
    (self.avatar.present? and self.avatar.image.cini_follower_image.present?) ? self.avatar.image.cini_follower_image.url : "/assets/fthumb1.jpg"
  end   

  def user_public_profile_image
    (self.avatar.present? and self.avatar.image.user_poster_image.present?) ? self.avatar.image.user_poster_image.url : "/assets/posterImage2.jpg"
  end 

  def get_related_cinis
    (self.cini_followings + self.get_managable_cinis).uniq
  end

  def user_upload_image
    (self.avatar.present? and self.avatar.image.user_upload_image.present?) ? self.avatar.image.user_upload_image.url : "/assets/uploaded-image.png"
  end

  def get_connected_users
    (self.user_followings + self.friends + [self]).uniq
  end

end
