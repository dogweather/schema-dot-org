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
                  :same_as,
                  :address,
                  :telephone

    validates :email,             type: String
    validates :founder,           type: SchemaDotOrg::Person, allow_nil: true
    validates :founding_date,     type: Date, allow_nil: true
    validates :founding_location, type: SchemaDotOrg::Place, allow_nil: true
    validates :logo,              type: String, allow_nil: true
    validates :name,              type: String
    validates :url,               type: String
    validates :same_as,           type: Array, allow_nil: true

    def _to_json_struct
      struct = {
        "name" => name,
        "email" => email,
        "url" => url,
        "logo" => logo,
        "address" => address,
        "telephone" => telephone
      }
      struct["founder"] = founder.to_json_struct if founder
      struct["foundingDate"] = founding_date.to_s if founding_date
      struct["foundingLocation"] = founding_location.to_json_struct if founding_location
      struct["sameAs"] = same_as if same_as
      struct
    end
  end
end
