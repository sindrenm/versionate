lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'versionate/version'

Gem::Specification.new do |gem|
  gem.name          = "versionate"
  gem.version       = Versionate::VERSION
  gem.authors       = ["Sindre Moen"]
  gem.email         = ["sindrenm@gmail.com"]
  gem.description   = "Appends versions to your Gemfile's gem listings"
  gem.summary       = "Appends versions to your Gemfile's gem listings"
  gem.homepage      = "https://github.com/sindrenm/versionate"
  gem.license       = "MIT"

  gem.files = Dir["lib/**/*", "MIT-LICENSE.md", "Rakefile", "README.md"]
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.require_paths = ["lib"]

  gem.bindir        = "bin"
  gem.executables   = ["versionate"]

  gem.add_dependency "gems", "~> 0.8"
  gem.add_dependency "bundler", "~> 1.8"
  gem.add_dependency "thor", "~> 0.19"

  gem.add_development_dependency "coveralls", "~> 0.7"
  gem.add_development_dependency "rake", "~> 10.3"
  gem.add_development_dependency "rspec", "~> 3.1"
end
