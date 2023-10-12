require 'json'
require 'validated_object'

module SchemaDotOrg
  class SchemaType < ValidatedObject::Base
    ROOT_ATTR = { "@context" => "http://schema.org" }.freeze
    UNQUALIFIED_CLASS_NAME_REGEX = /([^:]+)$/


    def to_s
      json_string = to_json_ld(pretty: (!rails_production? && !ENV['SCHEMA_DOT_ORG_MINIFIED_JSON']))

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
      { "@type" => un_namespaced_classname }.merge(_to_json_struct.reject { |_, v| v.blank? })
    end


    def _to_json_struct
      attrs_and_values
    end


    # @return the classname without the module namespace.
    def un_namespaced_classname
      self.class.name =~ UNQUALIFIED_CLASS_NAME_REGEX
      Regexp.last_match(1)
    end

    def object_to_json_struct(object)
      return nil unless object
      object.to_json_struct
    end

    private

    def attrs_and_values
      attrs.map { |attr| [attr.to_s.delete_prefix('@'), instance_variable_get(attr)] }.to_h
    end

    def attrs
      instance_variables.reject{ |v| [:@validation_context, :@errors].include?(v) }
    end

    def rails_production?
      defined?(Rails) && Rails.env.production?
    end
  end
end
