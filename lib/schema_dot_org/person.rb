require 'schema_dot_org'


module SchemaDotOrg
  # Model the Schema.org `Person`.  See http://schema.org/Person
  class Person < SchemaType

    attr_accessor :name
    validates :name, type: String, presence: true


    def _to_json_struct
      {
        name: self.name
      }
    end
  end
end