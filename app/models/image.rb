class Image < ActiveRecord::Base

  acts_as_paranoid
  belongs_to :imageable, :polymorphic => true
  has_many :comments, :as => :commentable, :dependent => :destroy
  attr_accessible :image, :image_cache, :title, :description
  #validates :title, :presence => true 

  #validates_presence_of :image, :if => :is_image_require?
  mount_uploader :image, ImageUploader


  def is_image_require?
  	require_array = ["Gallery"]
    require_array.include?(imageable_type)
  end
  
end
