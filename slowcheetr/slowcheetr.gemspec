# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "slowcheetr/version"

Gem::Specification.new do |spec|
  spec.name          = "slowcheetr"
  spec.version       = Slowcheetr::VERSION
  spec.authors       = ["Anthony Mastrean"]
  spec.email         = ["anthony.mastrean@gmail.com"]
  spec.description   = %q{Windows and .NET configuration file (XML) transforms for rake}
  spec.summary       = %q{Windows and .NET configuration file (XML) transforms for rake.}
  spec.homepage      = "https://github.com/AnthonyMastrean/slowcheetr"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
