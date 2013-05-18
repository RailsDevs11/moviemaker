class Need < ActiveRecord::Base

  acts_as_paranoid
  attr_accessible :title, :location, :needed_on, :images_attributes
  belongs_to :cini
  has_many :images, :as => :imageable, :dependent => :destroy
  #mount_uploader :video, VideoUploader
  
  validates :title, :presence => true
  accepts_nested_attributes_for :images, :allow_destroy => true
  
  scope :related_needs, lambda { |cini_ids| where("cini_id IN (?)", cini_ids) } 

  def show_needs
    "#{cini.title} needs #{self.title} in #{self.location} on #{self.needed_on}."
  end

end
