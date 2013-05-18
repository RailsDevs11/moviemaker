class Cini < ActiveRecord::Base

  acts_as_paranoid
  acts_as_taggable_on :genres, :project_statuses, :project_types, :script_statuses

  belongs_to :user
  belongs_to :one_sheet, :class_name => "Image"

  # polymorphic relationships
  has_many :comments,  :as => :commentable
  has_many :images,    :as => :imageable, :dependent => :destroy
  has_many :videos,    :as => :videoable, :dependent => :destroy
  has_many :galleries, :as => :galleryable
  has_many :cini_followers
  has_many :followers, :through => :cini_followers
  has_many :cini_roles
  has_many :requested_users, :class_name => "User", :through => :cini_roles
  has_many :roles
  attr_accessible :synopsis, :one_sheet, :location, :log_line, :title, :user_id, 
    :one_sheet_id, :roles_attributes, :is_published, :cini_roles_attributes, :is_hidden

  validates :title, :presence => true
  has_many :needs
  has_many :updates, :as => :updateable

  scope :get_published_cinis, where(:is_published => true)#return published cinis  

  accepts_nested_attributes_for :roles, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :cini_roles, :reject_if => :all_blank, :allow_destroy => true

  def get_roles_for_cinis(user_id)
    self.cini_roles.accepted_records.where(:user_id => user_id).collect{ |cini_role| cini_role.role.character }[0]
  end

  def cini_profile_image
    (self.one_sheet.present? and self.one_sheet.image.cini_long_image.present?) ? self.one_sheet.image.cini_long_image.url : "/assets/postar-small-1.png"
  end

  def cini_large_image
    (self.one_sheet.present? and self.one_sheet.image.cini_trading_image.present?) ? self.one_sheet.image.cini_trading_image.url : "/assets/movie-carousel1.png"
  end


  def cini_public_profile_image
    (self.one_sheet.present? and self.one_sheet.image.cini_poster_image.present?) ? self.one_sheet.image.cini_poster_image.url : "/assets/posterImage1.jpg"
  end 

  def cini_public_image_to_need
    (self.one_sheet.present? and self.one_sheet.image.present?) ? self.one_sheet.image.url : "/assets/needAvatar.jpg"
  end
  
  def cini_small_image
    (self.one_sheet.present? and self.one_sheet.image.cini_need_image.present?) ? self.one_sheet.image.cini_need_image.url : "/assets/needAvatar.jpg"
  end

  def cini_detail_page_image
    (self.one_sheet.present? and self.one_sheet.image.cini_detail_image.present?) ? self.one_sheet.image.cini_detail_image.url : "/assets/perfume.jpg"
  end

  def cini_image
    (self.one_sheet.present? and self.one_sheet.image.cini_image.present?) ? self.one_sheet.image.cini_image.url : "/assets/cinithumbs1.jpg"
  end

  def get_cini_followers
    self.followers.limit(6).reverse
  end 

  def get_all_cini_followers
    self.followers.reverse
  end    
end
