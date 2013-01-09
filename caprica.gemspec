# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/caprica/version'

Gem::Specification.new do |gem|
  gem.name          = 'caprica'
  gem.version       = Caprica::VERSION::STRING
  gem.authors       = ['Jean Mertz']
  gem.email         = ['jean@mertz.fm']
  gem.description   = %q{Extend your Capistrano tasks with frakkin' awesomeness.}
  gem.summary       = %q{Prettify output, enhance existing tasks, extend with custom tasks.}
  gem.homepage      = 'https://github.com/JeanMertz/Caprica'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'capistrano'
end
