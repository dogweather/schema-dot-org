# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org'

RSpec.describe SchemaDotOrg::DiscussionForumPosting do
  let(:post) do
    SchemaDotOrg::DiscussionForumPosting.new(
      headline: 'test',
      text: 'foo',
      author: SchemaDotOrg::Person.new(
        name: 'bd8d5'
      ),
      date_published: '2025-01-28T13:41:36+09:00',
      url: 'https://myapp.com/articles/24205',
      main_entity_of_page: 'https://myapp.com/articles/24205',
      in_language: [
        SchemaDotOrg::Language.new(
          name: 'France',
          alternate_name: 'fr'
        )
      ],
      interaction_statistic: [
        SchemaDotOrg::InteractionCounter.new(
          user_interaction_count: 0,
          interaction_type: 'https://schema.org/LikeAction'
        ),
        SchemaDotOrg::InteractionCounter.new(
          user_interaction_count: 0,
          interaction_type: 'https://schema.org/ViewAction'
        )
      ]
    )
  end

  describe '#to_json_struct' do
    it 'excludes validation context from the output' do
      # Simulate Rails 7.1 validation context
      post.instance_variable_set(:@context_for_validation, '#<ActiveModel::ValidationContext:0x000000012858f998>')
      post.author.instance_variable_set(:@context_for_validation, '#<ActiveModel::ValidationContext:0x000000012858f998>')
      post.in_language.first.instance_variable_set(:@context_for_validation, '#<ActiveModel::ValidationContext:0x0000000128580a38>')
      post.interaction_statistic.first.instance_variable_set(:@context_for_validation, '#<ActiveModel::ValidationContext:0x00000001289a2328>')
      post.interaction_statistic.last.instance_variable_set(:@context_for_validation, '#<ActiveModel::ValidationContext:0x00000001289a1568>')

      json_struct = post.to_json_struct

      # Verify the structure is correct and validation context is excluded
      expect(json_struct).to eq(
        '@type' => 'DiscussionForumPosting',
        'headline' => 'test',
        'text' => 'foo',
        'author' => {
          '@type' => 'Person',
          'name' => 'bd8d5'
        },
        'datePublished' => '2025-01-28T13:41:36+09:00',
        'url' => 'https://myapp.com/articles/24205',
        'mainEntityOfPage' => 'https://myapp.com/articles/24205',
        'inLanguage' => [
          {
            '@type' => 'Language',
            'name' => 'France',
            'alternateName' => 'fr'
          }
        ],
        'interactionStatistic' => [
          {
            '@type' => 'InteractionCounter',
            'userInteractionCount' => 0,
            'interactionType' => 'https://schema.org/LikeAction'
          },
          {
            '@type' => 'InteractionCounter',
            'userInteractionCount' => 0,
            'interactionType' => 'https://schema.org/ViewAction'
          }
        ]
      )

      # Verify no validation context appears in the JSON string
      json_string = post.to_json
      expect(json_string).not_to include('contextForValidation')
      expect(json_string).not_to include('ActiveModel::ValidationContext')
    end
  end
end
