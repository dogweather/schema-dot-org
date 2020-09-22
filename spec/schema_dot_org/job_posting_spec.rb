# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org/job_posting'


RSpec.describe SchemaDotOrg::JobPosting do # rubocop:disable Metrics/BlockLength
  let!(:google_required) do
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
      job_location_type: job_location_type,
      valid_through: valid_through
    }
  end

  let(:posting_fields) { google_required }
  let(:posting) { SchemaDotOrg::JobPosting.new(posting_fields) }

  let!(:date_posted) { Date.new(2018, 1, 24) }
  let!(:description) { '<p>Become a test driver for AutoMoto Inc.</p><p>Drive <em>latest cars</em> before anyone else!</p>' }
  let!(:hiring_organization) { SchemaDotOrg::Organization.new(name: 'AutoMoto Inc.') }
  let!(:job_location) { SchemaDotOrg::Place.new(address: postal_address) }
  let!(:job_location_type) { 'TELECOMMUTE' }
  let(:postal_address) { SchemaDotOrg::PostalAddress.new(street_address: '3300 Bloor Street') }
  let!(:title) { 'Test Driver' }
  let!(:employment_type) { ['FULL_TIME', 'CONTRACTOR'] }
  let!(:identifier) { SchemaDotOrg::PropertyValue.new(name: 'posting_id', value: '54371') }
  let!(:valid_through) { DateTime.new(2018, 1, 30) }
  let(:fields) { google_required.merge(google_optional) }

  describe '#new' do
    it "will not create a JobPosting without all required fields" do
      google_required.keys.each do |required_field|
        expect{ SchemaDotOrg::JobPosting.new(google_required.except(required_field)) }.to raise_error(ArgumentError)
      end
    end

    it 'creates a JobPosting when given required fields' do
      expect{ SchemaDotOrg::JobPosting.new(google_required) }.to_not raise_error
    end

    it 'creates a JobPosting when given TELECOMMUTE as job_location_type field and no job_location' do
      expect{ SchemaDotOrg::JobPosting.new(google_required.except(:job_location).merge(job_location_type: job_location_type)) }.to_not raise_error
    end

    it 'will not create a JobPosting with an unknown field' do
      expect{ SchemaDotOrg::JobPosting.new(google_required.merge(author: 'James Bond')) }.to raise_error(NoMethodError)
    end

    it 'will create a JobPosting with optional fields' do
      expect{ SchemaDotOrg::JobPosting.new(fields) }.to_not raise_error
    end
  end

  describe '#to_json_struct' do
    context 'when remote job' do
      it 'has exactly the correct attributes and values' do
        expect(SchemaDotOrg::JobPosting.new(fields).to_json_struct).to eq(
                                              '@type' => 'JobPosting',
                                              'datePosted' => date_posted.iso8601,
                                              'description' => description,
                                              'hiringOrganization' => hiring_organization.to_json_struct,
                                              'jobLocationType' => job_location_type,
                                              'title' => title,
                                              'employmentType' => employment_type,
                                              'identifier' => identifier.to_json_struct,
                                              'validThrough' => valid_through.iso8601
                                          )
      end
    end

    context 'when office job' do
      let(:job_location_type) { nil }

      it 'has exactly the correct attributes and values' do
        expect(SchemaDotOrg::JobPosting.new(fields).to_json_struct).to eq(
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
  end

  describe '#to_json' do
    context 'when remote job' do
      it 'generates the expected string' do
        expect(SchemaDotOrg::JobPosting.new(fields).to_json).to eq "{\"@type\":\"JobPosting\",\"datePosted\":\"#{date_posted}\",\
\"description\":\"#{description}\",\"employmentType\":#{employment_type.to_json},\"hiringOrganization\":#{hiring_organization.to_json},\
\"identifier\":#{identifier.to_json},\"title\":\"#{title}\",\"validThrough\":\"#{valid_through}\",\"jobLocationType\":\"#{job_location_type}\"}"
      end
    end

    context 'when office job' do
      let(:job_location_type) { nil }

      it 'generates the expected string' do
        expect(SchemaDotOrg::JobPosting.new(fields).to_json).to eq "{\"@type\":\"JobPosting\",\"datePosted\":\"#{date_posted}\",\
\"description\":\"#{description}\",\"employmentType\":#{employment_type.to_json},\"hiringOrganization\":#{hiring_organization.to_json},\
\"identifier\":#{identifier.to_json},\"title\":\"#{title}\",\"validThrough\":\"#{valid_through}\",\"jobLocation\":[#{job_location.to_json}]}"
      end
    end
  end

  describe '#to_json_ld' do
    context 'when remote job' do
      it 'generates the expected string' do
        expect(SchemaDotOrg::JobPosting.new(fields).to_json_ld).to eq "<script type=\"application/ld+json\">\n{\"@context\":\"http://schema.org\",\
\"@type\":\"JobPosting\",\"datePosted\":\"#{date_posted}\",\"description\":\"#{description}\",\
\"employmentType\":#{employment_type.to_json},\"hiringOrganization\":#{hiring_organization.to_json},\
\"identifier\":#{identifier.to_json},\"title\":\"#{title}\",\
\"validThrough\":\"#{valid_through}\",\"jobLocationType\":\"#{job_location_type}\"}\n</script>"
      end
    end

    context 'when office job' do
      let(:job_location_type) { nil }

      it 'generates the expected string' do
        expect(SchemaDotOrg::JobPosting.new(fields).to_json_ld).to eq "<script type=\"application/ld+json\">\n{\"@context\":\"http://schema.org\",\
\"@type\":\"JobPosting\",\"datePosted\":\"#{date_posted}\",\"description\":\"#{description}\",\
\"employmentType\":#{employment_type.to_json},\"hiringOrganization\":#{hiring_organization.to_json},\
\"identifier\":#{identifier.to_json},\"title\":\"#{title}\",\"validThrough\":\"#{valid_through}\",\
\"jobLocation\":[#{job_location.to_json}]}\n</script>"
      end
    end
  end
end
