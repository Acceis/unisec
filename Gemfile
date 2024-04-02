# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in .gemspec
gemspec

# Needed for the CLI only
group :runtime, :cli do
  gem 'dry-cli', '~> 1.0' # for arg parsing
  gem 'paint', '~> 2.3' # for colorized ouput
end

# Needed for the CLI & library
group :runtime, :all do
  gem 'ctf-party', '~> 3.0' # string conversion
  gem 'twitter_cldr', '~> 6.12' # ICU / CLDR
  gem 'unicode-confusable', '~> 1.10' # confusable chars
end

# Needed to install dependencies
group :development, :install do
  gem 'bundler', '~> 2.1'
end

# Needed to run tests
group :development, :test do
  gem 'minitest', '~> 5.22'
  gem 'minitest-skip', '~> 0.0' # skip dummy tests
  gem 'rake', '~> 13.2'
end

# Needed for linting
group :development, :lint do
  gem 'rubocop', '~> 1.62'
end

group :development, :docs do
  gem 'commonmarker', '~> 0.23' # for markdown support in YARD
  gem 'webrick', '~> 1.8', '>= 1.8.1' # for yard server
  gem 'yard', ['>= 0.9.27', '< 0.10']
  gem 'yard-coderay', '~> 0.1' # for syntax highlight support in YARD
end
