lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'schema_dot_org'
  spec.version       = '1.6.1'
  spec.authors       = ['Robb Shecter']
  spec.email         = ['robb@public.law']

  spec.summary       = 'JSON-LD generator for Schema.org vocabulary'
  spec.description   = 'Creates well-formed website metadata with strongly typed Ruby.'
  spec.homepage      = 'https://github.com/public-law/schema-dot-org'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'validated_object', '~> 2.1'

  spec.add_development_dependency 'bundler', '~> 2'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'sorbet', '>= 0.5.5890'

  spec.add_runtime_dependency 'sorbet-runtime', '>= 0.5.5890'
end
