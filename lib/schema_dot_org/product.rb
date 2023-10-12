# frozen_string_literal: true

require 'date'
require 'schema_dot_org'
require 'schema_dot_org/aggregate_offer'

#
# Model the Schema.org `Thing > Place`.  See https://schema.org/Product
#
module SchemaDotOrg
  class Product < SchemaType
    validated_attr :description,  type: String, allow_nil: true
    validated_attr :image,        type: Array,  allow_nil: true
    validated_attr :name,         type: String
    validated_attr :offers,       type: SchemaDotOrg::AggregateOffer
    validated_attr :url,          type: String
  end
end
