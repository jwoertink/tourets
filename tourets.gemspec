# -*- encoding: utf-8 -*-
require File.expand_path('../lib/tourets/rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeremy Woertink", "Justin Mitchell"]
  gem.email         = ["jeremywoertink@gmail.com", "jmitchell4140@gmail.com"]
  gem.description   = %q{TouRETS is a rails gem used to interface with multiple RETS using the ruby-rets gem}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "tourets"
  gem.require_paths = ["lib"]
  gem.version       = TouRETS::Rails::VERSION
  
  gem.add_dependency('ruby-rets')
  gem.add_development_dependency('rspec')
end
