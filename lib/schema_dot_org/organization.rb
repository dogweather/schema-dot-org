# frozen_string_literal: true

require 'date'
require 'schema_dot_org'
require 'schema_dot_org/person'
require 'schema_dot_org/place'


module SchemaDotOrg
  class Organization < SchemaType
    attr_accessor :email, :founder, :founding_date, :founding_location, :logo, :name, :url

    validates :email,             type: String
    validates :founder,           type: SchemaDotOrg::Person
    validates :founding_date,     type: Date
    validates :founding_location, type: SchemaDotOrg::Place
    validates :logo,              type: String
    validates :name,              type: String
    validates :url,               type: String

    def _to_json_struct
      {
        "name" => name,
        "email" => email,
        "url" => url,
        "logo" => logo,
        "founder" => founder.to_json_struct,
        "foundingDate" => founding_date.to_s,
        "foundingLocation" => founding_location.to_json_struct
      }
    end
  end
end
