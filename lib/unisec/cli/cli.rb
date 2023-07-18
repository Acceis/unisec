# frozen_string_literal: true

require 'unisec/cli/surrogates'

module Unisec
  # Module used to create the CLI for the executable
  module CLI
    # Registered commands for the CLI
    module Commands
      # Mapping between the (sub-)commands as seen by the user
      # on the command-line interface and the CLI modules in the lib
      register 'surrogates to', Surrogates::To
      register 'surrogates from', Surrogates::From
    end
  end
end
