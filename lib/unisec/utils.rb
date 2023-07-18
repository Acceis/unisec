# frozen_string_literal: true

require 'ctf_party'

class Integer
  # Convert an integer to an hexadecimal string
  # @return [String] The interger converted to hexadecimal and casted to an upper case string
  # @example
  #   42.to_hex # => "2A"
  def to_hex
    to_s(16).upcase
  end

  # Convert an integer to an binary string
  # @return [String] The interger converted to binary and casted to a string
  # @example
  #   42.to_bin # => "101010"
  def to_bin
    to_s(2)
  end
end

module Unisec
  # Generic stuff not Unicode-related that can be re-used.
  module Utils
    # About string conversion and manipulation.
    module String
      # Convert a string input into the chosen type.
      # @param input [String] If the target type is `:integer`, the string must represent a number encoded in
      #   hexadecimal, decimal, binary. If it's a Unicode string, only the first code point will be taken into account.
      # @param target_type [Symbol] Convert to the chosen type. Currently only supports `:integer`.
      # @return [Variable] The type of the output depends on the chosen `target_type`.
      # @example
      #   Unisec::Utils::String.convert('0x1f4a9', :integer) # => 128169
      def self.convert(input, target_type)
        case target_type
        when :integer
          convert_to_integer(input)
        else
          raise TypeError, "Target type \"#{target_type}\" not avaible"
        end
      end

      # Internal method used for {.convert}.
      #
      # Convert a string input into integer.
      # @param input [String] The string must represent a number encoded in hexadecimal, decimal, binary. If it's a
      #   Unicode string, only the first code point will be taken into account. The input type is determined
      #   automatically based on the prefix.
      # @return [Integer]
      # @example
      #   # Hexadecimal
      #   Unisec::Utils::String.convert_to_integer('0x1f4a9') # => 128169
      #   # Decimal
      #   Unisec::Utils::String.convert_to_integer('0d128169') # => 128169
      #   # Binary
      #   Unisec::Utils::String.convert_to_integer('0b11111010010101001') # => 128169
      #   # Unicode string
      #   Unisec::Utils::String.convert_to_integer('💩') # => 128169
      def self.convert_to_integer(input)
        case autodetect(input)
        when :hexadecimal
          input.hex2dec(prefix: '0x').to_i
        when :decimal
          input.to_i
        when :binary
          input.bin2hex.hex2dec.to_i
        when :string
          input.codepoints.first
        else
          raise TypeError, "Input \"#{input}\" is not of the expected type"
        end
      end

      # Internal method used for {.convert}.
      #
      # Autodetect the representation type of the string input.
      # @param str [String] Input.
      # @return [Symbol] the detected type: `:hexadecimal`, `:decimal`, `:binary`, `:string`.
      # @example
      #   # Hexadecimal
      #   Unisec::Utils::String.autodetect('0x1f4a9') # => :hexadecimal
      #   # Decimal
      #   Unisec::Utils::String.autodetect('0d128169') # => :decimal
      #   # Binary
      #   Unisec::Utils::String.autodetect('0b11111010010101001') # => :binary
      #   # Unicode string
      #   Unisec::Utils::String.autodetect('💩') # => :string
      def self.autodetect(str)
        case str
        when /0x[0-9a-fA-F]/
          :hexadecimal
        when /0d[0-9]+/
          :decimal
        when /0b[0-1]+/
          :binary
        else
          :string
        end
      end
    end
  end
end
