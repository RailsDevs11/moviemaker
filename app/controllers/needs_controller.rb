class NeedsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :cini
  load_and_authorize_resource :need, :through => :cini
  layout 'cini_layout'

  def index
    @need = Need.new
    @needs = @cini.needs 
    2.times {@need.images.build}    
  end

  def create
    @need = @cini.needs.new(params[:need])
    if @need.save 
      redirect_to user_cini_needs_path(@cini.id)
    else
      render 'index'
    end
  end

  def destroy
    need = Need.find(params[:id])
    need.destroy
    redirect_to user_cini_needs_path(@cini.id)
  end

  def edit
    @need = Need.find(params[:id])
  end

  def update
    @need = Need.find(params[:id])
    if @need.update_attributes(params[:need])
      redirect_to user_cini_needs_path(@cini, @need)
    else
      render :edit
    end
  end  
  
 
end
