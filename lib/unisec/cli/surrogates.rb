# frozen_string_literal: true

require 'dry/cli'
require 'unisec'
require 'unisec/utils'

module Unisec
  module CLI
    module Commands
      extend Dry::CLI::Registry

      # CLI sub-commands `unisec surrogates xxx`for the class {Unisec::Surrogates} from the lib.
      module Surrogates
        # Command `unisec surrogates from`
        #
        # Example:
        #
        # ```plaintext
        # $ unisec surrogates from 0xD801 0xDC37
        # Char: 𐐷
        # Code Point: 0x10437, 0d66615, 0b10000010000110111
        # High Surrogate: 0xD801, 0d55297, 0b1101100000000001
        # Low Surrogate: 0xDC37, 0d56375, 0b1101110000110111
        # ```
        class From < Dry::CLI::Command
          desc 'Code point ⬅️ Surrogates'

          argument :high, required: true,
                          desc: 'High surrogate (in hexadecimal (0xXXXX), decimal (0dXXXX), binary (0bXXXX) or as text)'
          argument :low, required: true,
                         desc: 'Low surrogate (in hexadecimal (0xXXXX), decimal (0dXXXX), binary (0bXXXX) or as text)'

          # Calculate the Unicode code point based on the surrogates.
          # @param high [String] decimal high surrogate
          # @param low [String] decimal low surrogate
          def call(high: nil, low: nil, **)
            puts Unisec::Surrogates.new(Unisec::Utils::String.convert(high, :integer),
                                        Unisec::Utils::String.convert(low, :integer)).display
          end
        end

        # Command `unisec surrogates to`
        #
        # Example:
        #
        # ```plaintext
        #  $ unisec surrogates to 0x1F4A9
        #  Char: 💩
        #  Code Point: 0x1F4A9, 0d128169, 0b11111010010101001
        #  High Surrogate: 0xD83D, 0d55357, 0b1101100000111101
        #  Low Surrogate: 0xDCA9, 0d56489, 0b1101110010101001
        # ```
        class To < Dry::CLI::Command
          desc 'Code point ➡️ Surrogates'

          argument :name, required: true,
                          desc: 'One code point (character) (in hexadecimal (0xXXXX), decimal (0dXXXX), binary ' \
                                '(0bXXXX) or as text)'

          # Calculate the surrogates based on the Unicode code point.
          # @param codepoint [String] decimal codepoint
          def call(codepoint: nil, **)
            puts Unisec::Surrogates.new(Unisec::Utils::String.convert(codepoint, :integer)).display
          end
        end
      end
    end
  end
end
