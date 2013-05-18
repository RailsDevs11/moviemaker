class UserPublicCinisController < ApplicationController
  before_filter :authenticate_user!
  before_filter :access_user_object_required!
  layout :choose_user_public_layout
  

  def index
    @cinis = @user.get_cinis
  end

  def choose_user_public_layout
    if ["index"].include?(params[:action])
      return 'user_public_content'
    else
      return 'user_public_individual_content' 
    end
  end
  
end
