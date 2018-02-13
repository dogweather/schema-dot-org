require 'json'
require 'validated_object'


module SchemaDotOrg
  # Model the Schema.org `Thing > Place`. 
  # http://schema.org/Place
  class Place < ValidatedObject::Base
    attr_accessor :address

    validates :address, presence: true
    validates :address, type: String

     
    # TODO: Move this boilerplate to a parent class

    def to_json_ld
      "<script type=\"application/ld+json\">\n" + to_json + "\n</script>"
    end

    def to_json(pretty: false)
      if pretty
        JSON.pretty_generate(to_json_struct)
      else
        to_json_struct.to_json
      end
    end

    def to_json_struct
      {
        "@type" => "Place",
        address: self.address
      }
    end
  end
end