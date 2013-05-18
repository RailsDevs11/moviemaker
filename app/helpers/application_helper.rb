module ApplicationHelper

  def check_cini_follower(cini_id)
    link_to 'Follow-cini', follow_cini_user_cini_path(cini_id) unless current_user.is_followed?(cini_id)
  end

  def find_cini
    cini_id = params[:cini_id] || params[:id]
    @cini_record = Cini.find(cini_id)
  end

  def is_connected?
    !!Connection.get_connection(@user.id, current_user.id)[0]
  end

  def get_capitalize(str)
    str.blank? ? "" : str.capitalize
  end

  def get_capitalize_with_truncate(str)
    truncate(get_capitalize(str), :length => 50, :omission => '...')
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
