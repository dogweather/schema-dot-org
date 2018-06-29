# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org/job_posting'


RSpec.describe SchemaDotOrg::JobPosting do # rubocop:disable Metrics/BlockLength
  let(:google_required) do
    {
      date_posted: date_posted,
      description: description,
      hiring_organization: hiring_organization,
      job_location: [job_location],
      title: title
    }
  end

  let(:google_optional) do
    {
      employment_type: employment_type,
      identifier: identifier,
      valid_through: valid_through
    }
  end

  let(:posting_fields) { google_required }
  let(:posting) { SchemaDotOrg::JobPosting.new(posting_fields) }

  let!(:date_posted) { Date.new(2018, 1, 24) }
  let!(:description) { '<p>Become a test driver for AutoMoto Inc.</p><p>Drive <em>latest cars</em> before anyone else!</p>' }
  let!(:hiring_organization) { SchemaDotOrg::Organization.new(name: 'AutoMoto Inc.') }
  let!(:job_location) { SchemaDotOrg::Place.new(address: postal_address) }
  let(:postal_address) { SchemaDotOrg::PostalAddress.new(street_address: '3300 Bloor Street') }
  let!(:title) { 'Test Driver' }
  let!(:employment_type) { ['FULL_TIME', 'CONTRACTOR'] }
  let!(:identifier) { SchemaDotOrg::PropertyValue.new(name: 'posting_id', value: '54371') }
  let!(:valid_through) { DateTime.new(2018, 1, 30) }

  describe '#new' do
    it "will not create a JobPosting without all required fields" do
      google_required.keys.each do |required_field|
        posting_fields.except!(required_field)
        expect { posting }.to raise_error(ArgumentError)
      end
    end

    it 'creates a JobPosting when given required fields' do
      expect { posting }
    end

    it 'will not create a JobPosting with an unknown field' do
      posting_fields.merge!(author: 'James Bond')
      expect { posting }.to raise_error(NoMethodError)
    end

    it 'will create a JobPosting with optional fields' do
      posting_fields.merge!(google_optional)
      expect { posting }
    end
  end

  describe '#to_json_struct' do
    it 'has exactly the correct attributes and values' do
      posting_fields.merge!(google_optional)
      expect(posting.to_json_struct).to eq(
                                         '@type' => 'JobPosting',
                                         'datePosted' => date_posted.iso8601,
                                         'description' => description,
                                         'hiringOrganization' => hiring_organization.to_json_struct,
                                         'jobLocation' => [job_location.to_json_struct],
                                         'title' => title,
                                         'employmentType' => employment_type,
                                         'identifier' => identifier.to_json_struct,
                                         'validThrough' => valid_through.iso8601
                                        )
    end
  end

  describe '#to_json' do
    it 'generates the expected string' do
      posting_fields.merge!(google_optional)
      expect(posting.to_json).to eq "{\"@type\":\"JobPosting\",\"datePosted\":\"#{date_posted}\",\
\"description\":\"#{description}\",\"employmentType\":#{employment_type.to_json},\"hiringOrganization\":#{hiring_organization.to_json},\
\"identifier\":#{identifier.to_json},\"jobLocation\":[#{job_location.to_json}],\"title\":\"#{title}\",\"validThrough\":\"#{valid_through}\"}"
    end
  end

  describe '#to_json_ld' do
    before { posting_fields.merge!(google_optional) }

    it 'generates the expected string' do
      expect(posting.to_json_ld).to eq "<script type=\"application/ld+json\">\n{\"@context\":\"http://schema.org\",\
\"@type\":\"JobPosting\",\"datePosted\":\"#{date_posted}\",\"description\":\"#{description}\",\
\"employmentType\":#{employment_type.to_json},\"hiringOrganization\":#{hiring_organization.to_json},\
\"identifier\":#{identifier.to_json},\"jobLocation\":[#{job_location.to_json}],\"title\":\"#{title}\",\
\"validThrough\":\"#{valid_through}\"}\n</script>"
    end
  end
end
