# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'spec_helper'
require 'schema_dot_org/item_list'
require 'schema_dot_org/list_item'
require 'schema_dot_org/product'
require 'schema_dot_org/aggregate_offer'

ItemList          = SchemaDotOrg::ItemList
ListItem          = SchemaDotOrg::ListItem
Product           = SchemaDotOrg::Product
AggregateOffer    = SchemaDotOrg::AggregateOffer

RSpec.describe Product do
  describe "#new" do
    it 'will not create with an unknown attribute' do
      expect do
        ItemList.new(
          snack_time:       'today',
          name:             'Public.Law',
          image:          [
            'https://twitter.com/law_is_code',
            'https://www.facebook.com/PublicDotLaw'
          ]
        )
      end.to raise_error(NoMethodError)
    end

    it 'creates correct json correctly' do
      public_law = ItemList.new(
        itemListOrder: 'Ascending',
        numberOfItems: 2,
        itemListElement: [
          ListItem.new(
            position: 1,
            item: Product.new(
              name: 'Product Name',
              offers: AggregateOffer.new(
                lowPrice: 99.33,
                highPrice: 200.00,
                priceCurrency: 'AED',
              ),
              url: 'https://www.public.law',
              image: [
                'https://twitter.com/law_is_code',
                'https://www.facebook.com/PublicDotLaw'
              ]
            )
          ),
          ListItem.new(
            position: 2,
            item: Product.new(
              name: 'Product Name 1',
              offers: AggregateOffer.new(
                lowPrice: 99.33,
                highPrice: 200.00,
                priceCurrency: 'AED',
              ),
              url: 'https://www.public.law',
              image: [
                'https://twitter.com/law_is_code',
                'https://www.facebook.com/PublicDotLaw'
              ]
            )
          )
        ]
      )

      expect(public_law.to_json_struct).to eq(
        "@type" => "ItemList",
        "itemListOrder" => "Ascending",
        "numberOfItems" => 2,
        "itemListElement" => [
          {
            "@type" => "ListItem",
            "position" => 1,
            "item" => {
              "@type" => "Product",
              "name" => 'Product Name',
              'url' => "https://www.public.law",
              'offers' => {
                "@type" => "AggregateOffer",
                'lowPrice' => 99.33,
                'highPrice' => 200.00,
                'priceCurrency' => 'AED',
              },
              'image' => [
                'https://twitter.com/law_is_code',
                'https://www.facebook.com/PublicDotLaw'
              ]
            }
          },
          {
            "@type" => "ListItem",
            "position" => 2,
            "item" => {
              "@type" => "Product",
              "name" => 'Product Name 1',
              'url' => "https://www.public.law",
              'offers' => {
                "@type" => "AggregateOffer",
                'lowPrice' => 99.33,
                'highPrice' => 200.00,
                'priceCurrency' => 'AED',
              },
              'image' => [
                'https://twitter.com/law_is_code',
                'https://www.facebook.com/PublicDotLaw'
              ]
            }
          }
        ]
      )
    end
  end
end
# rubocop:enable Metrics/BlockLength
