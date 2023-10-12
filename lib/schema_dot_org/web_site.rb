# frozen_string_literal: true


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
        'potentialAction' => object_to_json_struct(potential_action)
      }
    end
  end
end
