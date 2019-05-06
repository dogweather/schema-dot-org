# frozen_string_literal: true

require 'date'
require 'schema_dot_org'
require 'schema_dot_org/person'
require 'schema_dot_org/organization'


module SchemaDotOrg
  class Photography < SchemaType
    attr_accessor :author,
                  :description,
                  :main_entity_of_page,
                  :thumbnail_url,
                  :url,
                  :copyrightYear,
                  :encoding_format,
                  :keywords,
                  :associated_media,
                  :provider,
                  :publisher,
                  :source_organization


# :author,
# :description,
# :main_entity_of_page,
# :thumbnail_url,
# :url,
# :copyrightYear,
# :encoding_format,
# :keywords,
# :associated_media,
# :provider,
# :publisher,
# :source_organization

    # validates :email,             type: String
    # validates :founder,           type: SchemaDotOrg::Person
    # validates :founding_date,     type: Date
    # validates :founding_location, type: SchemaDotOrg::Place
    # validates :logo,              type: String
    # validates :name,              type: String
    # validates :url,               type: String
    # validates :same_as,           type: Array, allow_nil: true

    def _to_json_struct
      {
        "author"              => author.to_json_struct,
        "description"         => description,
        "mainEntityOfPage"    => main_entity_of_page,
        "thumbnailUrl"        => thumbnail_url,
        "url"                 => url,
        "copyrightYear"       => copyrightYear,
        "encodingFormat"      => encoding_format,
        "keywords"            => keywords,
        "associatedMedia"     => associated_media.to_json_struct,
        "provider"            => provider.to_json_struct,
        "publisher"           => publisher.to_json_struct,
        "sourceOrganization"  => source_organization.to_json_struct
      }
    end
  end
  class ImageObject < SchemaType
    attr_accessor :author,
                  :content_url,
                  :name,
                  :thumbnail_url

    def _to_json_struct
      {
        "author"        => author.to_json_struct,
        "contentUrl"    => content_url,
        "name"          => name,
        "thumbnailUrl"  => thumbnail_url
      }
    end
  end
end
