# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'status_tag/version'

Gem::Specification.new do |spec|
  spec.name          = "status_tag"
  spec.version       = StatusTag::VERSION
  spec.authors       = ["Peter Boling"]
  spec.email         = ["peter.boling@gmail.com"]

  spec.summary       = %q{Provides content_tag_for method signature to create labels from Ruby objects}
  spec.description   = %q{Provides content_tag_for method signature to create customizable and logic-gated labels from objects.
Also includes a presenter base class to allow any Ruby web framework to create logic around HTML tags}
  spec.homepage      = "http://github.com/pboling/status_tag"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 12.2"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
