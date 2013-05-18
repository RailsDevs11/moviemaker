class ConnectionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :access_user_object_required!, :only => [:add_connection, :brack_connection] 
  layout 'inbox_layout'
  
  def index 
    get_connections
  end

  def update 
  	connection = Connection.find_by_user_id(params[:id])
    if ["accepted"].include?(params[:status]) and ["friend", "follower"].include?(params[:relation])
      connection.update_attributes(:status => params[:status], :relation => params[:relation]) 
      current_user.connections.create(:status => params[:status], :relation => params[:relation],:connection_id => params[:id]) if params[:relation] == "friend"
    end
    User.remove_connection_records(connection.user_id, connection.connection_id) if connection.present? and "rejected" == params[:status]
    get_connections
  end

  def add_connection
    current_user.connections.create(:connection_id => @user.id, :status => "pending")
    redirect_to @user
  end

  def brack_connection
    User.remove_connection_records(@user.id, current_user.id)
    redirect_to @user
  end

  def get_connections
    @requester, @friends, @followers, @pendings = current_user.inverse_requesters, current_user.friends, current_user.inverse_followers, current_user.pendings 
  end


end
