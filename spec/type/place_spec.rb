require 'spec_helper'
require 'type/place'

RSpec.describe Type::Place do
  describe "#new" do
    it 'will not create a Place without an address' do
      expect{ Type::Place.new {} }.to raise_error(ArgumentError)
    end

    it 'creates a Place when given an address string' do
      expect{ Type::Place.new {|p| p.address = 'NY, NY'} }
    end
  end
end