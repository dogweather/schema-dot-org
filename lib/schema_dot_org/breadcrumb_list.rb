# frozen_string_literal: true

require 'schema_dot_org/url_validator'


#
# Model the Google / Schema.org `BreadcrumbList`.
#
# The intent is to primarily support Google's BreadcrumbList. Properties
# from Schema.org are welcome if desired.
#
# See https://developers.google.com/search/docs/appearance/structured-data/breadcrumb
# and https://schema.org/BreadcrumbList
#
module SchemaDotOrg
  class BreadcrumbList < SchemaType
    validated_attr :itemListElement, type: Array, presence: true

    def self.from_links(links)
      new(itemListElement: links.map.with_index(1) do |link, index|
        url  = link[:url]
        name = link[:name]

        if !url.nil? && !UrlValidator.valid_web_url?(url)
          raise ArgumentError, "URL is not a valid web URL: #{url}"
        end

        ListItem.new(position: index, item: url, name: name)
      end)
    end
  end
end
