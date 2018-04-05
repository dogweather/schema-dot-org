# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'spec_helper'
require 'schema_dot_org/organization'
require 'schema_dot_org/person'
require 'schema_dot_org/place'

Organization = SchemaDotOrg::Organization
Person       = SchemaDotOrg::Person
Place        = SchemaDotOrg::Place


RSpec.describe Organization do
  describe "#new" do
    it 'creates correct json correctly' do
      public_law = Organization.new(
        name:             'Public.Law',
        founder:           Person.new(name: 'Robb Shecter'),
        founding_date:     Date.new(2009, 3, 6),
        founding_location: Place.new(address: 'Portland, OR'),
        email:            'say_hi@public.law',
        url:              'https://www.public.law',
        logo:             'https://www.public.law/favicon-196x196.png',
        same_as:          [
          'https://twitter.com/law_is_code',
          'https://www.facebook.com/PublicDotLaw'
        ]
      )

      expect(public_law.to_json_struct).to eq(
        {
          "@type" => "Organization",
          'name' => "Public.Law",
          'email' => "say_hi@public.law",
          'url' => "https://www.public.law",
          'logo' => "https://www.public.law/favicon-196x196.png",
          'foundingDate' => "2009-03-06",
          'founder' => {
            "@type" => "Person",
            'name' => "Robb Shecter"
          },
          'foundingLocation' => {
            "@type" => "Place",
            'address' => "Portland, OR"
          },
          'sameAs' => [
            'https://twitter.com/law_is_code',
            'https://www.facebook.com/PublicDotLaw'
          ]
        }
      )
    end
  end
end
# rubocop:enable Metrics/BlockLength
