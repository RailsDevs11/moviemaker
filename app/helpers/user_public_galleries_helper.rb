module UserPublicGalleriesHelper

  def require_show_gallery_path(gallery_id)
    params[:user_id] ? user_public_gallery_path(@user.id, gallery_id) : cini_cini_public_gallery_path(@cini.id, gallery_id)
  end  

end
