# frozen_string_literal: true

#
# Model the Schema.org `Thing > Intangible > StructuredValue > InteractionCounter`.  See https://schema.org/InteractionCounter
#
module SchemaDotOrg
  class InteractionCounter < SchemaType
    validated_attr :userInteractionCount, type: Numeric, presence: true
    validated_attr :interactionType,      type: String,  presence: true
  end
end
