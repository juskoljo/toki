# -*- encoding: utf-8 -*-
require File.expand_path('../lib/toki/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jussi Koljonen"]
  gem.email         = ["jussi.koljonen@gmail.com"]
  gem.description   = %q{Toki is a DSL that helps you to implement Ruby version, patchlevel, engine and platform specific code}
  gem.summary       = %q{Toki is a DSL that helps you to implement Ruby version, patchlevel, engine and platform specific code}
  gem.homepage      = "https://github.com/juskoljo/toki"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "toki"
  gem.require_paths = ["lib"]
  gem.version       = Toki::VERSION
end
