require 'date'
require 'schema_dot_org'


module SchemaDotOrg
  class Organization < SchemaType
    attr_accessor :founding_date, :founding_location, :email, :name, :url

    validates :email,             type: String
    validates :founding_date,     type: Date
    validates :founding_location, type: Place
    validates :name,              type: String
    validates :url,               type: String

    def to_json_struct
      {
        "@type" => "Organization",
        "name" => name,
        "email" => email,
        "url" => url,
        "foundingDate" => founding_date.to_s,
        "foundingLocation" => founding_location.to_json_struct
      }
    end
  end
end