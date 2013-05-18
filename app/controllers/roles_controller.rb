class RolesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :cini
  load_and_authorize_resource :role, :through => :cini
  layout 'cini_layout'

  
  def index
    @cini = Cini.find(params[:cini_id])
    @role = Role.new
    2.times {@role.images.build}    
  end

  def create
    @cini = Cini.find(params[:cini_id])
    @role = @cini.roles.new(params[:role])
    if @role.save 
      flash[:notice] = 'Role was successfully created.'	
      redirect_to user_cini_roles_path(@cini.id)
    else	
      flash[:error] = 'Unable to create role.'	
      render 'index'
    end
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(params[:role])
      flash[:notice] = 'Role was successfully updated.'	
      redirect_to user_cini_roles_path(@cini.id)
    else
      flash[:error] = 'Unable to update role.'
      render :edit
    end
  end  

  def destroy
    role = Role.find(params[:id])
    role.destroy
    flash[:notice] = 'Role was successfully deleted.'
    redirect_to user_cini_roles_path(@cini.id)
  end

  def set_admin
    if @cini.update_attributes(params[:cini])
      flash[:notice] = 'Role was successfully updated.' 
      redirect_to user_cini_roles_path(@cini.id)
    else
      flash[:error] = 'Unable to update role.'
      render :index
    end
  end  

  def show
    @role = Role.find(params[:id])
    redirect_to user_cini_roles_path(@role.cini) and return unless @role.is_unfill?
    @users = User.find(:all)
  end  

  def invite
    @role = Role.find(params[:id])
    cini_role = CiniRole.new(:cini_id => @cini.id, :role_id => @role.id, :user_id => params[:user_id], :requester_id => current_user.id )
    flash[:notice] = 'User was successfully invited.' if cini_role.save
    redirect_to user_cini_role_path(@cini, @role)
  end  

  def un_assign_role
    @role.cini_roles.destroy_all
    redirect_to user_cini_roles_path(@cini)
  end

  def accept_role_request
    render :text => "ok"
  end

end
