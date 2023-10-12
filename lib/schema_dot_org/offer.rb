# frozen_string_literal: true

require 'date'
require 'schema_dot_org'

# Model the Schema.org `Thing > Place`.  See https://schema.org/Offer
#
module SchemaDotOrg
  class Offer < SchemaType
    validated_attr :priceCurrency,       type: String
    validated_attr :price,               type: Numeric
    validated_attr :availability,        type: String, allow_nil: true
    validated_attr :url,                 type: String, allow_nil: true

    def _to_json_struct
      {
        "price" => price,
        "priceCurrency" => priceCurrency,
        "availability" => availability,
        "url" => url
      }
    end
  end
end
