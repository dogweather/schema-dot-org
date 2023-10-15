# frozen_string_literal: true

require 'date'

require_relative 'person'
require_relative 'place'

module SchemaDotOrg
  class Organization < SchemaType
    validated_attr :contact_points,    type: Array, allow_nil: true
    validated_attr :email,             type: String, allow_nil: true
    validated_attr :founder,           type: SchemaDotOrg::Person, allow_nil: true
    validated_attr :founding_date,     type: Date, allow_nil: true
    validated_attr :founding_location, type: SchemaDotOrg::Place, allow_nil: true
    validated_attr :legal_name,        type: String, allow_nil: true
    validated_attr :logo,              type: String
    validated_attr :name,              type: String
    validated_attr :same_as,           type: Array, allow_nil: true
    validated_attr :slogan,            type: String, allow_nil: true
    validated_attr :telephone,         type: String, allow_nil: true
    validated_attr :url,               type: String
  end
end
