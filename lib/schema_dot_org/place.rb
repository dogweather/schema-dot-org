# frozen_string_literal: true


module SchemaDotOrg
  # Model the Schema.org `Thing > Place`.  See http://schema.org/Place
  class Place < SchemaType
    attr_accessor :address
    validates :address, type: String, presence: true

    def _to_json_struct
      {
        'address' => address
      }
    end
  end
end
