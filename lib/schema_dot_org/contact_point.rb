# frozen_string_literal: true

require 'schema_dot_org'


module SchemaDotOrg
  # Model the Schema.org `ContactPoint`.  See http://schema.org/ContactPoint
  class ContactPoint < SchemaType
    attr_accessor :telephone,
                  :contact_type,
                  :contact_option,
                  :area_served,
                  :available_language

    validates :telephone,           type: String, presence: true
    validates :contact_type,        type: String, presence: true
    validates :contact_option,      type: String, allow_nil: true
    validates :area_served,         type: Array, allow_nil: true
    validates :available_language,  type: Array, allow_nil: true

    def _to_json_struct
      {
        'telephone' => telephone,
        'contactType' => contact_type,
        'contactOption' => contact_option,
        'areaServed' => area_served,
        'availableLanguage' => available_language
      }
    end
  end
end
