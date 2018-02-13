require 'date'
require 'schema_dot_org'


module SchemaDotOrg
  class Organization < SchemaType
    attr_accessor :email, :founder, :founding_date, :founding_location, :logo, :name, :same_as, :url

    validates :email,             type: String
    validates :founder,           type: Person
    validates :founding_date,     type: Date
    validates :founding_location, type: Place
    validates :logo,              type: String
    validates :name,              type: String
    validates :same_as,           type: String
    validates :url,               type: String

    def to_json_struct
      {
        "@type" => "Organization",
        "name" => name,
        "email" => email,
        "url" => url,
        "logo" => logo,
        "same_as" => same_as,
        "founder" => founder.to_json_struct,
        "foundingDate" => founding_date.to_s,
        "foundingLocation" => founding_location.to_json_struct
      }
    end
  end
end