# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tourets/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeremy Woertink", "Justin Mitchell"]
  gem.email         = ["jeremywoertink@gmail.com", "jmitchell4140@gmail.com"]
  gem.description   = "TouRETS is a rails gem used to interface with multiple RETS using the ruby-rets gem"
  gem.summary       = "Use RETS with a LOT less hassle"
  gem.homepage      = "https://github.com/jwoertink/tourets"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "tourets"
  gem.require_paths = ["lib"]
  gem.version       = TouRETS::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.license       = "MIT"

  gem.add_development_dependency('rspec')
  gem.add_development_dependency('vcr')
  gem.add_development_dependency('webmock')
  gem.add_development_dependency('rails', '>= 4.2')
end
