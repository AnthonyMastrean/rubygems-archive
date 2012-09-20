# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'teamcity_service_messages/version'

Gem::Specification.new do |gem|
  gem.name          = 'teamcity_service_messages'
  gem.version       = TeamCity::VERSION
  gem.authors       = ['Anthony Mastrean']
  gem.email         = ['anthony.mastrean@gmail.com']
  gem.description   = <<-TEXT
If TeamCity doesn't support your testing framework or build runner out of the box, you can still avail yourself of many TeamCity benefits by customizing your build scripts to interact with the TeamCity server. This makes a wide range of features available to any team regardless of their testing frameworks and runners. Some of these features include displaying real-time test results and customized statistics, changing the build status, and publishing artifacts before the build is finished.
TEXT
  gem.summary       = %q{TeamCity Service Messages}
  gem.homepage      = 'https://github.com/AnthonyMastrean/teamcity_service_messages'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
