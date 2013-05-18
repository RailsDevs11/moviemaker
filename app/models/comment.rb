class Comment < ActiveRecord::Base

  acts_as_paranoid

  # Means Model can be commented on
  belongs_to :commentable, :polymorphic => true
  
  belongs_to :ownerable, :polymorphic => true
  # Means Model can make comments
  belongs_to :commerterable, :polymorphic => true
  attr_accessible :comment
end