# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org'


RSpec.describe SchemaDotOrg::Person do
  # Note: In JSON-LD, multiple values for a property are represented as arrays.
  # This is different from XML where elements can repeat. JSON objects cannot have
  # duplicate keys, so arrays are the standard way to represent multiple values.
  # See: https://www.w3.org/TR/json-ld/#sets-and-lists
  let(:alice) do
    SchemaDotOrg::Person.new(
      name:     'Alice',
      same_as:  [
        'https://wikipedia.org/alice',
        'https://twitter.com/alice',
      ],
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
        'sameAs' => [
          'https://wikipedia.org/alice',
          'https://twitter.com/alice',
        ],
        'alumniOf' => {
          '@type' => 'CollegeOrUniversity',
          'name'  => 'University of Pennsylvania',
          'url'   => 'https://upenn.edu',
        },
      )
    end
  end

  describe '#to_json_ld' do
    it 'wraps the JSON in a script tag with the correct context' do
      expected_json = {
        '@context' => 'https://schema.org',
        '@type'    => 'Person',
        'name'     => 'Alice',
        'sameAs'   => [
          'https://wikipedia.org/alice',
          'https://twitter.com/alice',
        ],
        'alumniOf' => {
          '@type' => 'CollegeOrUniversity',
          'name'  => 'University of Pennsylvania',
          'url'   => 'https://upenn.edu',
        },
      }.to_json

      expect(alice.to_json_ld).to eq(
        "<script type=\"application/ld+json\">\n#{expected_json}\n</script>"
      )
    end
  end
end
