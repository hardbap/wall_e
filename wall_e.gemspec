# -*- encoding: utf-8 -*-
require File.expand_path('../lib/wall_e/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["'Mike Breen'"]
  gem.email         = ["hardbap@gmail.com"]
  gem.description   = %q{A Firmata based Arduino library}
  gem.summary       = %q{}
  gem.homepage      = "https://github.com/hardbap/wall_e"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "wall_e"
  gem.require_paths = ["lib"]
  gem.version       = WallE::VERSION


  gem.add_development_dependency("minitest", "~> 3.3.0")
  gem.add_runtime_dependency("firmata", "~> 0.1.0")
  gem.add_runtime_dependency("event_spitter", "~> 0.5.0")
  gem.add_runtime_dependency("pry", "~> 0.9.10")
end
