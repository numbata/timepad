# -*- encoding: utf-8 -*-
require File.expand_path('../lib/timepad/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrey Subbota"]
  gem.email         = ["subbota@gmail.com"]
  gem.description   = %q{Gem that provide access to timepad.ru api}
  gem.summary       = %q{See description}
  gem.homepage      = "https://github.com/kaize/timepad/"
  gem.add_dependency('activesupport')

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "timepad"
  gem.require_paths = ["lib"]
  gem.version       = Timepad::VERSION

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'webmock', '>= 1.20.4'
  gem.add_development_dependency 'json', '>= 1.8.1'
  gem.add_development_dependency 'minitest', '>= 5.4.3'

end
