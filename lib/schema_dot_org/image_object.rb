# frozen_string_literal: true

module SchemaDotOrg
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