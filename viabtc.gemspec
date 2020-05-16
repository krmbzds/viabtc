# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'viabtc/version'

Gem::Specification.new do |spec|
  spec.name          = 'viabtc'
  spec.version       = ViaBTC::VERSION
  spec.authors       = ['Kerem Bozdas']
  spec.email         = ['krmbzds.github@gmail.com']

  spec.summary       = 'ViaBTC Exchange Server API Wrapper'
  spec.description   = 'An HTTP Client to Interface with the Open-Source ViaBTC Exchange Server'
  spec.homepage      = 'https://github.com/krmbzds/viabtc/'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Ruby required keyword arguments
  spec.required_ruby_version = '>= 2.5.8'

  # Runtime dependencies
  spec.add_dependency 'faraday', '~> 1.0.1'

  # Development dependencies
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
