require 'json'
require 'validated_object'
require 'schema_dot_org/version'

module SchemaDotOrg
  #
  # Base class for schema types. Refactors out common code.
  #
  class SchemaType < ValidatedObject::Base
    ROOT_ATTR = {"@context" => "http://schema.org"}

     
    def to_s
      json_string = to_json_ld(pretty: true)

      # Mark as safe if we're in Rails
      if json_string.respond_to?(:html_safe)
        json_string.html_safe
      else
        json_string
      end
    end


    def to_json_ld(pretty: false)
      "<script type=\"application/ld+json\">\n" + to_json(pretty: pretty, as_root: true) + "\n</script>"
    end

    
    def to_json(pretty: false, as_root: false)
      structure = as_root ? ROOT_ATTR.merge(to_json_struct) : to_json_struct

      if pretty
        JSON.pretty_generate(structure)
      else
        structure.to_json
      end
    end


    # Use the class name to create the "@type" attribute.
    # @return a hash structure representing json.
    def to_json_struct
      { "@type" => un_namespaced_classname }.merge( _to_json_struct )
    end


    def _to_json_struct
      raise "For subclasses to implement"
    end


    # @return the classname without the module namespace.
    def un_namespaced_classname
      self.class.name =~ /([^:]+)$/
      $1
    end
  end
end
