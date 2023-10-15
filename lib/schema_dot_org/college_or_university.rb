# frozen_string_literal: true


#
# Model the Schema.org **Person**.  See http://schema.org/Person
#
module SchemaDotOrg
  class CollegeOrUniversity < SchemaType
    validated_attr :name, type: String, presence: true
    validated_attr :url,  type: String, allow_nil: true
  end
end
