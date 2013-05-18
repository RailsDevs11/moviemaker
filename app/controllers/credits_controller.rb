class CreditsController < ApplicationController
  before_filter :authenticate_user!
    
  def index
    @total_credits = current_user.credits
    @credit = current_user.exist_credits.new
    @credit_types = FacetTag.credit_type_tag.collect { |x| x.tag_name }
  end

  def new

   end

  def show
    @credit = current_user.credits.find(params[:id])
  end

  def edit
    @credit = current_user.credits.find(params[:id])
    @credit_types = FacetTag.credit_type_tag.collect { |x| x.tag_name }
  end

  def create
    @credit = current_user.exist_credits.new(params[:credit])
    @credit.credit_type_list = params[:credit_type]
    
    if @credit.save
      redirect_to user_profile_path, notice: 'Credit was successfully created.'
    else
      @total_credits = current_user.credits
      @credit_types = FacetTag.credit_type_tag.collect { |x| x.tag_name }
      privacy_data
      @image = Image.new
      render :action => 'new', :layout => 'user_settings'
    end
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to user_profile_path, notice: 'Credit was successfully updated.'
    else
      credits_data
      privacy_data
      @image = Image.new
      render action: "edit", :layout => "user_settings"
    end
  end

  def destroy
    @credit = current_user.credits.find(params[:id])
    @credit.destroy
    redirect_to credits_url
  end

end
