require 'schema_dot_org'


module SchemaDotOrg
  # Model the Schema.org `Thing > CreativeWork > WebSite`.  See http://schema.org/WebSite
  class WebSite < SchemaType
    attr_accessor :name
    validates :name, type: String, presence: true

    attr_accessor :url
    validates :url, type: String, presence: true

    def to_json_struct
      {
        "@type" => "WebSite",
        name: self.name,
        url:  self.url
      }
    end
  end
end

