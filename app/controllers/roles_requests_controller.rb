class RolesRequestsController < ApplicationController
  def index
    @requests = current_user.pendding_role_request
  end

  def update_status
    @requests = current_user.pendding_role_request
    current_user.reject_all_role_requests and return if params[:id] == "all"
    request = @requests.find(params[:id])
    request.update_attribute(:status, params[:status]) if ["accepted","rejected"].include?(params[:status])
  end
end
