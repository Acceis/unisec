# frozen_string_literal: true

require 'unisec/cli/bidi'
require 'unisec/cli/confusables'
require 'unisec/cli/hexdump'
require 'unisec/cli/normalization'
require 'unisec/cli/properties'
require 'unisec/cli/rugrep'
require 'unisec/cli/size'
require 'unisec/cli/surrogates'
require 'unisec/cli/versions'

module Unisec
  # Module used to create the CLI for the executable
  module CLI
    # Registered commands for the CLI
    module Commands
      extend Dry::CLI::Registry

      # Mapping between the (sub-)commands as seen by the user
      # on the command-line interface and the CLI modules in the lib
      register 'bidi spoof', Bidi::Spoof
      register 'confusables list', Confusables::List
      register 'confusables randomize', Confusables::Randomize
      register 'grep', Grep
      register 'hexdump', Hexdump
      register 'normalize', Normalize
      register 'properties char', Properties::Char
      register 'properties codepoints', Properties::Codepoints
      register 'properties list', Properties::List
      register 'size', Size
      register 'surrogates from', Surrogates::From
      register 'surrogates to', Surrogates::To
      register 'versions', Versions
    end
  end
end
