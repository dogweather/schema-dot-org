# frozen_string_literal: true


module SchemaDotOrg
  # Model the Schema.org `Person`.  See http://schema.org/Person
  class Person < SchemaType
    # @return [String] the name of the person
    attr_reader :name

    # @return [String] the url of the person
    attr_reader :url
    
    # @return [Array<String>] the same_as urls of the person
    attr_reader :same_as

    validates :name,     type: String,  presence: true
    validates :url,      type: String,  allow_nil: true
    validates :same_as,  type: Array,   allow_nil: true


    def _to_json_struct
      {
        'name' => name,
        'url' => url,
        'same_as' => same_as
      }
    end
  end
end
