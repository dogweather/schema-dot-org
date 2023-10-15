# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org'


RSpec.describe SchemaDotOrg::Person do
  let(:alice) do 
    SchemaDotOrg::Person.new(
      name:     'Alice',
      same_as:  ['https://wikipedia.org/alice'],
      alumni_of: SchemaDotOrg::CollegeOrUniversity.new(
        name: 'University of Pennsylvania',
        url:  'https://upenn.edu',
      ),
    )
  end

  describe '#to_json_struct' do
    it 'has the correct attributes and values' do
      expect(alice.to_json_struct).to eq(
        '@type'  => 'Person',
        'name'   => 'Alice',
        'sameAs' => ['https://wikipedia.org/alice'],
      )
    end
  end
end
