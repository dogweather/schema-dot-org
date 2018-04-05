# frozen_string_literal: true

require 'spec_helper'
require 'schema_dot_org/web_site'


RSpec.describe SchemaDotOrg::WebSite do
  describe "#new" do
    it 'creates correct json without optional attributes' do
      basic_site = SchemaDotOrg::WebSite.new(
        name: 'Texas Public Law',
        url:  'https://texas.public.law'
      )
      hash = basic_site.to_json_struct

      expect(hash.keys).to contain_exactly(:name, :url, '@type')
      expect(hash[:name]).to eq 'Texas Public Law'
      expect(hash[:url]).to eq 'https://texas.public.law'
    end

    it 'creates correct json with the optional attributes'
  end
end
