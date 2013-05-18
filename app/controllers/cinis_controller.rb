class CinisController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :except => [:show, :cini_follow_on_public, :cini_unfollow_on_public, :more_feeds, :more_needs]
  before_filter :access_cini_object_required!, :only => [:show, :cini_follow_on_public, :cini_unfollow_on_public, :more_feeds, :more_needs]
  require 'will_paginate/array'
  layout 'cini_layout'


  def index
    redirect_to root_url and return unless can? :index, Cini.new
    render :layout => 'application' 
  end

  def new
    @image = Image.new
    @cini = Cini.new
    render :layout => 'application' 
  end
  
  def create
    @cini = current_user.cinis.new(params[:cini])
    if @cini.save 
      image = @cini.images.create(params[:image])
      @cini.one_sheet_id = image.id
      @cini.save
      redirect_to user_cinis_path
    else
      @image = Image.new
      render :new, :layout => 'application'
    end
  end  

  def edit
    @cini = Cini.find(params[:id])
    @image = @cini.one_sheet 
    @needs = @cini.needs.reverse.paginate(:page => params[:need], :per_page => 10)
  end  

  def update
    @cini = Cini.find(params[:id])
    if @cini.update_attributes(params[:cini])
      @cini.one_sheet.update_attributes(params[:image])
      redirect_to edit_user_cini_path(@cini)
    else
      @needs = @cini.needs.reverse.paginate(:page => params[:need], :per_page => 10)
      @image = @cini.one_sheet
      render :edit
    end
  end

  def follow_cini
    current_user.cini_follow(params[:id])
    redirect_to user_cinis_path
  end
  
  def destroy
    cini = current_user.cinis.where(:id => params[:id])
    cini[0].destroy  unless cini[0].blank?
    redirect_to user_cinis_path
  end

  def unfollow_cini
    current_user.cini_unfollow(params[:id])
    redirect_to user_cinis_path
  end

  def change_cini_status
    @cini = Cini.find(params[:id])
    @cini.update_attributes(:is_published => params[:is])
    redirect_to user_cinis_path
  end
  
  def show
    @reels = @cini.videos
    @galleries = @cini.galleries
    @needs = @cini.needs.reverse.paginate(:page => params[:need], :per_page => 5)
    @roles = @cini.roles
    @updates = UpdateFeed.cini_updates(@cini.roles.map(&:id)).reverse.paginate(:page => params[:updates], :per_page => 5)
    render :layout => "cini_public_content"
  end
  
  def more_feeds
    @updates = UpdateFeed.cini_updates(@cini.roles.map(&:id)).reverse.paginate(:page => params[:updates], :per_page => 5)
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def more_needs
    @needs = @cini.needs.reverse.paginate(:page => params[:need], :per_page => 5)
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def cini_follow_on_public
    current_user.cini_follow(@cini.id)
    redirect_to cini_path(@cini.id)
  end

  def cini_unfollow_on_public
    current_user.cini_unfollow(@cini.id)
    redirect_to cini_path(@cini.id)  
  end
end
