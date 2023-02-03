# frozen_string_literal: true

require 'date'

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

    validates :email,             type: String
    validates :founder,           type: SchemaDotOrg::Person
    validates :founding_date,     type: Date
    validates :founding_location, type: SchemaDotOrg::Place
    validates :logo,              type: String
    validates :name,              type: String
    validates :url,               type: String
    validates :same_as,           type: Array, allow_nil: true

    def _to_json_struct
      {
        'name' => name,
        'email' => email,
        'url' => url,
        'logo' => logo,
        'founder' => founder.to_json_struct,
        'foundingDate' => founding_date.to_s,
        'foundingLocation' => founding_location.to_json_struct,
        'sameAs' => same_as
      }
    end
  end
end
