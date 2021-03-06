class CiniPublicGalleriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :access_cini_object_required!
  layout :choose_cini_public_layout


  def index
  	@galleries = @cini.galleries
  end

  def show
    @gallery = @cini.galleries.find(params[:id])
    render :template => "user_public_galleries/show.html.erb"
  end

  def choose_cini_public_layout
    if ["index"].include?(params[:action])
      return 'cini_public_content'
    else
      return 'cini_public_individual_content'
    end
  end
  
end
