# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org/search_action'


RSpec.describe SchemaDotOrg::SearchAction do # rubocop:disable Metrics/BlockLength
  describe "#new" do
    it 'will not create a SearchAction without attributes' do
      expect { SchemaDotOrg::SearchAction.new }.to raise_error(ArgumentError)
    end

    it 'creates a SearchAction when given a target and query input' do
      expect do
        SchemaDotOrg::SearchAction.new(
          target:      'https://www.oregonlaws.org/?search={search_term_string}',
          query_input: 'required name=search_term_string'
        )
      end.to_not raise_error
    end
  end


  describe "#to_json_struct" do
    it "has exactly the correct attributes and values" do
      action = SchemaDotOrg::SearchAction.new(
        target: 'https://www.oregonlaws.org/?search={search_term_string}',
        query_input: 'required name=search_term_string'
      )

      expect(action.to_json_struct).to eq(
        'target' =>      'https://www.oregonlaws.org/?search={search_term_string}',
        'query_input' => 'required name=search_term_string',
        '@type' =>   'SearchAction'
      )
    end
  end
end
