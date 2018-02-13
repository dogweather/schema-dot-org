require 'schema_dot_org/place'
require 'schema_dot_org/organization'
include SchemaDotOrg

fl = Place.new { |p| p.address = "Las Vegas, NV" }
org = Organization.new { |o| o.founding_location = fl }

puts org
