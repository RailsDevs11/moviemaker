class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied! You need to change your account type to the creative account type."
    redirect_to root_url, :alert => exception.message
  end

  def access_user_object_required!
    @user = User.find(params[:user_id]||params[:id])
  end

  def access_cini_object_required!
    @cini = Cini.find(params[:cini_id]||params[:id])
  end

  def privacy_data
    @user_privacy = current_user.user_privacy
    @privacy_option = PrivacyOption.find(:all).map { |e| [e.name, e.id]  }
    @selected_connection = current_user.user_privacy.connection_request
    @selected_messaging = current_user.user_privacy.messaging
    @selected_search = current_user.user_privacy.search_engine
  end

  def credits_data
    @total_credits = current_user.credits
    @credit = current_user.exist_credits.new
    @credit_types = FacetTag.credit_type_tag.collect { |x| x.tag_name }
  end

end
