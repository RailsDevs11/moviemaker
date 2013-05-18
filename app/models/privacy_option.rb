class PrivacyOption < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user_privacy
end
