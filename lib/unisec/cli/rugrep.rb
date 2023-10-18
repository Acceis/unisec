# frozen_string_literal: true

require 'dry/cli'
require 'unisec'

module Unisec
  module CLI
    module Commands
      # CLI command `unisec grep` for the class {Unisec::Rugrep} from the lib.
      #
      # Example:
      #
      # ```plaintext
      # $ unisec grep 'FRENCH \w+'
      # U+20A3  ₣    FRENCH FRANC SIGN
      # U+1F35F 🍟    FRENCH FRIES
      # ```
      class Grep < Dry::CLI::Command
        desc 'Search for Unicode code point names by regular expression'

        argument :regexp, required: true,
                          desc: 'regular expression'

        # Hexdump of all Unicode encodings.
        # @param regexp [Regexp] Regular expression without delimiters or modifiers.
        #   Supports everything Ruby Regexp supports
        def call(regexp: nil, **)
          puts Unisec::Rugrep.regrep_display(regexp)
        end
      end
    end
  end
end
