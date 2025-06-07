# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org'

RSpec.describe SchemaDotOrg::Comment do
  let(:comment) do
    SchemaDotOrg::Comment.new(
      text: 'This is a great comment!',
      author: SchemaDotOrg::Person.new(name: 'Alice'),
      datePublished: Date.new(2020, 1, 1),
      image: ['https://example.com/image.jpg'],
      url: 'https://example.com/post',
      comment: [SchemaDotOrg::Comment.new(
        text: 'Great comment!',
        author: SchemaDotOrg::Person.new(name: 'Bob'),
        datePublished: Date.new(2020, 1, 2),
        url: 'https://example.com/comment',
        )
      ],
      interactionStatistic: [
        SchemaDotOrg::InteractionCounter.new(
          userInteractionCount: 200,
          interactionType: 'https://schema.org/ViewAction',
        )
      ]
    )
  end

  describe '#to_json_struct' do
    it 'has the correct attributes and values' do
      expect(comment.to_json_struct).to eq(
        '@type'  => 'Comment',
        'text' => 'This is a great comment!',
        'author' => { '@type' => 'Person', 'name' => 'Alice' },
        'datePublished' => '2020-01-01',
        'image' => ['https://example.com/image.jpg'],
        'url' => 'https://example.com/post',
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
            'userInteractionCount' => 200,
            'interactionType' => 'https://schema.org/ViewAction',
          }
        ]
      )
    end
  end
end
