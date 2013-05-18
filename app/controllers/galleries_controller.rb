class GalleriesController < InheritedResources::Base
  
  def index
    @galleries = current_user.galleries
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = current_user.galleries.new(params[:gallery])
    if @gallery.save 
      redirect_to user_galleries_path
    else
      respond_with @gallery
    end
  end

  def destroy
    gallery = Gallery.find(params[:id])
    gallery.destroy
    redirect_to user_galleries_path
  end

  def update
    @gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(params[:gallery])
      redirect_to edit_user_gallery_path(@gallery)
    else
      render :edit
    end
  end  
  
end
