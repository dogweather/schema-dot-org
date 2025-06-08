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

    validate :item_must_be_valid_type


    private

    def item_must_be_valid_type
      return if item.nil?
      return if item.is_a?(String)  # URL
      return if item.is_a?(SchemaDotOrg::SchemaType)  # Any Schema.org type

      errors.add(:item, 'must be a URL string or Schema.org object, but was: ' + item.class.name + ' (' + item.inspect + ')')
    end
  end
end
