# frozen_string_literal: true

require 'dry/cli'
require 'unisec'
require 'unisec/utils'

module Unisec
  module CLI
    module Commands
      # CLI sub-commands `unisec properties xxx` for the class {Unisec::Properties} from the lib.
      module Properties
        # Command `unisec properties list`
        #
        # Example:
        #
        # ```plaintext
        # $ unisec properties list
        # ASCII_Hex_Digit
        # Age
        # Alphabetic
        # …
        # ```
        class List < Dry::CLI::Command
          desc 'List all Unicode properties'

          # List Unicode properties name
          def call(**)
            Unisec::Properties.list.each do |p|
              puts p
            end
          end
        end

        # Command `unisec properties codepoints`
        #
        # Example:
        #
        # ```plaintext
        # $ unisec properties codepoints Bidi_Control
        # U+61C     ؜    ARABIC LETTER MARK
        # …
        # ```
        class Codepoints < Dry::CLI::Command
          desc 'List all code points for a given property'

          argument :property, required: true, desc: 'Unicode property name'

          # List code points matching a Unicode property
          # @param property [String] property name
          def call(property: nil, **)
            Unisec::Properties.codepoints_display(property)
          end
        end

        # Command `unisec properties char`
        #
        # Example:
        #
        # ```plaintext
        # $ unisec properties char é
        # Name:               LATIN SMALL LETTER E WITH ACUTE
        # Code Point:         U+00E9
        #
        # Block:              Latin-1 Supplement
        # …
        # ```
        class Char < Dry::CLI::Command
          desc 'Returns all properties of a given Unicode character (code point as string)'

          argument :character, required: true, desc: 'Unicode character'
          option :extended, default: false, values: %w[true false], desc: 'Show all properties'

          # Returns all properties of a given Unicode character (code point as string)
          # @param character [String] Unicode code point (as character / string)
          # @option options [Boolean] :extended Show all properties
          def call(character: nil, **options)
            to_bool = ->(str) { str == 'true' }
            Unisec::Properties.char_display(character, extended: to_bool.call(options.fetch(:extended)))
          end
        end
      end
    end
  end
end
