# frozen_string_literal: true

require 'schema_dot_org'

module SchemaDotOrg
  # Model the Schema.org `Thing > Intangible > StructuredValue > ContactPoint > PostalAddress`.
  # See http://schema.org/PostalAddress
  class PostalAddress < SchemaType
    attr_accessor :street_address, :address_locality, :address_region, :postal_code, :address_country

    validates :street_address,   type: String, allow_nil: true
    validates :address_locality, type: String, allow_nil: true
    validates :address_region,   type: String, allow_nil: true
    validates :postal_code,      type: String, allow_nil: true
    validates :address_country,  type: String, allow_nil: true

    def _to_json_struct
      {
        'streetAddress' => street_address,
        'addressLocality' => address_locality,
        'addressRegion' => address_region,
        'postalCode' => postal_code,
        'addressCountry' => address_country
      }
    end
  end
end
