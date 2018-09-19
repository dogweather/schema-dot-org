# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'spec_helper'
require 'schema_dot_org/product'
require 'schema_dot_org/offer'
require 'schema_dot_org/place'

Product = SchemaDotOrg::Product
Offer   = SchemaDotOrg::Offer


RSpec.describe Product do
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
        offers: Offer.new(
          price: 99.33,
          priceCurrency: 'AED',
          availability: 'http://schema.org/InStock'
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
          "@type" => "Offer",
          'price' => 99.33,
          'priceCurrency' => 'AED',
          'availability' => 'http://schema.org/InStock'
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
