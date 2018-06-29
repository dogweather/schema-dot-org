# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org/place'

RSpec.describe SchemaDotOrg::Place do # rubocop:disable Metrics/BlockLength
  let(:postal_address) { SchemaDotOrg::PostalAddress.new(street_address: '3300 Bloor Street') }
  let(:home) { SchemaDotOrg::Place.new(address: postal_address) }

  describe "#new" do
    it 'will not create a Place without an address' do
      expect { SchemaDotOrg::Place.new }.to raise_error(ArgumentError)
    end

    it 'creates a Place when given an address' do
      expect { home }
    end

    it 'will not create a Place with an unknown attribute' do
      expect do
        SchemaDotOrg::Place.new(
          address: postal_address,
          author: 'Hemmingway'
        )
      end.to raise_error(NoMethodError)
    end
  end

  describe "#to_json_struct" do
    it "has exactly the correct attributes and values" do
      expect(home.to_json_struct).to eq(
        '@type' => 'Place',
        'address' => postal_address.to_json_struct
      )
    end
  end

  describe "#to_json" do
    it "generates the expected string" do
      expect(home.to_json).to eq "{\"@type\":\"Place\",\"address\":#{postal_address.to_json}}"
    end
  end

  describe "#to_json_ld" do
    it "generates the expected string" do
      expect(home.to_json_ld).to eq "<script type=\"application/ld+json\">\n{\"@context\":\"http://schema.org\",\"@type\":\"Place\",\"address\":#{postal_address.to_json}}\n</script>"
    end
  end

  describe "#to_s" do
    it "generates the same string as #to_json_ld(pretty: true)" do
      expect(home.to_s).to eq "<script type=\"application/ld+json\">\n{\n  \"@context\": \"http://schema.org\",\n\
  \"@type\": \"Place\",\n\
  \"address\": {\n\
    \"@type\": \"PostalAddress\",\n\
    \"streetAddress\": \"3300 Bloor Street\"\n\
  }\n}\n</script>"
    end
  end
end
