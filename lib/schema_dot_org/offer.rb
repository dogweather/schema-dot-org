# frozen_string_literal: true

require 'date'
require 'schema_dot_org'

# Model the Schema.org `Thing > Place`.  See https://schema.org/Offer
#
module SchemaDotOrg
  class Offer < SchemaType
    attr_accessor :priceCurrency,
                  :price,
                  :availability

    validates :priceCurrency,       type: String
    validates :price,               type: Float
    validates :availability,        type: String

    def _to_json_struct
      {
        "price" => price,
        "priceCurrency" => priceCurrency,
        "availability" => availability
      }
    end
  end
end
