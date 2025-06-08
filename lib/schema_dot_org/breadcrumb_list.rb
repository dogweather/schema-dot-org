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
  end
end
