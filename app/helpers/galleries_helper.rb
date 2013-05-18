module GalleriesHelper

  def upload_new_image
    (params[:cini_id] ? url_for(:controller => 'cinis_images', :action => 'create') : url_for(:controller => 'images', :action => 'create') )
  end

  def delete_gallery(gallery_list)
    (params[:cini_id] ? user_cini_gallery_path(params[:cini_id],gallery_list) : user_gallery_path(gallery_list) )
  end 

  def add_image(gallery_list)
    (params[:cini_id] ? new_user_cini_gallery_image_path(params[:cini_id],gallery_list) : new_user_gallery_image_path(gallery_list) )
  end

  def delete_image(gallery_list,image_list)
    (params[:cini_id] ? user_cini_gallery_image_path(params[:cini_id],gallery_list,image_list) : user_gallery_image_path(gallery_list,image_list) )
  end

  def new_gallery_link
    (params[:cini_id] ? new_user_cini_gallery_path(params[:cini_id]) : new_user_gallery_path)
  end 

  def create_gallery
    (params[:cini_id] ? url_for(:controller => 'cinis_galleries', :action => 'create') : url_for(:controller => 'galleries', :action => 'create') )
  end  

end
