# frozen_string_literal: true

require 'date'
require 'schema_dot_org'
require 'schema_dot_org/person'
require 'schema_dot_org/place'


module SchemaDotOrg
  class Organization < SchemaType
    attr_accessor :email,
                  :founder,
                  :founding_date,
                  :founding_location,
                  :logo,
                  :name,
                  :url,
                  :same_as

    validates :email,             type: String, allow_nil: true
    validates :founder,           type: SchemaDotOrg::Person, allow_nil: true
    validates :founding_date,     type: Date, allow_nil: true
    validates :founding_location, type: SchemaDotOrg::Place, allow_nil: true
    validates :logo,              type: String, allow_nil: true
    validates :name,              type: String
    validates :url,               type: String, allow_nil: true
    validates :same_as,           type: Array, allow_nil: true

    def _to_json_struct
      {
        "name" => name,
        "email" => email,
        "url" => url,
        "logo" => logo,
        "founder" => founder&.to_json_struct,
        "foundingDate" => founding_date&.to_s,
        "foundingLocation" => founding_location&.to_json_struct,
        "sameAs" => same_as
      }
    end
  end
end
