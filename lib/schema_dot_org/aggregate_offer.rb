# frozen_string_literal: true

require 'date'
require 'schema_dot_org'
require 'schema_dot_org/offer'

# Model the Schema.org `Thing > Place`.  See https://schema.org/Offer
#
module SchemaDotOrg
  class AggregateOffer < SchemaType
    attr_accessor :priceCurrency,
                  :highPrice,
                  :lowPrice,
                  :offerCount,
                  :offers

    validates :lowPrice,       type: Numeric
    validates :highPrice,      type: Numeric, allow_nil: true
    validates :offerCount,     type: String, allow_nil: true
    validates :offers,         type: Array, allow_nil: true

    def _to_json_struct
      {
        "priceCurrency" => priceCurrency,
        "lowPrice" => lowPrice,
        "highPrice" => highPrice,
        "offerCount" => offerCount,
        "offers" => offers.map(&:to_json_struct)
      }
    end

    def offers
      @offers || []
    end
  end
end
