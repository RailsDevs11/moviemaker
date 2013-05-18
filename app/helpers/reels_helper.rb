module ReelsHelper
  def create_videos
    (params[:cini_id] ? url_for(:controller => 'cinis_videos', :action => 'create') : url_for(:controller => 'reels', :action => 'create') )
  end

  def update_videos
    (params[:cini_id] ? url_for(:controller => 'cinis_videos', :action => 'update', :id => current_user) : url_for(:controller => 'reels', :action => 'update', :id => current_user) )
  end    

  def videoable_type
    (params[:cini_id] ? 'Cini' : 'NULL')
  end

  def videoable_id
    (params[:cini_id] ? params[:cini_id] : 'NULL')
  end
end
