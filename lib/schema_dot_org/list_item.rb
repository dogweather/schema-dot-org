# frozen_string_literal: true


require_relative 'product'

#
# Model the Schema.org `ItemListElement`.  See https://schema.org/ItemListElement
#
module SchemaDotOrg
  class ListItem < SchemaType
    validated_attr :image,     type: String,                allow_nil: true
    validated_attr :item,      type: Object,                allow_nil: true  # Allow String or SchemaType
    validated_attr :name,      type: String,                allow_nil: true
    validated_attr :position,  type: Integer,               presence:  true
    validated_attr :url,       type: String,                allow_nil: true
  end
end
