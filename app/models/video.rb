class Video < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :videoable, :polymorphic => true
  belongs_to :thumbnail, :class_name => "Image"
  belongs_to :creator, :class_name => "User", :foreign_key => "ownerable_id"
  has_many :comments, :as => :commentable
  has_many :reels, :class_name => "Video", :as => :videoable

  mount_uploader :video, VideoUploader
  attr_accessible :title, :description, :is_featured, :video, :videoable_id, :videoable_type, :video_cache, :videos_attributes
    
  validates :title, :description, :presence => true

  scope :user_reels, -> { where(videoable_type: 'NULL') }
  scope :cini_reels, -> { where(videoable_type: 'Cini') }

  def cini_public_video_image
    #need to resize the cini image.
    #(self.present? and self.video.present?) ? self.video_url : "/assets/listvid1.jpg"
    "/assets/listvid1.jpg"    
  end

end