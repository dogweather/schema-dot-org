# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org'

RSpec.describe SchemaDotOrg::DiscussionForumPosting do
  let(:post) do
    SchemaDotOrg::DiscussionForumPosting.new(
      headline: 'Great Post',
      text: 'This is a great post!',
      author: SchemaDotOrg::Person.new(name: 'Alice'),
      datePublished: Date.new(2020, 1, 1),
      image: ['https://example.com/image.jpg'],
      url: 'https://example.com/post',
      mainEntityOfPage: 'https://example.com/post',
      comment: [SchemaDotOrg::Comment.new(
        text: 'Great comment!',
        author: SchemaDotOrg::Person.new(name: 'Bob'),
        datePublished: Date.new(2020, 1, 2),
        url: 'https://example.com/comment',
        )
      ],
      interactionStatistic: [
        SchemaDotOrg::InteractionCounter.new(
          userInteractionCount: 5,
          interactionType: 'https://schema.org/LikeAction',
        ),
        SchemaDotOrg::InteractionCounter.new(
          userInteractionCount: 200,
          interactionType: 'https://schema.org/ViewAction',
        )
      ]
    )
  end

  describe '#to_json_struct' do
    it 'has the correct attributes and values' do
      expect(post.to_json_struct).to eq(
        '@type'  => 'DiscussionForumPosting',
        'headline' => 'Great Post',
        'text' => 'This is a great post!',
        'author' => { '@type' => 'Person', 'name' => 'Alice' },
        'datePublished' => '2020-01-01',
        'image' => ['https://example.com/image.jpg'],
        'url' => 'https://example.com/post',
        'mainEntityOfPage' => 'https://example.com/post',
        'comment' => [
          {
            '@type' => 'Comment',
            'text' => 'Great comment!',
            'author' => { '@type' => 'Person', 'name' => 'Bob' },
            'datePublished' => '2020-01-02',
            'url' => 'https://example.com/comment',
          }
        ],
        'interactionStatistic' => [
          {
            '@type' => 'InteractionCounter',
            'userInteractionCount' => 5,
            'interactionType' => 'https://schema.org/LikeAction',
          },
          {
            '@type' => 'InteractionCounter',
            'userInteractionCount' => 200,
            'interactionType' => 'https://schema.org/ViewAction',
          }
        ]
      )
    end
  end
end
