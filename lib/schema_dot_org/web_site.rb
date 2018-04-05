# frozen_string_literal: true

require 'schema_dot_org'


module SchemaDotOrg
  # Model the Schema.org `Thing > CreativeWork > WebSite`.
  # @See http://schema.org/WebSite
  class WebSite < SchemaType
    attr_accessor :name
    validates :name, type: String, presence: true

    attr_accessor :url
    validates :url, type: String, presence: true

    attr_accessor :potential_action
    validates :potential_action, type: SearchAction, allow_nil: true

    def _to_json_struct
      {
        name: self.name,
        url:  self.url
      }
    end
  end
end
