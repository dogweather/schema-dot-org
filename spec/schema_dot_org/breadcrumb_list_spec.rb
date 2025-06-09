# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org'
require 'uri'

# Test against Google's BreadcrumbList example.
# See https://developers.google.com/search/docs/appearance/structured-data/breadcrumb
#
# <script type="application/ld+json">
# {
#   "@context": "https://schema.org",
#   "@type": "BreadcrumbList",
#   "itemListElement": [{
#     "@type": "ListItem",
#     "position": 1,
#     "name": "Books",
#     "item": "https://example.com/books"
#   },{
#     "@type": "ListItem",
#     "position": 2,
#     "name": "Science Fiction",
#     "item": "https://example.com/books/sciencefiction"
#   },{
#     "@type": "ListItem",
#     "position": 3,
#     "name": "Award Winners"
#   }]
# }
# </script>



RSpec.describe SchemaDotOrg::BreadcrumbList do
  let(:breadcrumb_list) do
    SchemaDotOrg::BreadcrumbList.new(
      itemListElement: [
        SchemaDotOrg::ListItem.new(
          position: 1,
          name: 'Books',
          item: 'https://example.com/books',
        ),
        SchemaDotOrg::ListItem.new(
          position: 2,
          name: 'Science Fiction',
          item: 'https://example.com/books/sciencefiction',
        ),
        SchemaDotOrg::ListItem.new(
          position: 3,
          name: 'Award Winners',
        ),
      ]
    )
  end

  describe '#to_json_struct' do
    it 'has the correct attributes and values' do
      expect(breadcrumb_list.to_json_struct).to eq(
        '@type'  => 'BreadcrumbList',
        'itemListElement' => [
          {
            '@type'    => 'ListItem',
            'position' => 1,
            'name'     => 'Books',
            'item'     => 'https://example.com/books',
          },
          {
            '@type'    => 'ListItem',
            'position' => 2,
            'name'     => 'Science Fiction',
            'item'     => 'https://example.com/books/sciencefiction',
          },
          {
            '@type'    => 'ListItem',
            'position' => 3,
            'name'     => 'Award Winners',
          },
        ]
      )
    end

    it 'raises an error if the item is not a string or a SchemaType' do
      expect {
        breadcrumb_list.itemListElement = [
          SchemaDotOrg::ListItem.new(
            position: 1,
            name: 'Books',
            item: 123,
          ),
        ]
      }.to raise_error(ArgumentError)
    end

    it 'creates a valid BreadcrumbList with the new high-level API' do
      links = [
        { name: 'Books',           url: 'https://example.com/books' },
        { name: 'Science Fiction', url: 'https://example.com/books/sciencefiction' },
        { name: 'Award Winners'    },
      ]
      result = SchemaDotOrg::BreadcrumbList.from_links(links)

      expect(result.to_json_struct).to eq(breadcrumb_list.to_json_struct)
    end

    it 'raises an error if the url is not a valid web URL' do
      links = [
        { name: 'Books',           url: 'htts://example.com/books' },
        { name: 'Science Fiction', url: 'https://example.com/books/sciencefiction' },
        { name: 'Award Winners'    },
      ]
      expect {
        SchemaDotOrg::BreadcrumbList.from_links(links)
      }.to raise_error(ArgumentError)
    end

    it 'raises an error if the url is not a string' do
      links = [
        { name: 'Books',           url: 123 },
        { name: 'Science Fiction', url: 'https://example.com/books/sciencefiction' },
        { name: 'Award Winners'    },
      ]
      expect {
        SchemaDotOrg::BreadcrumbList.from_links(links)
      }.to raise_error(ArgumentError)
    end
  end
end
