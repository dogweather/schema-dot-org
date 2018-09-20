# frozen_string_literal: true

require 'schema_dot_org'
require 'schema_dot_org/product'


module SchemaDotOrg
  # Model the Schema.org `ItemListElement`.  See https://schema.org/ItemListElement
  class ListItem < SchemaType
    attr_accessor :position, :item,
                  :url, :name, :image

    validates :position,      type: Integer, presence: true
    validates :url,           type: String, allow_nil: true
    validates :name,          type: String, allow_nil: true
    validates :image,         type: String, allow_nil: true

    validates :item,         type: Product, allow_nil: true

    def _to_json_struct
      {
        'position' => position,
        'url' => url,
        'name' => name,
        'image' => image,
        'item' => item.try(:to_json_struct),
      }
    end
  end
end
