class UserPublicGalleriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :access_user_object_required!
  layout :choose_user_public_layout
  
  def index
    @galleries = @user.galleries
    render :layout => 'user_public_content'
  end

  def show
    @gallery = @user.galleries.find(params[:id])
  end

  def choose_user_public_layout
    if ["index"].include?(params[:action])
      return 'user_public_content'
    else
      return 'user_public_individual_content' 
    end
  end
	
end
