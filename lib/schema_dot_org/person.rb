# frozen_string_literal: true

require 'schema_dot_org'


module SchemaDotOrg
  # Model the Schema.org `Person`.  See http://schema.org/Person
  class Person < SchemaType
    attr_accessor :name,
                  :url,
                  :same_as

    validates :name,              type: String, presence: true
    validates :url,               type: String, allow_nil: true
    validates :same_as,           type: Array, allow_nil: true

    def _to_json_struct
      {
        'name' => name,
        'url' => url,
        'same_as' => same_as
      }
    end
  end
end
