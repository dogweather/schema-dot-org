# frozen_string_literal: true


#
# Model the Schema.org `ContactPoint`.  See http://schema.org/ContactPoint
#
module SchemaDotOrg
  class ContactPoint < SchemaType
    validated_attr :area_served,         type: Array,   allow_nil: true
    validated_attr :available_language,  type: Array,   allow_nil: true
    validated_attr :contact_option,      type: String,  allow_nil: true
    validated_attr :contact_type,        type: String,  presence:  true
    validated_attr :telephone,           type: String,  presence:  true
  end
end
