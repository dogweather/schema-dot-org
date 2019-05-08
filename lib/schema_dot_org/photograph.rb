# frozen_string_literal: true

require 'date'
require 'schema_dot_org'
require 'schema_dot_org/person'
require 'schema_dot_org/organization'
require 'schema_dot_org/image_object'


module SchemaDotOrg
  class Photograph < SchemaType
    attr_accessor :author,
                  :description,
                  :main_entity_of_page,
                  :thumbnail_url,
                  :url,
                  :copyright_year,
                  :encoding_format,
                  :keywords,
                  :associated_media,
                  :provider,
                  :publisher,
                  :source_organization


    validates :author,              type: SchemaDotOrg::Person
    validates :description,         type: String
    validates :main_entity_of_page, type: String, allow_nil: true
    validates :thumbnail_url,       type: String
    validates :url,                 type: String
    validates :copyright_year,      type: String, allow_nil: true
    validates :encoding_format,     type: String
    validates :keywords,            type: String
    validates :associated_media,    type: SchemaDotOrg::ImageObject
    validates :provider,            type: SchemaDotOrg::Organization, allow_nil: true
    validates :publisher,           type: SchemaDotOrg::Organization
    validates :source_organization, type: SchemaDotOrg::Organization, allow_nil: true

    def _to_json_struct
      struct = {
        "accessMode"          => "visual",
        "author"              => author.to_json_struct,
        "description"         => description,
        "thumbnailUrl"        => thumbnail_url,
        "url"                 => url,
        "encodingFormat"      => encoding_format,
        "keywords"            => keywords,
        "associatedMedia"     => associated_media.to_json_struct,
        "publisher"           => publisher.to_json_struct,
      }

      struct["mainEntityOfPage"]  = main_entity_of_page unless main_entity_of_page
      struct["copyrightYear"]     = copyright_year unless copyright_year
      struct["provider"]          = provider.to_json_struct if provider
      struct["sourceOrganization"]= source_organization.to_json_struct if source_organization

      struct
    end
  end
end
