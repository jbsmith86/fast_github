# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fast_github/version'

Gem::Specification.new do |spec|
  spec.name          = "fast_github"
  spec.version       = FastGithub::VERSION
  spec.authors       = ["Joel Smith"]
  spec.email         = ["joel@trosic.com"]
  spec.summary       = "Fast Github takes the monotany out of uploading your projects to Github."
  spec.description   = "Upload your projects to Github in a snap! Start a new project, run Fast Github and go. That's all there is to it."
  spec.homepage      = ""
  spec.license       = "BSD-3-Clause-Clear"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.executables   = ["fast_github"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
