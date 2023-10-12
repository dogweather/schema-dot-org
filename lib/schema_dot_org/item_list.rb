# frozen_string_literal: true

require 'schema_dot_org'

module SchemaDotOrg
  # Model the Schema.org `ItemList`.  See https://schema.org/ItemList
  class ItemList < SchemaType
    attr_accessor :itemListOrder,
                  :numberOfItems,
                  :url,
                  :image,
                  :itemListElement

    
    validates :itemListElement,   type: Array,    presence: true
    validates :itemListOrder,     type: String,   allow_nil: true
    validates :numberOfItems,     type: Integer,  allow_nil: true

    validates :url,               type: String,   allow_nil: true
    validates :image,             type: String,   allow_nil: true


    def _to_json_struct
      {
        'itemListOrder' => itemListOrder,
        'numberOfItems' => numberOfItems,
        'url' => url,
        'image' => image,
        'itemListElement' => itemListElement.map(&:to_json_struct)
      }
    end

    def itemListElement
      @itemListElement || []
    end
  end
end
