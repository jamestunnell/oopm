# -*- encoding: utf-8 -*-

require File.expand_path('../lib/oopm/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "oopm"
  gem.version       = OOPM::VERSION
  gem.summary       = %q{realizes an object-oriented processor model}
  gem.description   = %q{A library defining a model of an object-oriented processor (as in general prupose processor, aka CPU). For simulation in software before implementing in hardware. Could be used to layer additional virtual processors on top of real processors.}
  gem.license       = "MIT"
  gem.authors       = ["James Tunnell"]
  gem.email         = "jamestunnell@lavabit.com"
  gem.homepage      = "https://github.com/jamestunnell/oopm"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'yard', '~> 0.8'
  
  gem.add_dependency 'pry'
  gem.add_dependency 'treetop'
end
