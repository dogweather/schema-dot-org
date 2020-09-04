# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'spec_helper'
require 'schema_dot_org/web_site'
require 'schema_dot_org/search_action'

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

    it 'creates correct json with the optional attributes' do
      site_with_search = WebSite.new(
        name: 'Texas Public Law',
        url: 'https://texas.public.law',
        potential_action: SearchAction.new(
          target: 'https://texas.public.law/?search={search_term_string}',
          query_input: 'required name=search_term_string'
        )
      )

      expect(site_with_search.to_json_struct).to eq(
        '@type' => 'WebSite',
        'name' => 'Texas Public Law',
        'url' => 'https://texas.public.law',
        'potentialAction' => {
          '@type' => 'SearchAction',
          'target' => 'https://texas.public.law/?search={search_term_string}',
          'query_input' => 'required name=search_term_string'
        }
      )
    end
  end
end
# rubocop:enable Metrics/BlockLength
