class UserPrivacy < ActiveRecord::Base

  belongs_to :user
  has_many :privacy_options

  attr_accessible :connection_request, :messaging, :search_engine, :user_id, :public_option
  attr_accessor :public_option

end
