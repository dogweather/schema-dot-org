# frozen_string_literal: true


#
# Model the Schema.org `Thing > SearchAction`.  See http://schema.org/SearchAction
#
module SchemaDotOrg
  class SearchAction < SchemaDotOrg::SchemaType
    validated_attr :query_input, type: String, presence: true
    validated_attr :target,      type: String, presence: true
  end
end
