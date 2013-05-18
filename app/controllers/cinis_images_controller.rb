class CinisImagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :cini
  load_and_authorize_resource :image, :through => :cini
  layout 'cini_layout'
  
  def new
    @image = Image.new
    render 'images/new'
  end

  def create
    gallery = Gallery.find(params[:gallery_id])
    @image = gallery.images.new(params[:image])
    if @image.save 
      redirect_to user_cini_galleries_path(@cini.id)    
    else
      render 'images/new'
    end
  end
  
  def destroy
    image = Image.find(params[:id])
    image.destroy
    redirect_to user_cini_galleries_path(@cini.id)
  end

  def show 
    @image = Image.find(params[:id])
    @comments = @image.comments
    render 'images/show'
  end
end
