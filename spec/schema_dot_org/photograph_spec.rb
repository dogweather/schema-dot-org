# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require 'spec_helper'
require 'schema_dot_org/organization'
require 'schema_dot_org/person'
require 'schema_dot_org/place'
require 'schema_dot_org/photograph'

Organization = SchemaDotOrg::Organization
Person       = SchemaDotOrg::Person
Place        = SchemaDotOrg::Place
Photography  = SchemaDotOrg::Photograph
ImageObject  = SchemaDotOrg::ImageObject


RSpec.describe Photograph do
  describe "#new" do
    it 'will not create with an unknown attribute' do
      expect do
        Photography.new(
          author:             'today',
          descr:              "get me wrong"
          )

      end.to raise_error(NoMethodError)
    end

    it 'creates correct json correctly' do
      org   = Organization.new(
            name:             "Holiday Pix",
            url:              "https://www.holiday.pix",
            address:          "hp street 1",
            email:            "info@holiday.pix",
            telephone:        "+4940124124"
            )
      photo = Photograph.new(
          author:             Person.new(name: 'The Photographer'),
          description:        'I took this picture while on vacation last year.',
          main_entity_of_page: '/pix/mexbe',
          thumbnail_url:      'mexico-beach_sm.jpg',
          url:                '/pix/mexbe',
          copyright_year:     '2008',
          encoding_format:    'image/jpeg',
          keywords:           'mexico, beach, vacation',
          associated_media:   ImageObject.new(
            content_url:      "mexico-beach.jpg",
            name:             "Beach in Mexico",
            author:           Person.new(name: 'The Photographer'),
            thumbnail_url:    "mexico-beach_sm.jpg",
            ),
          provider:           org,
          publisher:          org,
          source_organization:org
          )

      expect(photo.to_json_struct).to eq(
        "@type"       => "Photograph",
        "accessMode"  => "visual",
        "associatedMedia" => {
          "@type"           => "ImageObject",
          "author" => {
            "@type" => "Person",
            "name"  => "The Photographer"
          },
          "contentUrl"      => "mexico-beach.jpg",
          "name"            => "Beach in Mexico",
          "thumbnailUrl"    => "mexico-beach_sm.jpg",
          },
        "author" => {
          "@type" => "Person",
          "name"  => "The Photographer"
        },
        # "contentLocation" => "Puerto Vallarta, Mexico",
        # "datePublished"   => "2008-01-25",
        "description"     => "I took this picture while on vacation last year.",
        "url"             => "/pix/mexbe",
        "copyrightYear"   => "2008",
        "encodingFormat"  => "image/jpeg",
        "keywords"        => "mexico, beach, vacation",
        "mainEntityOfPage"=> "/pix/mexbe",
        "provider"        => {
          "@type"           => "Organization",
          "name"            => "Holiday Pix",
          "email"           => "info@holiday.pix",
          "url"             => "https://www.holiday.pix",
          "address"         => "hp street 1",
          "telephone"       => "+4940124124",
        },
        "publisher"       => {
          "@type"           => "Organization",
          "name"            => "Holiday Pix",
          "email"           => "info@holiday.pix",
          "url"             => "https://www.holiday.pix",
          "address"         => "hp street 1",
          "telephone"       => "+4940124124",
        },
        "sourceOrganization" => {
          "@type"           => "Organization",
          "name"            => "Holiday Pix",
          "email"           => "info@holiday.pix",
          "url"             => "https://www.holiday.pix",
          "address"         => "hp street 1",
          "telephone"       => "+4940124124",
        },
        "thumbnailUrl"    => "mexico-beach_sm.jpg",
        )
    end
  end
end
# rubocop:enable Metrics/BlockLength
