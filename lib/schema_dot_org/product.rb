# frozen_string_literal: true


#
# Model the Schema.org `Thing > Product`.  See https://schema.org/Product
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
