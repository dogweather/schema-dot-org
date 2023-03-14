# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org/country'

RSpec.describe SchemaDotOrg::Country do # rubocop:disable Metrics/BlockLength
  let(:country) { SchemaDotOrg::Country.new(country_properties) }

  let(:country_properties) do
    { name: 'Canada' }
  end

  describe '#new' do
    it 'will not create a Country without properties' do
      expect { SchemaDotOrg::Country.new }.to raise_error(ArgumentError)
    end

    it 'creates a Country when given properties' do
      expect { country }
    end

    it 'will not create a Country with an unknown attribute' do
      expect do
        SchemaDotOrg::Country.new(name: 'Canada', max_horse_power: 220)
      end.to raise_error(NoMethodError)
    end
  end

  describe '#to_json_struct' do
    it 'has exactly the correct attributes and values' do
      expect(country.to_json_struct).to eq('@type' => 'Country', 'name' => country_properties[:name])
    end
  end

  describe '#to_json' do
    it 'generates the expected string' do
      expect(country.to_json).to eq "{\"@type\":\"Country\",\"name\":\"#{country_properties[:name]}\"}"
    end
  end

  describe '#to_json_ld' do
    it 'generates the expected string' do
      expect(country.to_json_ld).to eq "<script type=\"application/ld+json\">\n{\"@context\":\"http://schema.org\",\
\"@type\":\"Country\",\"name\":\"#{country_properties[:name]}\"}\n</script>"
    end
  end

  describe '#to_s' do
    it 'generates the same string as #to_json_ld(pretty: true)' do
      expect(country.to_s).to eq "<script type=\"application/ld+json\">\n{\n  \"@context\": \"http://schema.org\",\n\
  \"@type\": \"Country\",\n  \"name\": \"#{country_properties[:name]}\"\n}\n</script>"
    end
  end
end
