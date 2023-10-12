# frozen_string_literal: true


module SchemaDotOrg
  # Model the Schema.org **Person**.  See http://schema.org/Person
  class Person < SchemaType
    validated_attr :name,    type: String, presence: true
    validated_attr :same_as, type: Array,  allow_nil: true
    validated_attr :url,     type: String, allow_nil: true


    def _to_json_struct
      {
        'name'    => name,
        'url'     => url,
        'same_as' => same_as
      }
    end
  end
end
