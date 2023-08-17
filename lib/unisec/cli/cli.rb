# frozen_string_literal: true

require 'unisec/cli/surrogates'
require 'unisec/cli/hexdump'
require 'unisec/cli/properties'
require 'unisec/cli/confusables'
require 'unisec/cli/versions'
require 'unisec/cli/size'

module Unisec
  # Module used to create the CLI for the executable
  module CLI
    # Registered commands for the CLI
    module Commands
      extend Dry::CLI::Registry

      # Mapping between the (sub-)commands as seen by the user
      # on the command-line interface and the CLI modules in the lib
      register 'surrogates to', Surrogates::To
      register 'surrogates from', Surrogates::From
      register 'hexdump', Hexdump
      register 'properties list', Properties::List
      register 'properties codepoints', Properties::Codepoints
      register 'properties char', Properties::Char
      register 'confusables list', Confusables::List
      register 'confusables randomize', Confusables::Randomize
      register 'versions', Versions
      register 'size', Size
    end
  end
end
