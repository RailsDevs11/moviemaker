class ImagesController < ApplicationController
 
 load_and_authorize_resource :class => Comment, :only => [:delete_image_comment]
 
  def new
    @gallery = Gallery.find(params[:gallery_id])
    @image = Image.new
  end


  def create_image_comment
    image = Image.find(params[:image_id])
    comment = image.comments.new(params[:comment])
    comment.ownerable_type, comment.ownerable_id = "User", current_user.id
    comment.save
    @comments = image.comments
  end

  def delete_image_comment
    comment = Comment.find(params[:id])
    image = comment.commentable
    comment.destroy
    @comments = image.comments
    render :template => "images/create_image_comment.js.erb"
  end

  def create
    gallery = Gallery.find(params[:gallery_id])
    @image = gallery.images.new(params[:image])
    if @image.save 
      redirect_to user_galleries_path    
    else
      @gallery = Gallery.find(params[:gallery_id])
      render :new
    end
  end
  
  def show 
    @image = Image.find(params[:id])
    @comments = @image.comments
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    redirect_to user_galleries_path
  end
end
