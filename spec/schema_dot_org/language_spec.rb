# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org'

RSpec.describe SchemaDotOrg::Language do
  let(:language) do
    SchemaDotOrg::Language.new(
      name: "English",
      alternateName: 'en',
    )
  end

  describe '#to_json_struct' do
    it 'has the correct attributes and values' do
      expect(language.to_json_struct).to eq(
        '@type'  => 'Language',
        'name' => 'English',
        'alternateName' => 'en',
      )
    end
  end
end
