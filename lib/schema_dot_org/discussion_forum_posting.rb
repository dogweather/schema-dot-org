# frozen_string_literal: true

require 'date'

require_relative 'person'
#
# Model the Schema.org `Thing > CreativeWork > Article > SocialMediaPosting > DiscussionForumPosting`.  See https://schema.org/DiscussionForumPosting
#
module SchemaDotOrg
  class DiscussionForumPosting < SchemaType
    validated_attr :author,        type: Person, presence: true
    validated_attr :datePublished, type: Date,   presence: true

    validated_attr :comment,              type: Array,   allow_nil: true
    validated_attr :commentCount,         type: Numeric, allow_nil: true
    validated_attr :headline,             type: String,  allow_nil: true
    validated_attr :image,                type: Array,   allow_nil: true
    validated_attr :inLanguage,           type: Array,   allow_nil: true
    validated_attr :interactionStatistic, type: Array,   allow_nil: true
    validated_attr :mainEntityOfPage,     type: String,  allow_nil: true
    validated_attr :text,                 type: String,  allow_nil: true
    validated_attr :url,                  type: String,  allow_nil: true
  end
end
