class ReelsController < ApplicationController
  before_filter :authenticate_user!

  def index
    #@reels = current_user.videos.user_reels
    @reels = current_user.videos.user_reels
    current_user.videos.build
  end

  def create
    if current_user.update_attributes(params[:user])	
    	flash[:notice] = "Upload was successful."
      redirect_to user_reels_path
    else
      @reels = current_user.videos.user_reels
    	flash[:error] = "Unable to upload video."
      render :action => "index"
    end
  end

  def update
    if current_user.update_attributes(params[:user])  
      flash[:notice] = "Successfully updated."
      redirect_to user_reels_path
    else
      flash[:error] = "Unable to update video."
      render :action => "index"
    end
  end

end
