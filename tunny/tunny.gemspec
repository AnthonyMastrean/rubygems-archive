# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tunny/version'

Gem::Specification.new do |spec|
  spec.name          = 'tunny'
  spec.version       = Tunny::VERSION
  spec.authors       = ['Anthony Mastrean']
  spec.email         = ['anthony.mastrean@gmail.com']
  spec.description   = %q{Simple Windows exe wrappers for rake}
  spec.summary       = %q{Simple Windows exe wrappers for rake}
  spec.homepage      = 'http://github.com/AnthonyMastrean/tunny'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rake'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
