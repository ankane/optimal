# -*- encoding: utf-8 -*-
require File.expand_path('../lib/optimal/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrew Kane"]
  gem.email         = ["andrew@example.org"]
  gem.description   = %q{Play with numbers}
  gem.summary       = %q{Play with numbers}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "optimal"
  gem.require_paths = ["lib"]
  gem.version       = Optimal::VERSION

  gem.add_development_dependency "rake"
  gem.add_development_dependency "riot"
end
