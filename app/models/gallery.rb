#
# Galleries can be owned by: User, Cini
#

class Gallery < ActiveRecord::Base

  acts_as_paranoid

  attr_accessible :image, :title, :description, :images

  has_many :images, :as => :imageable, :dependent => :destroy
  has_many :comments, :as => :commentable
  validates :title, :presence => true
  belongs_to :galleryable, :polymorphic => true

  def cini_public_gallery_image
    (self.present? and self.images.present?) ? self.images[0].image.gallery_image.url : "/assets/galleryImage1.jpg"
  end

end