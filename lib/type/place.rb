require 'validated_object'


module Type
  class Place < ValidatedObject::Base
    attr_accessor :address

    validates :address, presence: true
    validates :address, type: String

    def to_json_struct
      {
        address: self.address,
        "@type" => "Place"
      }
    end
  end
end