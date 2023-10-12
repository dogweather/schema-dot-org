# frozen_string_literal: true

require 'date'
require 'schema_dot_org'
require 'schema_dot_org/person'
require 'schema_dot_org/place'
require 'schema_dot_org/contact_point'


module SchemaDotOrg
  class Organization < SchemaType
    attr_accessor :email,
                  :telephone,
                  :founder,
                  :founding_date,
                  :founding_location,
                  :logo,
                  :name,
                  :url,
                  :same_as,
                  :contact_points

    validates :email,             type: String, allow_nil: true
    validates :telephone,         type: String, allow_nil: true
    validates :founder,           type: SchemaDotOrg::Person, allow_nil: true
    validates :founding_date,     type: Date, allow_nil: true
    validates :founding_location, type: SchemaDotOrg::Place, allow_nil: true
    validates :logo,              type: String
    validates :name,              type: String
    validates :url,               type: String
    validates :same_as,           type: Array, allow_nil: true
    validates :contact_points,    type: Array, allow_nil: true

    def _to_json_struct
      {
        "name" => name,
        "email" => email,
        "telephone" => telephone,
        "url" => url,
        "logo" => logo,
        "founder" => object_to_json_struct(founder),
        "foundingDate" => founding_date.to_s,
        "foundingLocation" => object_to_json_struct(founding_location),
        "sameAs" => same_as,
        "contactPoint" => contact_points.map(&:to_json_struct)
      }
    end

    def contact_points
      @contact_points || []
    end
  end
end
