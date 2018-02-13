require 'schema_dot_org'


module SchemaDotOrg
  class Organization < SchemaType
    attr_accessor :founding_location

    validates :founding_location, presence: true
    validates :founding_location, type: Place

    def to_json_struct
      {
        "@type" => "Organization",
        "foundingLocation" => founding_location.to_json_struct
      }
    end
  end
end