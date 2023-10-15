# frozen_string_literal: true


#
# https://schema.org/CollegeOrUniversity
#
module SchemaDotOrg
  class CollegeOrUniversity < SchemaType
    validated_attr :name, type: String, presence: true
    validated_attr :url,  type: String, allow_nil: true
  end
end
