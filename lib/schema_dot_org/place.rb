# frozen_string_literal: true


#
# Model the Schema.org `Thing > Place`.  See http://schema.org/Place
#
module SchemaDotOrg
  class Place < SchemaType
    validated_attr :address, type: String, presence: true
  end
end
