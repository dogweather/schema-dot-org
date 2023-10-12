# frozen_string_literal: true


#
# Model the Schema.org `Thing > CreativeWork > WebSite`.
# @See http://schema.org/WebSite
#
module SchemaDotOrg
  class WebSite < SchemaType
    validated_attr :name,             type: String, presence: true
    validated_attr :potential_action, type: SchemaDotOrg::SearchAction, allow_nil: true
    validated_attr :url,              type: String, presence: true
  end
end
