lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'cli/version'

Gem::Specification.new do |gem|
  gem.name          = "cli"
  gem.version       = CLI::VERSION
  gem.authors       = ["Bulat Shakirzyanov"]
  gem.email         = ["mallluhuct@gmail.com"]
  gem.description   = %q{A small command line interface library for quickly building cli apps.}
  gem.summary       = %q{A small command line interface library for quickly building cli apps.}
  gem.homepage      = "https://github.com/avalanche123/cli"

  gem.files         = `git ls-files`.split($/)
  gem.require_paths = ["lib"]
end