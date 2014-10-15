# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minecraft_auth/version'

Gem::Specification.new do |spec|
  spec.name          = "minecraft_auth"
  spec.version       = MinecraftAuth::VERSION
  spec.authors       = ["Jake"]
  spec.email         = ["jake0oo0dev@gmail.com"]
  spec.summary       = %q{A ruby gem for Minecraft account authentication.}
  spec.description   = %q{A ruby gem for Minecraft account authentication.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency 'httparty', '~> 0.13', '>= 0.13.1'
end
