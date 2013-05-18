# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ar_to_pojo/version'

Gem::Specification.new do |spec|
  spec.name          = "ar_to_pojo"
  spec.version       = ArToPojo::VERSION
  spec.authors       = ["Cristian Pereyra"]
  spec.email         = ["criis.pereyra@gmail.com"]
  spec.description   = %q{A gem for making Java POJOs out of ActiveRecord models}
  spec.summary       = %q{Made with Android in mind, but it will maybe be extended to other platforms}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths << "lib"



  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
  
  spec.add_dependency 'active_support'
  spec.add_dependency "cog"
end
