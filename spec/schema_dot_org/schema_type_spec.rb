require 'spec_helper'
require 'schema_dot_org'

module SchemaDotOrg
  class TestClass < SchemaType
    attr_accessor :name, :description
  end
end

RSpec.describe SchemaDotOrg::SchemaType do
  let(:test_instance) do
    SchemaDotOrg::TestClass.new(
      name: 'Test Item',
      description: 'A test item'
    )
  end

  describe '#to_json_struct' do
    context 'when Rails 7.1 validation context is present' do
      before do
        # Simulate Rails 7.1 behavior by adding validation context
        test_instance.instance_variable_set(:@context_for_validation, 'validation_context')
      end

      it 'excludes validation context from JSON output' do
        json_struct = test_instance.to_json_struct

        # The validation context should not appear in the output
        expect(json_struct).not_to include('contextForValidation')

        # The regular attributes should still be present
        expect(json_struct).to include(
          '@type' => 'TestClass',
          'name' => 'Test Item',
          'description' => 'A test item'
        )
      end
    end
  end
end
