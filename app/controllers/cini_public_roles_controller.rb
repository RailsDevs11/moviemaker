class CiniPublicRolesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :access_cini_object_required!
  layout :choose_cini_public_layout

  
  def index
  end

  def show 
    @role = @cini.roles.find(params[:id])
    redirect_to cini_cini_public_roles_path(@cini.id) unless @role.cini_roles.accepted_records[0].blank?
  end

  def role_request
    @role = @cini.roles.find(params[:id])
    @role.cini_roles.create(:user_id => current_user.id, :requester_id => current_user.id, :cini_id => @cini.id)
    redirect_to cini_cini_public_roles_path(@cini.id)
  end

  def choose_cini_public_layout
    if ["index"].include?(params[:action])
      return 'cini_public_content'
    else
      return 'cini_public_individual_content'
    end
  end
end
