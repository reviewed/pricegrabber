# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pricegrabber/version'

Gem::Specification.new do |spec|
  spec.name          = "pricegrabber"
  spec.version       = Pricegrabber::VERSION
  spec.authors       = ["Timothy Raymond"]
  spec.email         = ["xtjraymondx@gmail.com"]

  spec.summary       = %q{A gem for fetching price information from Pricegrabber's API}
  spec.homepage      = "http://www.example.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httpi", "~> 2.4"
  spec.add_dependency "activesupport", "~> 4.2"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
