# frozen_string_literal: true

require 'unisec/cli/surrogates'
require 'unisec/cli/hexdump'
require 'unisec/cli/properties'

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
    end
  end
end
