# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org/postal_address'

RSpec.describe SchemaDotOrg::PostalAddress do # rubocop:disable Metrics/BlockLength
  let(:postal_address_properties) do
    {
      street_address: '3300 Bloor Street',
      address_locality: 'Toronto',
      address_region: 'Ontario',
      postal_code: '1a2 3b4',
      address_country: 'CA'
    }
  end
  let(:postal_address) { SchemaDotOrg::PostalAddress.new(postal_address_properties) }

  describe '#new' do
    it 'creates a PostalAddress when given properties' do
      expect { postal_address }
    end

    it 'will not create a PostalAddress with an unknown attribute' do
      expect do
        SchemaDotOrg::PostalAddress.new(
          street_address: '3300 Bloor Street',
          house_color: 'yellow'
        )
      end.to raise_error(NoMethodError)
    end
  end

  describe "#to_json_struct" do
    it "has exactly the correct attributes and values" do
      expect(postal_address.to_json_struct).to eq(
                                       '@type' => 'PostalAddress',
                                       'streetAddress' => postal_address_properties[:street_address],
                                       'addressLocality' => postal_address_properties[:address_locality],
                                       'addressRegion' => postal_address_properties[:address_region],
                                       'postalCode' => postal_address_properties[:postal_code],
                                       'addressCountry' => postal_address_properties[:address_country]
                                     )
    end
  end

  describe "#to_json" do
    it "generates the expected string" do
      expect(postal_address.to_json).to eq "{\"@type\":\"PostalAddress\",\"streetAddress\":\"#{postal_address_properties[:street_address]}\",\
\"addressLocality\":\"#{postal_address_properties[:address_locality]}\",\"addressRegion\":\"#{postal_address_properties[:address_region]}\",\
\"postalCode\":\"#{postal_address_properties[:postal_code]}\",\"addressCountry\":\"#{postal_address_properties[:address_country]}\"}"
    end
  end

  describe "#to_json_ld" do
    it "generates the expected string" do
      expect(postal_address.to_json_ld).to eq "<script type=\"application/ld+json\">\n{\"@context\":\"http://schema.org\",\
\"@type\":\"PostalAddress\",\"streetAddress\":\"#{postal_address_properties[:street_address]}\",\
\"addressLocality\":\"#{postal_address_properties[:address_locality]}\",\"addressRegion\":\"#{postal_address_properties[:address_region]}\",\
\"postalCode\":\"#{postal_address_properties[:postal_code]}\",\"addressCountry\":\"#{postal_address_properties[:address_country]}\"}\n</script>"
    end
  end

  describe "#to_s" do
    it "generates the same string as #to_json_ld(pretty: true)" do
      expect(postal_address.to_s).to eq "<script type=\"application/ld+json\">\n{\n  \"@context\": \"http://schema.org\",\n\
  \"@type\": \"PostalAddress\",\n  \"streetAddress\": \"#{postal_address_properties[:street_address]}\",\n\
  \"addressLocality\": \"#{postal_address_properties[:address_locality]}\",\n  \"addressRegion\": \"#{postal_address_properties[:address_region]}\",\n\
  \"postalCode\": \"#{postal_address_properties[:postal_code]}\",\n  \"addressCountry\": \"#{postal_address_properties[:address_country]}\"\n}\n</script>"
    end
  end
end
