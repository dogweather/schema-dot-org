# frozen_string_literal: true

require 'schema_dot_org'

module SchemaDotOrg
  # Model the Schema.org `Thing > Intangible > StructuredValue > PropertyValue`.
  # See https://schema.org/PropertyValue
  class PropertyValue < SchemaType
    attr_accessor :name,
                  :value

    validates :name,  type: String, presence: true
    validates :value, type: String, presence: true

    def _to_json_struct
      {
        'name' => name,
        'value' => value
      }
    end
  end
end
