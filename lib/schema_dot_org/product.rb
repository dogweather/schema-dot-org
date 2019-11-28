# frozen_string_literal: true

require 'date'
require 'schema_dot_org'
require 'schema_dot_org/aggregate_offer'

# Model the Schema.org `Thing > Place`.  See https://schema.org/Product
#
module SchemaDotOrg
  class Product < SchemaType
    attr_accessor :name,
                  :url,
                  :description,
                  :image,
                  :offers

    validates :name,              type: String
    validates :url,               type: String
    validates :description,       type: String, allow_nil: true
    validates :image,             type: Array, allow_nil: true
    validates :offers,            type: SchemaDotOrg::AggregateOffer

    def _to_json_struct
      {
        "name" => name,
        "url" => url,
        "description" => description,
        "image" => image,
        "offers" => offers.to_json_struct
      }
    end

    def image
      @image || []
    end
  end
end
