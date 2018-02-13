require 'spec_helper'
require 'type/place'

include Type

RSpec.describe Place do
  describe "#new" do
    it 'will not create a Place without an address' do
      expect{ Place.new {} }.to raise_error(ArgumentError)
    end

    it 'creates a Place when given an address string' do
      expect{ Place.new {|p| p.address = 'NY, NY'} }
    end
  end

  describe "#to_json_struct" do
    it "has exactly the correct attributes and values" do
      home = Place.new { |p| p.address = 'Las Vegas, NV' }
      hash = home.to_json_struct
      
      expect(hash.keys).to eq [:address, '@type']
      expect(hash[:address]).to eq 'Las Vegas, NV'
      expect(hash['@type']).to eq 'Place'
    end
  end
end