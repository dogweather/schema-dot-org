# frozen_string_literal: true

require 'schema_dot_org'
require 'schema_dot_org/product'


module SchemaDotOrg
  # Model the Schema.org `ItemListElement`.  See https://schema.org/ItemListElement
  class ListItem < SchemaType
    validated_attr :position,      type: Integer, presence: true
    validated_attr :url,           type: String, allow_nil: true
    validated_attr :name,          type: String, allow_nil: true
    validated_attr :image,         type: String, allow_nil: true

    validated_attr :item,         type: Product, allow_nil: true

    def _to_json_struct
      {
        'position' => position,
        'url' => url,
        'name' => name,
        'image' => image,
        'item' => object_to_json_struct(item)
      }
    end
  end
end
