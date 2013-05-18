class SessionsController < Devise::SessionsController
layout 'cinimaker_home'

  def new
    @image = Image.new
    @i_am_a = FacetTag.iama_type_tag.collect { |x| x.tag_name }
    @unions = FacetTag.union_type_tag.collect { |x| x.tag_name }
    super
  end

  def create
    super
  end
end
