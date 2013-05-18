class CinisVideosController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :cini
  load_and_authorize_resource :video, :through => :cini
  layout 'cini_layout'

  def index
    @reels = @cini.videos.cini_reels
  	current_user.videos.build
  	render 'reels/index'    
  end

  def create    
    if current_user.update_attributes(params[:user])
       flash[:notice] = "Upload was successful."
       redirect_to user_cini_videos_path(@cini.id)
    else
       @reels = @cini.videos.cini_reels
       flash[:error] = "Unable to upload video."
       render 'reels/index'
    end
  end

  def update
    if current_user.update_attributes(params[:user])  
      flash[:notice] = "Successfully updated."
      redirect_to user_cini_videos_path(@cini.id)
    else
      flash[:error] = "Unable to update video."
      render :action => "index"
    end
  end

end
