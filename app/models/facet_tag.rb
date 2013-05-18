# This is how we'll keep track of accept tags for certain facet
# This is how we'll limit the facets for things like iama and 
# unions on User

# EX.
#   FacetTag.find_by_context("user.iama").tags

# TODO
#   Make a shortcut method for the above

class FacetTag < ActiveRecord::Base

  acts_as_taggable_on
  attr_accessible :tag_name, :context
  scope :iama_type_tag, -> { where(context: 'iamas') }
  scope :union_type_tag, -> { where(context: 'unions') }
  scope :credit_type_tag, -> { where(context: 'credit_type') }
end
