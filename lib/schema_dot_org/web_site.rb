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
        'name' => name,
        'url' => url,
        'potentialAction' => potential_action&.to_json_struct
      }
    end
  end
end
