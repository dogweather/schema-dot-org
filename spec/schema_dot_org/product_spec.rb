# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'spec_helper'
require 'schema_dot_org'


RSpec.describe SchemaDotOrg::Product do
  describe "#new" do
    it 'will not create with an unknown attribute' do
      expect do
        Product.new(
          snack_time:       'today',
          name:             'Public.Law',
          url:              'https://www.public.law',
          image:          [
            'https://twitter.com/law_is_code',
            'https://www.facebook.com/PublicDotLaw'
          ]
        )
      end.to raise_error(NoMethodError)
    end

    it 'creates correct json correctly' do
      public_law = Product.new(
        name:             'Public.Law',
        description:      'Product description',
        offers: SchemaDotOrg::AggregateOffer.new(
          lowPrice: 99.33,
          highPrice: 200.00,
          priceCurrency: 'AED',
          offers: [
            SchemaDotOrg::Offer.new(price: 45, priceCurrency: 'AED'),
            SchemaDotOrg::Offer.new(price: 55.0, priceCurrency: 'AED')
          ]
        ),
        url:              'https://www.public.law',
        image:          [
          'https://twitter.com/law_is_code',
          'https://www.facebook.com/PublicDotLaw'
        ]
      )

      expect(public_law.to_json_struct).to eq(
        "@type" => "Product",
        'name' => "Public.Law",
        'description' => 'Product description',
        'url' => "https://www.public.law",
        'offers' => {
          "@type" => "AggregateOffer",
          'lowPrice' => 99.33,
          'highPrice' => 200.00,
          'priceCurrency' => 'AED',
          'offers' => [
            {
              "@type" => "Offer",
              "price" => 45.0,
              "priceCurrency" => 'AED'
            },
            {
              "@type" => "Offer",
              "price" => 55.0,
              "priceCurrency" => 'AED'
            }
          ]
        },
        'image' => [
          'https://twitter.com/law_is_code',
          'https://www.facebook.com/PublicDotLaw'
        ]
      )
    end
  end
end
# rubocop:enable Metrics/BlockLength
