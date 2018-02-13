
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "schema_dot_org/version"

Gem::Specification.new do |spec|
  spec.name          = "schema_dot_org"
  spec.version       = SchemaDotOrg::VERSION
  spec.authors       = ["Robb Shecter"]
  spec.email         = ["robb@public.law"]

  spec.summary       = %q{JSON-LD generator for Schema.org vocabulary}
  spec.description   = %q{Creates well-formed website metadata with strongly typed Ruby.}
  spec.homepage      = "https://github.com/dogweather/schema-dot-org"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
