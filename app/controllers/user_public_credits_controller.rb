class UserPublicCreditsController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :access_user_object_required!
  layout :choose_user_public_layout
  
  def index
    @credits = @user.credits
    @credit_tags = FacetTag.credit_type_tag.collect { |x| x.tag_name }
  end

  def show 
    render :text => "ok"
  end

  def choose_user_public_layout
    if ["index"].include?(params[:action])
      return 'user_public_content'
    else
      return 'user_public_individual_content' 
    end
  end


  
end
