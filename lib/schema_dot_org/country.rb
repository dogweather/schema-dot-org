# frozen_string_literal: true

require 'schema_dot_org'

module SchemaDotOrg
  # Model the Schema.org `Thing > Place > AdministrativeArea > Country`
  # See http://schema.org/Country
  class Country < SchemaType
    attr_accessor :name

    validates :name, type: String, presence: true

    def _to_json_struct
      {
        'name' => name
      }
    end
  end
end
