class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :access_user_object_required!, :only => [:show]
  require 'will_paginate/array'
  
  def privacy
  	@user_privacy = current_user.user_privacy
    @privacy_option = PrivacyOption.find(:all).map { |e| [e.name, e.id]  }
    @selected_connection = current_user.user_privacy.connection_request
    @selected_messaging = current_user.user_privacy.messaging
    @selected_search = current_user.user_privacy.search_engine
  end

  def update_privacy
    @user_privacy = current_user.user_privacy
    flash[:notice] =  'User privacy was successfully updated.' if @user_privacy.update_attributes(params[:user_privacy])
    redirect_to user_profile_path
  end

  def update_status
    current_user.user_updates.create(params[:user_update])
    redirect_to homes_path
  end

  def show
    @cinis = @user.cinis
    @reels = @user.videos
    @galleries = @user.galleries
    @credit_tags = FacetTag.credit_type_tag.collect { |x| x.tag_name }
    @credits = @user.credits
    @needs = Need.related_needs(@user.get_related_cinis.map(&:id)).reverse.paginate(:page => params[:need], :per_page => 5)
    @updates = UpdateFeed.user_updates(@user.get_connected_users.map(&:id)).reverse.paginate(:page => params[:updates], :per_page => 5)
    render :layout => "user_public_content"
    #flash[:notice] = "You can not access other user profile" if current_user.id.to_s != params[:id]
  end

  def cinimakers
    @cinimakers = User.get_cinimakers(current_user.id)
  end
  
  def cinis
    @cinis = Cini.get_published_cinis
  end

end
