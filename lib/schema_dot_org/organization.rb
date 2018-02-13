require 'schema_dot_org'


module SchemaDotOrg
  class Organization < SchemaType
    attr_accessor :founding_location, :email, :name, :url

    validates :email,             type: String
    validates :founding_location, type: Place
    validates :name,              type: String
    validates :url,               type: String

    def to_json_struct
      {
        "@type" => "Organization",
        "name" => name,
        "email" => email,
        "url" => url,
        "foundingLocation" => founding_location.to_json_struct
      }
    end
  end
end