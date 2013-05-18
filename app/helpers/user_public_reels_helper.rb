module UserPublicReelsHelper

  def require_create_path(reel_id)
    params[:user_id] ? create_reel_comment_user_public_reels_path(:reel_id => reel_id) : create_reel_comment_cini_cini_public_videos_path(:reel_id => reel_id)
  end  
  
  def require_show_path(reel_id)
    params[:user_id] ? user_public_reel_path(@user.id, reel_id) : cini_cini_public_video_path(@cini.id, reel_id)
  end  
  
end
