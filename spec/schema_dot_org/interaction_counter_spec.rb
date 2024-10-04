# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org'

RSpec.describe SchemaDotOrg::InteractionCounter do
  let(:interaction) do
    SchemaDotOrg::InteractionCounter.new(
      userInteractionCount: 5,
      interactionType: 'https://schema.org/ViewAction',
    )
  end

  describe '#to_json_struct' do
    it 'has the correct attributes and values' do
      expect(interaction.to_json_struct).to eq(
        '@type'  => 'InteractionCounter',
        'userInteractionCount' => 5,
        'interactionType' => 'https://schema.org/ViewAction',
      )
    end
  end
end
