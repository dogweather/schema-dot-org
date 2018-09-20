# frozen_string_literal: true

require 'schema_dot_org'
require 'schema_dot_org/search_action'


module SchemaDotOrg
  # Model the Schema.org `Thing > CreativeWork > WebSite`.
  # @See http://schema.org/WebSite
  class WebSite < SchemaType
    attr_accessor :name, :url, :potential_action
    validates :name,             type: String, presence: true
    validates :url,              type: String, presence: true
    validates :potential_action, type: SchemaDotOrg::SearchAction, allow_nil: true

    def _to_json_struct
      {
        'name' => self.name,
        'url' =>  self.url,
        'potentialAction' => self.potential_action.try(:to_json_struct)
      }
    end
  end
end
