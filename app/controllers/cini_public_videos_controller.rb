class CiniPublicVideosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :access_cini_object_required!
  layout :choose_cini_public_layout
  
  def index
  	@reels = @cini.videos
  end

  def show
    @reel = @cini.videos.find(params[:id])
    @comments = @reel.comments
    render :template => "user_public_reels/show.html.erb"
  end

  def create_reel_comment
    reel = @cini.videos.find(params[:reel_id])
    comment = reel.comments.new(params[:comment])
    comment.ownerable_type, comment.ownerable_id = "User", current_user.id
    comment.save
    @comments = reel.comments
    render :template => "user_public_reels/create_reel_comment.js.erb"
  end

  def choose_cini_public_layout
    if ["index"].include?(params[:action])
      return 'cini_public_content'
    else
      return 'cini_public_individual_content'
    end
  end
end
