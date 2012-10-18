# -*- encoding: utf-8 -*-
require File.expand_path('../lib/installshield/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Anthony Mastrean']
  gem.email         = ['anthony.mastrean@gmail.com']
  gem.description   = %q{Modify and build InstallShield 2010 projects. Support for newer versions is coming!}
  gem.summary       = %q{Modify and build InstallShield 2010 projects.}
  gem.homepage      = 'https://github.com/AnthonyMastrean/installshield'
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'installshield'
  gem.require_paths = ['lib']
  gem.version       = InstallShield::VERSION
end
