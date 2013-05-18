module NeedsHelper

  def need_detail(need)
    # we need to change need on date in future 
    "#{need.title} in #{need.location} on #{need.created_at.to_date.to_formatted_s(:long)}"
  end

end
