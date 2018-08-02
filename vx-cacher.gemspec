# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vx/cacher/version'

Gem::Specification.new do |spec|
  spec.name          = "vx-cacher"
  spec.version       = Vx::Cacher::VERSION
  spec.authors       = ["Alexander Kirillov"]
  spec.email         = ["alex@vexor.io"]

  spec.summary       = %q{Cache artifacts}
  spec.description   = %q{Cache artifacts}
  spec.homepage      = "https://vexor.io"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = Dir['{lib}/**/*', 'README*']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 4.0.8"
  spec.add_dependency "azure", "= 0.6.4"
  spec.add_dependency "aws-sdk", "~> 2"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
