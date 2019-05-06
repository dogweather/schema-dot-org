# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'spec_helper'
require 'schema_dot_org/organization'
require 'schema_dot_org/person'
require 'schema_dot_org/place'
require 'schema_dot_org/photography'

Organization = SchemaDotOrg::Organization
Person       = SchemaDotOrg::Person
Place        = SchemaDotOrg::Place
Photography  = SchemaDotOrg::Photography
ImageObject  = SchemaDotOrg::ImageObject


RSpec.describe Photography do
  describe "#new" do
    it 'will not create with an unknown attribute' do
      expect do
        Photography.new(
          author:       'today',
          content_location:   Place.new(address: 'Portland, OR'),
          datePublished:      Date.new(2009, 3, 6),
          descr:              "get me wrong"
          )

      end.to raise_error(NoMethodError)
    end

    it 'creates correct json correctly' do
      public_law = Photography.new(
          author:             Person.new(name: 'The Photographer'),
          description:        'I took this picture while on vacation last year.',
          main_entity_of_page: '/pix/mexbe',
          thumbnail_url:      'mexico-beach_sm.jpg',
          url:                '/pix/mexbe',
          copyrightYear:      '2008',
          encoding_format:    'image/jpeg',
          keywords:           'mexico, beach, vacation',
          associated_media:   ImageObject.new(
            content_url:      "mexico-beach.jpg",
            name:             "Beach in Mexico",
            author:           Person.new(name: 'The Photographer'),
            thumbnail_url:    "mexico-beach_sm.jpg",
            ),
          provider:           Organization.new(
            name:              "Holiday Pix",
            url:               "https://www.holiday.pix",
            address:           "hp street 1",
            email:             "info@holiday.pix",
            telephone:         "+4940124124"
            ),
          publisher:          Organization.new(
            name:             "Holiday Pix",
            url:              "https://www.holiday.pix",
            address:          "hp street 1",
            email:            "info@holiday.pix",
            telephone:        "+4940124124"
            ),
          source_organization: Organization.new(
            name:             "Holiday Pix",
            url:              "https://www.holiday.pix",
            address:          "hp street 1",
            email:            "info@holiday.pix",
            telephone:        "+4940124124"
            )
          )


      expect(public_law.to_json_struct).to eq(
        "@context"    => "https://schema.org",
        "@type"       => "Photography",
        "accessMode"  => "visual",
        "associatedMedia" => {
          "@type"           => "ImageObject",
          "contentUrl"      => "mexico-beach.jpg",
          "name"            => "Beach in Mexico",
          "author" => {
            "@type" => "Person",
            "name"  => "The Photographer"
          },
          "thumbnailUrl"    => "mexico-beach_sm.jpg",
          },
        "author" => {
          "@type" => "Person",
          "name"  => "The Photographer"
        },
        "contentLocation" => "Puerto Vallarta, Mexico",
        "datePublished"   => "2008-01-25",
        "description"     => "I took this picture while on vacation last year.",
        "MainEntityOfPage"=> "/pix/mexbe",
        "thumbnailUrl"    => "mexico-beach_sm.jpg",
        "url"             => "/pix/mexbe",
        "copyrightYear"   => "2008",
        "encodingFormat"  => "image/jpeg",
        "keywords"        => "mexico, beach, vacation",
        "provider"        => {
          "@type"           => "Organization",
          "name"            => "Holiday Pix",
          "url"             => "https://www.holiday.pix",
          "email"           => "info@holiday.pix",
          "telephone"       => "+4940124124",
        },
        "publisher"       => {
          "@type"           => "Organization",
          "name"            => "Holiday Pix",
          "url"             => "https://www.holiday.pix",
          "email"           => "info@holiday.pix",
          "telephone"       => "+4940124124",
          },
        "sourceOrganization" => {
          "@type"           => "Organization",
          "name"            => "Holiday Pix",
          "url"             => "https://www.holiday.pix",
          "email"           => "info@holiday.pix",
          "telephone"       => "+4940124124",
          }
        )
    end
  end
end
# rubocop:enable Metrics/BlockLength
