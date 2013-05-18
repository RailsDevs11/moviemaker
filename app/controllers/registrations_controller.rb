class RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [ :create]
  layout 'sign_up_layout'
  
  def new
    @image = Image.new
    @i_am_a = FacetTag.iama_type_tag.collect { |x| x.tag_name }
    @unions = FacetTag.union_type_tag.collect { |x| x.tag_name }
    super
  end
  
  def create
    build_resource
    @image = Image.new(params[:image])
    if resource.valid?
      assign_user_tag(resource) if params[:tag_flag].blank?#assign selected tag for user 
      if resource.save 
        image = resource.images.create(params[:image])
        resource.update_attribute(:avatar_id, image.id) if image.present?
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_navigational_format?
          sign_in(resource_name, resource)
          respond_with resource, :location => after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
          expire_session_data_after_sign_in!
          respond_with resource, :location => after_inactive_sign_up_path_for(resource)
        end
      end
    else
      clean_up_passwords resource
      @i_am_a = FacetTag.iama_type_tag.collect { |x| x.tag_name }
      @unions = FacetTag.union_type_tag.collect { |x| x.tag_name }
      respond_with resource
    end
  end
    
  def edit
    @image = Image.new
    privacy_data
    credits_data
    render :edit, :layout => 'user_settings'
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    if resource.update_without_password(resource_params)
      image = current_user.avatar
      if image.present?
        image.update_attributes(params[:image]) 
      else
        image = resource.images.create(params[:image])
        resource.update_attribute(:avatar_id, image.id) if image.present?
      end
      set_flash_message :notice, :updated if is_navigational_format?
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => user_profile_path
    else
      @image = Image.new(params[:image])
      clean_up_passwords resource
      @image.image_cache = params[:image]['image']
      render :edit, :layout => false
    end
  end  

  def assign_user_tag(resource)
    resource.iama_list = "#{params[:iamas]['Primary']},#{params[:iamas]['Secondary']},#{params[:iamas]['Tertiary']}"
    resource.union_list = "#{params[:unions]['Primary']},#{params[:unions]['Secondary']},#{params[:unions]['Tertiary']}"
    resource.primary_list = "#{params[:iamas]['Primary']},#{params[:unions]['Primary']}"
    resource.secondary_list = "#{params[:iamas]['Secondary']},#{params[:unions]['Secondary']}"
    resource.tertiary_list = "#{params[:iamas]['Tertiary']},#{params[:unions]['Tertiary']}"
  end  
  
end 
