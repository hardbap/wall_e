# -*- encoding: utf-8 -*-
require File.expand_path('../lib/wall_e/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["'Mike Breen'"]
  gem.email         = ["hardbap@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "wall_e"
  gem.require_paths = ["lib"]
  gem.version       = WallE::VERSION


  gem.add_development_dependency("minitest", "~> 3.3.0")
  gem.add_runtime_dependency("firmata", "~> 0.0.5")
  gem.add_runtime_dependency("event_spitter", "~> 0.5.0")
end
