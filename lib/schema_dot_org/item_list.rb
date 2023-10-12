# frozen_string_literal: true

require 'schema_dot_org'

#
# Model the Schema.org `ItemList`.  See https://schema.org/ItemList
#
module SchemaDotOrg
  class ItemList < SchemaType
    validated_attr :itemListElement,   type: Array,    presence: true
    validated_attr :itemListOrder,     type: String,   allow_nil: true
    validated_attr :numberOfItems,     type: Integer,  allow_nil: true

    validated_attr :url,               type: String,   allow_nil: true
    validated_attr :image,             type: String,   allow_nil: true
  end
end
