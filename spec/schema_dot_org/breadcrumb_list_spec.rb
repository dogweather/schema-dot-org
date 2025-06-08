# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org'

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
  end
end
