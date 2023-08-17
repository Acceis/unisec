# frozen_string_literal: true

require 'dry/cli'
require 'unisec'

module Unisec
  module CLI
    module Commands
      # CLI command `unisec size` for the class {Unisec::Size} from the lib.
      #
      # Example:
      #
      # ```plaintext
      # $ unisec size 🧑🏼‍🔬
      # Code point(s):   4
      # Grapheme(s):     1
      # UTF-8 byte(s):   15
      # UTF-16 byte(s):  14
      # UTF-32 byte(s):  16
      # UTF-8 unit(s):   15
      # UTF-16 unit(s):  7
      # UTF-32 unit(s):  4
      # ```
      class Size < Dry::CLI::Command
        desc 'All kinf of size information about a Unicode string'

        argument :input, required: true,
                         desc: 'String input'

        # All kinf of size information about a Unicode string.
        # @param input [String] Input sting we want to know the size of
        def call(input: nil, **)
          puts Unisec::Size.new(input).display
        end
      end
    end
  end
end
