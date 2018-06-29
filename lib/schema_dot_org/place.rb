# frozen_string_literal: true

require 'schema_dot_org'
require 'schema_dot_org/postal_address'

module SchemaDotOrg
  # Model the Schema.org `Thing > Place`.  See http://schema.org/Place
  class Place < SchemaType
    attr_accessor :address

    validates :address, type: SchemaDotOrg::PostalAddress, presence: true

    def _to_json_struct
      {
        'address' => address.to_json_struct
      }
    end
  end
end
