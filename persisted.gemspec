# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'persisted/version'

Gem::Specification.new do |gem|
  gem.name          = 'persisted'
  gem.version       = Persisted::VERSION
  gem.authors       = ['Derek Lindahl']
  gem.email         = ['dlindahl@customink.com']
  gem.description   = 'Persists Ruby Objects with an ActiveRecord model'
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/dlindahl/persisted'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'activesupport', '~> 3.2'
  gem.add_dependency 'activerecord',  '~> 3.2'
end
