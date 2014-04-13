# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mozzn/version'

Gem::Specification.new do |spec|
  spec.name          = "mozzn"
  spec.version       = Mozzn::VERSION
  spec.authors       = ["mozzn"]
  spec.email         = ["info@mozzn.com"]
  spec.summary       = %q{Command Line Interface to mozzn.}
  spec.description   = %q{Command Line Interface to mozzn}
  spec.homepage      = "http://mozzn.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "thor"
  spec.add_dependency "highline"
  spec.add_dependency "faraday"
  spec.add_dependency "cocaine"
  spec.add_dependency "git"
  spec.add_dependency "factory_girl"
  
end
