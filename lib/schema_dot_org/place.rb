require 'json'
require 'validated_object'


module SchemaDotOrg
  # Model the Schema.org `Thing > Place`. 
  # http://schema.org/Place
  class Place < ValidatedObject::Base
    attr_accessor :address

    validates :address, presence: true
    validates :address, type: String

    def to_json
      to_json_struct.to_json
    end

    def to_json_struct
      {
        "@type" => "Place",
        address: self.address
      }
    end
  end
end