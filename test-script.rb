require 'schema_dot_org/place'
require 'schema_dot_org/organization'
include SchemaDotOrg


org = Organization.new do |public_law|
  public_law.name  = "Public.Law"
  public_law.email = "say_hi@public.law"
  public_law.url   = "https://www.public.law"
  public_law.founding_location = Place.new do |portland| 
    portland.address = "Portland, OR"
  end
end

puts org