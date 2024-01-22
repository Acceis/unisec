# frozen_string_literal: true

require_relative 'lib/unisec/version'

Gem::Specification.new do |s|
  s.name          = 'unisec'
  s.version       = Unisec::VERSION
  s.platform      = Gem::Platform::RUBY
  s.summary       = 'Unicode Security Toolkit'
  s.description   = 'Toolkit for security research manipulating Unicode: '
  s.description   += 'confusables, homoglyphs, hexdump, code point, UTF-8, UTF-16, UTF-32, properties, regexp search, '
  s.description   += 'size, grapheme, surrogates, version, ICU, CLDR, UCD'
  s.authors       = ['Alexandre ZANNI']
  s.email         = 'alexandre.zanni@europe.com'
  s.homepage      = 'https://github.com/Acceis/unisec'
  s.license       = 'MIT'

  s.files         = Dir['bin/*', 'lib/**/*.rb', 'data/*', 'LICENSE']
  s.bindir        = 'bin'
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.metadata = {
    'yard.run'              => 'yard',
    'bug_tracker_uri'       => 'https://github.com/Acceis/unisec/issues',
    'changelog_uri'         => 'https://github.com/Acceis/unisec/releases',
    'documentation_uri'     => 'https://acceis.github.io/unisec/',
    'homepage_uri'          => 'https://github.com/Acceis/unisec',
    'source_code_uri'       => 'https://github.com/Acceis/unisec/',
    'rubygems_mfa_required' => 'true'
  }

  s.required_ruby_version = ['>= 3.0.0', '< 4.0']

  s.add_runtime_dependency('ctf-party', '~> 3.0') # string conversion
  s.add_runtime_dependency('dry-cli', '~> 1.0') # CLI
  s.add_runtime_dependency('paint', '~> 2.3') # colorized output
  s.add_runtime_dependency('twitter_cldr', '~> 6.11', '>= 6.11.5') # ICU / CLDR
  s.add_runtime_dependency('unicode-confusable', '~> 1.9') # confusable chars
end
