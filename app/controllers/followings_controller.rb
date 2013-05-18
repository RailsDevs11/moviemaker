class FollowingsController < ApplicationController

  def index
    @followings = current_user.user_followings
    @cinis = current_user.cini_followings
  end

  def unfollow_user
    connection = current_user.connections.where(:connection_id => params[:id])
    connection[0].destroy unless connection.blank?
    @followings = current_user.user_followings
  end

  def unfollow_cini
    cini_follow = current_user.cini_followers.where(:cini_id => params[:id])
    cini_follow[0].destroy unless cini_follow[0].blank?
    @cinis = current_user.cini_followings
  end
  

end
