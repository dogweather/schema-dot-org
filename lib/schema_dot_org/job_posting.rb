# frozen_string_literal: true

require 'schema_dot_org'
require 'schema_dot_org/organization'
require 'schema_dot_org/property_value'
require 'schema_dot_org/country'

module SchemaDotOrg
  # Model the Schema.org `Thing > Intangible > JobPosting`.
  # See https://schema.org/JobPosting
  class JobPosting < SchemaType
    attr_accessor :date_posted,
                  :description,
                  :employment_type,
                  :hiring_organization,
                  :identifier,
                  :job_location,
                  :job_location_type,
                  :applicant_location_requirements,
                  :title,
                  :valid_through

    validates :date_posted,         type: Date, presence: true
    validates :description,         type: String, presence: true
    validates :employment_type,     type: Array, allow_nil: true
    validates :hiring_organization, type: SchemaDotOrg::Organization, presence: true
    validates :identifier,          type: SchemaDotOrg::PropertyValue, allow_nil: true
    validates :job_location_type,   type: String, allow_nil: true
    validates :applicant_location_requirements, type: SchemaDotOrg::Country, allow_nil: true
    validates_presence_of :applicant_location_requirements, if: -> jp { jp.job_location_type == 'TELECOMMUTE' }
    validates :job_location,        type: Array, allow_nil: true # array to allow multi-location job postings
    validates_presence_of :job_location, unless: -> jp { jp.job_location_type == 'TELECOMMUTE' }
    validates :title,               type: String, presence: true
    validates :valid_through,       type: DateTime, allow_nil: true


    def _to_json_struct
      struct = {
        'datePosted' => date_posted.iso8601,
        'description' => description,
        'employmentType' => employment_type,
        'hiringOrganization' => hiring_organization.to_json_struct,
        'identifier' => identifier&.to_json_struct,
        'title' => title,
        'validThrough' => valid_through&.iso8601
      }

      if job_location_type == 'TELECOMMUTE'
        struct.merge('jobLocationType' => job_location_type,
                     'applicantLocationRequirements' => applicant_location_requirements.to_json_struct)
      else
        struct.merge('jobLocation' => job_locations)
      end
    end

    private

    def job_locations
      job_location.map(&:to_json_struct)
    end
  end
end
