# frozen_string_literal: true
#
#
# Model the Schema.org `Thing > Intangible > Language`.  See https://schema.org/Language
#
module SchemaDotOrg
  class Language < SchemaType
    validated_attr :alternateName, type: String, allow_nil: true
    validated_attr :name,          type: String, presence: true
  end
end
