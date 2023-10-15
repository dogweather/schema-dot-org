# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org'

RSpec.describe SchemaDotOrg::CollegeOrUniversity do
  let(:uc) do 
    SchemaDotOrg::CollegeOrUniversity.new(
      name: 'University of Cincinnati',
      url:  'https://www.uc.edu',
    )
  end

  let(:uc_no_url) do 
    SchemaDotOrg::CollegeOrUniversity.new(
      name: 'University of Cincinnati',
    )
  end


  describe '#to_json_struct' do
    it 'has the correct attributes and values' do
      expect(uc.to_json_struct).to eq(
        '@type' => 'CollegeOrUniversity',
        'name'  => 'University of Cincinnati',
        'url'   => 'https://www.uc.edu',
      )
    end

    it 'works without a url' do
      expect(uc_no_url.to_json_struct).to eq(
        '@type' => 'CollegeOrUniversity',
        'name'  => 'University of Cincinnati',
      )
    end
  end
end
