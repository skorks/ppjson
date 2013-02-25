# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ppjson/version'

Gem::Specification.new do |gem|
  gem.name          = "ppjson"
  gem.version       = Ppjson::VERSION
  gem.authors       = ["Alan Skorkin"]
  gem.email         = ["alan@skorks.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.add_runtime_dependency('escort')
  gem.add_runtime_dependency('yajl-ruby')
  gem.add_runtime_dependency('multi_json')

  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec')

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
