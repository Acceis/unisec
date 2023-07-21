# frozen_string_literal: true

require 'dry/cli'
require 'unisec'
require 'unisec/utils'

module Unisec
  module CLI
    module Commands
      # CLI sub-commands `unisec confusables xxx` for the class {Unisec::Confusables} from the lib.
      module Confusables
        # Command `unisec confusables list`
        #
        # Example:
        #
        # ```plaintext
        # $ unisec confusables list '!'
        # U+FF01    ！    FULLWIDTH EXCLAMATION MARK
        # U+01C3    ǃ    LATIN LETTER RETROFLEX CLICK
        # …
        # ```
        class List < Dry::CLI::Command
          desc 'List confusables characters for a given character'

          argument :character, required: true, desc: 'Unicode code point (as string)'
          option :map, default: true, values: %w[true false],
                       desc: 'Allows partial mapping, includes confusable where the given chart is a part of'

          # List confusables characters for a given character
          # @param character [String] the character to search confusables for
          # @option options [Boolean] :map allows partial mapping, includes confusable where the given chart is a
          #   part of
          def call(character: nil, **options)
            to_bool = ->(str) { ['true', true].include?(str) }
            Unisec::Confusables.list_display(character, map: to_bool.call(options.fetch(:map)))
          end
        end

        # Command `unisec confusables randomize`
        #
        # Example:
        #
        # ```plaintext
        # $ unisec confusables randomize noraj
        # Original:    noraj
        # Transformed: ռ໐𝘳𝜶𝙟
        # …
        # ```
        class Randomize < Dry::CLI::Command
          desc 'Replace all characters from a string with random confusables when possible'

          argument :str, required: true, desc: 'Unicode string'

          # Replace all characters from a string with random confusables when possible
          # @param str [String] Unicode string
          def call(str: nil, **)
            Unisec::Confusables.randomize_display(str)
          end
        end
      end
    end
  end
end
