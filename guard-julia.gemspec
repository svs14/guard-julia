# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/julia/version'

Gem::Specification.new do |spec|
  spec.name          = 'guard-julia'
  spec.version       = Guard::JuliaVersion::VERSION
  spec.authors       = ['Samuel Jenkins']
  spec.email         = ['svs14.41svs@gmail.com']
  spec.summary       = 'Guard plugin for Julia language'
  spec.description   = 'Guard::Julia automatically runs tests when Julia files change'
  spec.homepage      = 'https://rubygems.org/gems/guard-julia'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.2'
  spec.add_dependency 'guard', '~> 2.6'
  spec.add_dependency 'bundler', '~> 1.5'
end
