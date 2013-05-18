class HomesController < ApplicationController
  before_filter :authenticate_user!, :only => [:index]	
  require 'will_paginate/array'
  
  def index
    @recent_cinimakers = User.get_cinimakers(current_user.id).last(3).reverse
    @recent_public_cinis = Cini.get_published_cinis.last(3).reverse
    @trading_cinis = Cini.get_published_cinis
    @needs = Need.related_needs(current_user.get_related_cinis.map(&:id)).reverse.paginate(:page => params[:need], :per_page => 5)
    @updates = UpdateFeed.user_updates(current_user.get_connected_users.map(&:id)).reverse.paginate(:page => params[:updates], :per_page => 5)
  end

  def more_feeds
    @updates = UpdateFeed.user_updates(current_user.get_connected_users.map(&:id)).reverse.paginate(:page => params[:updates], :per_page => 5)
    respond_to do |format|
      format.html 
      format.js
    end
  end
  
  def more_needs
    @needs = Need.related_needs(current_user.get_related_cinis.map(&:id)).reverse.paginate(:page => params[:need], :per_page => 5)
    respond_to do |format|
      format.html 
      format.js
    end
  end
  
  def cinimaker_home
    if current_user.present?
      redirect_to homes_path
    else
      redirect_to user_session_path
    end
  end
end
