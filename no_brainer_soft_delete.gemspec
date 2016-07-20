# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'no_brainer_soft_delete/version'

Gem::Specification.new do |spec|
  spec.name          = "no_brainer_soft_delete"
  spec.version       = NoBrainerSoftDelete::VERSION
  spec.authors       = ["Andrew T. poe"]
  spec.email         = ["andrewtpoe@gmail.com"]
  spec.summary       = "Adds soft delete capabilities to NoBrainer"
  spec.description   = "Extends the NoBrainer ORM to include soft delete capabilities similar to Paranoia for Active Record."
  spec.homepage      = "https://github.com/andrewtpoe/no_brainer_soft_delete"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.2.2"

  spec.add_dependency "activesupport",     ">= 4.1.0"
  spec.add_dependency "nobrainer", ">=0.32.0"
  spec.add_dependency "rethinkdb", ">= 2.3.0"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
