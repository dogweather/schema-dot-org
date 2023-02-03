# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org'

RSpec.describe SchemaDotOrg::Place do # rubocop:disable Metrics/BlockLength
  let(:home) { SchemaDotOrg::Place.new(address: 'Las Vegas, NV') }

  describe '#new' do
    it 'will not create a Place without an address' do
      expect { SchemaDotOrg::Place.new }.to raise_error(ArgumentError)
    end

    it 'creates a Place when given an address string' do
      expect { SchemaDotOrg::Place.new(address: 'NY, NY') }
    end

    it 'will not create a Place with an unknown attribute' do
      expect do
        SchemaDotOrg::Place.new(
          address: '12345 Happy Street',
          author: 'Hemmingway'
        )
      end.to raise_error(NoMethodError)
    end
  end

  describe '#to_json_struct' do
    it 'has exactly the correct attributes and values' do
      expect(home.to_json_struct).to eq(
        '@type' => 'Place',
        'address' => 'Las Vegas, NV'
      )
    end
  end

  describe '#to_json' do
    it 'generates the expected string' do
      expect(home.to_json).to eq '{"@type":"Place","address":"Las Vegas, NV"}'
    end
  end

  describe '#to_json_ld' do
    it 'generates the expected string' do
      expect(home.to_json_ld).to eq "<script type=\"application/ld+json\">\n{\"@context\":\"http://schema.org\",\"@type\":\"Place\",\"address\":\"Las Vegas, NV\"}\n</script>"
    end
  end

  describe '#to_s' do
    it 'generates the same string as #to_json_ld(pretty: true)' do
      expect(home.to_s).to eq "<script type=\"application/ld+json\">\n{\n  \"@context\": \"http://schema.org\",\n  \"@type\": \"Place\",\n  \"address\": \"Las Vegas, NV\"\n}\n</script>"
    end
  end
end
