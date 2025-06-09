# frozen_string_literal: true


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
        ListItem.new(position: index, name: link[:name], item: link[:url])
      end)
    end
  end
end
