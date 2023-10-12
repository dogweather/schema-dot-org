# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org'


WebSite      = SchemaDotOrg::WebSite
SearchAction = SchemaDotOrg::SearchAction

RSpec.describe WebSite do
  describe '#new' do
    it 'creates correct json without optional attributes' do
      basic_site = WebSite.new(
        name: 'Texas Public Law',
        url: 'https://texas.public.law'
      )

      expect(basic_site.to_json_struct).to eq(
        '@type' => 'WebSite',
        'name' => 'Texas Public Law',
        'url' => 'https://texas.public.law'
      )
    end

    context 'when optional attributes are given' do
      let(:site_with_search) do
        WebSite.new(
          name: 'Texas Public Law',
          url: 'https://texas.public.law',
          potential_action: SearchAction.new(
            target: 'https://texas.public.law/search?term={search_term_string}',
            query_input: 'required name=search_term_string'
          )
        )
      end

      it 'generates this json' do
        expect(site_with_search.to_json_struct).to eq(
          '@type' => 'WebSite',
          'name' => 'Texas Public Law',
          'url' => 'https://texas.public.law',
          'potentialAction' => {
            '@type' => 'SearchAction',
            'target' => 'https://texas.public.law/search?term={search_term_string}',
            'query-input' => 'required name=search_term_string'
          }
        )
      end
    end
  end
end
