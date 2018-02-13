require 'schema_dot_org'


module SchemaDotOrg
  # Model the Schema.org `Person`.  See http://schema.org/Person
  class Person < SchemaType

    attr_accessor :name
    validates :name, presence: true
    validates :name, type: String


    def to_json_struct
      {
        "@type" => "Person",
        name: self.name
      }
    end
  end
end