class CiniPublicNeedsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :access_cini_object_required!
  layout :choose_cini_public_layout

  
  def index
    
  end

  def show
    @need = @cini.needs.find(params[:id])
  end

  def choose_cini_public_layout
    if ["index"].include?(params[:action])
      return 'cini_public_content'
    else
      return 'cini_public_individual_content'
    end
  end
  
end
