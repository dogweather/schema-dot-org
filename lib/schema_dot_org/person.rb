# frozen_string_literal: true


module SchemaDotOrg
  # Model the Schema.org `Person`.  See http://schema.org/Person
  class Person < SchemaType
    # @return [String]
    attr_reader :name
    validates   :name, type: String, presence: true

    # @return [String]
    attr_reader :url
    validates   :url, type: String, allow_nil: true
    
    # @return [Array<String>]
    attr_reader :same_as
    validates   :same_as, type: Array, allow_nil: true


    def _to_json_struct
      {
        'name'    => name,
        'url'     => url,
        'same_as' => same_as
      }
    end
  end
end
