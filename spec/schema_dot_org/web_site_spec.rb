# typed: ignore
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

    context 'when optional attributes are given' do
      let(:site_with_search) do
        WebSite.new(
          name: 'Oregon Public Law',
          url: 'https://oregon.public.law',
          potential_action: SearchAction.new(
            target: 'https://oregon.public.law/search?term={search_term_string}',
            query_input: 'required name=search_term_string'
          )
        )
      end

      it 'creates correct json' do
        expect(site_with_search.to_json_struct).to eq(
          '@type' => 'WebSite',
          'name' => 'Oregon Public Law',
          'url' => 'https://oregon.public.law',
          'potentialAction' => {
            '@type' => 'SearchAction',
            'target' => 'https://oregon.public.law/search?term={search_term_string}',
            'query-input' => 'required name=search_term_string'
          }
        )
      end

      it 'creates correct HTML' do
        expected_html = <<~STRING_OUTPUT
          <script type="application/ld+json">
          {
            "@context": "http://schema.org",
            "@type": "WebSite",
            "name": "Oregon Public Law",
            "url": "https://oregon.public.law",
            "potentialAction": {
              "@type": "SearchAction",
              "target": "https://oregon.public.law/search?term={search_term_string}",
              "query-input": "required name=search_term_string"
            }
          }
          </script>
        STRING_OUTPUT

        expect(site_with_search.to_s).to eq(expected_html.strip)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
