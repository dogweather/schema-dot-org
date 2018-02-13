require 'json'
require 'validated_object'
require 'schema_dot_org/version'

module SchemaDotOrg
  #
  # Base class for schema types. Refactors out common code.
  #
  class SchemaType < ValidatedObject::Base
     
    def to_s
      to_json_ld(pretty: true)
    end


    def to_json_ld(pretty: false)
      "<script type=\"application/ld+json\">\n" + to_json(pretty: pretty) + "\n</script>"
    end

    
    def to_json(pretty: false)
      if pretty
        JSON.pretty_generate(to_json_struct)
      else
        to_json_struct.to_json
      end
    end

  end
end
