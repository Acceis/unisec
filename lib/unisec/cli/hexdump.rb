# frozen_string_literal: true

require 'dry/cli'
require 'unisec'

module Unisec
  module CLI
    module Commands
      # CLI command `unisec hexdumps` for the class {Unisec::Hexdump} from the lib.
      #
      # Example:
      #
      # ```plaintext
      # $ unisec hexdump "ACCEIS"
      # UTF-8: 41 43 43 45 49 53
      # UTF-16BE: 0041 0043 0043 0045 0049 0053
      # UTF-16LE: 4100 4300 4300 4500 4900 5300
      # UTF-32BE: 00000041 00000043 00000043 00000045 00000049 00000053
      # UTF-32LE: 41000000 43000000 43000000 45000000 49000000 53000000
      # ```
      class Hexdump < Dry::CLI::Command
        desc 'Hexdump in all Unicode encodings'

        argument :input, required: true,
                         desc: 'String input'

        # Hexdump of all Unicode encodings.
        # @param input [String] Input string to encode
        def call(input: nil, **)
          puts Unisec::Hexdump.new(input).display
        end
      end
    end
  end
end
