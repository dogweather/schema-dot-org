# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org/property_value'


RSpec.describe SchemaDotOrg::PropertyValue do # rubocop:disable Metrics/BlockLength
  let(:property_value) { SchemaDotOrg::PropertyValue.new(name: 'My Property', value: '123') }

  describe '#new' do
    it 'will not create a PropertyValue without a name' do
      expect { SchemaDotOrg::PropertyValue.new(value: '123') }.to raise_error(ArgumentError)
    end

    it 'will not create a PropertyValue without a value' do
      expect { SchemaDotOrg::PropertyValue.new(name: 'My Property') }.to raise_error(ArgumentError)
    end

    it 'creates a PropertyValue when given name and value strings' do
      expect { SchemaDotOrg::PropertyValue.new(name: 'My Property', value: '123') }
    end

    it 'will not create a PropertyValue with an unknown attribute' do
      expect do
        SchemaDotOrg::PropertyValue.new(name: 'My Property', size: 'Small')
      end.to raise_error(NoMethodError)
    end
  end

  describe '#to_json_struct' do
    it 'has exactly the correct attributes and values' do
      expect(property_value.to_json_struct).to eq('@type' => 'PropertyValue', 'name' => 'My Property', 'value' => '123')
    end
  end

  describe '#to_json' do
    it 'generates the expected string' do
      expect(property_value.to_json).to eq '{"@type":"PropertyValue","name":"My Property","value":"123"}'
    end
  end

  describe '#to_json_ld' do
    it 'generates the expected string' do
      expect(property_value.to_json_ld).to eq "<script type=\"application/ld+json\">\n{\"@context\":\"http://schema.org\",\
\"@type\":\"PropertyValue\",\"name\":\"My Property\",\"value\":\"123\"}\n</script>"
    end
  end
end
