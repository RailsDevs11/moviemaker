class UserPublicReelsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :access_user_object_required!
  layout :choose_user_public_layout
  
  def index
    @reels = @user.videos.user_reels
  end

  def show
    @reel = @user.videos.user_reels.find(params[:id])
    @comments = @reel.comments
  end

  def create_reel_comment
    reel = @user.videos.user_reels.find(params[:reel_id])
    comment = reel.comments.new(params[:comment])
    comment.ownerable_type, comment.ownerable_id = "User", current_user.id
    comment.save
    @comments = reel.comments
  end

  def choose_user_public_layout
    if ["index"].include?(params[:action])
      return 'user_public_content'
    else
      return 'user_public_individual_content' 
    end
  end


end
