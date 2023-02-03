# typed: ignore
# frozen_string_literal: true


module SchemaDotOrg
  # Model the Schema.org `Thing > SearchAction`.  See http://schema.org/SearchAction
  class SearchAction < SchemaType
    attr_accessor :target, :query_input
    validates :target,      type: String, presence: true
    validates :query_input, type: String, presence: true

    def _to_json_struct
      {
        'target' => target,
        'query-input' => query_input ## ! Note the hyphen.
      }
    end
  end
end
