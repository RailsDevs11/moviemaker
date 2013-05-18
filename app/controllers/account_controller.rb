class AccountController < ApplicationController
  before_filter :authenticate_user!  

  def index
  end

  def change_to_creative
    current_user.change_discover_to_creative
    render :template => "account/change_to_creative.js.erb"
  end
end
