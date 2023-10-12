# frozen_string_literal: true


module SchemaDotOrg
  # Model the Schema.org `Thing > Place`.  See http://schema.org/Place
  class Place < SchemaType
    validated_attr :address, type: String, presence: true
  end
end
