require 'json'


module SchemaDotOrg
  # Model the Schema.org `Thing > Place`. 
  # http://schema.org/Place
  class Place < SchemaType
    attr_accessor :address

    validates :address, presence: true
    validates :address, type: String

    def to_json_struct
      {
        "@type" => "Place",
        address: self.address
      }
    end
  end
end