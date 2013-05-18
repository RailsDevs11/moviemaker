class CinisGalleriesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :cini
  load_and_authorize_resource :gallery, :through => :cini
  layout 'cini_layout'

  def index
    @galleries = @cini.galleries 
    render 'galleries/index'
  end

  def new
    @gallery = Gallery.new
    render 'galleries/new'
  end

  def create
    @gallery = @cini.galleries.new(params[:gallery])
    if @gallery.save 
      redirect_to user_cini_galleries_path(@cini.id)
    else
      render 'galleries/new'
    end
  end

  def destroy
    gallery = Gallery.find(params[:id])
    gallery.destroy
    redirect_to user_cini_galleries_path(@cini.id)
  end

  def edit
    @gallery = Gallery.find(params[:id])
  end

  def update
    @gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(params[:gallery])
      redirect_to edit_user_cini_gallery_path(@cini.id, @gallery)
    else
      render :edit
    end
  end  
  
 
end
