# frozen_string_literal: true

require 'unisec/utils'
require 'ctf_party'

module Unisec
  # UTF-16 surrogates conversion.
  class Surrogates
    # Unicode code point
    # @return [Integer] decimal codepoint
    attr_reader :cp

    # High surrogate (1st code unit of a surrogate pair). Also called lead surrogate.
    # @return [Integer] decimal high surrogate
    attr_reader :hs

    # Low surrogate (2nd code unit of a surrogate pair). Also called trail surrogate.
    # @return [Integer] decimal low surrogate
    attr_reader :ls

    # Init the surrogate pair.
    # @param args [Integer] If one argument is provided, it's evaluated as the
    #   code point and the two surrogates will be calculated automatically.
    #   If two arguments are provided, they are evaluated as a surrogate pair (high
    #   then low) and the code point will be calculated.
    # @example
    #   surr = Unisec::Surrogates.new(128169)
    #   # => #<Unisec::Surrogates:0x00007f96920a7ca8 @cp=128169, @hs=55357, @ls=56489>
    #   surr.cp # => 128169
    #   surr.hs # => 55357
    #   surr.ls # => 56489
    #   Unisec::Surrogates.new(55357, 56489)
    #   # => #<Unisec::Surrogates:0x00007f96920689b8 @cp=128169, @hs=55357, @ls=56489>
    def initialize(*args)
      if args.size == 1
        @cp = args[0]
        @hs = high_surrogate
        @ls = low_surrogate
      elsif args.size == 2
        @hs = args[0]
        @ls = args[1]
        @cp = code_point
      else
        raise ArgumentError
      end
    end

    # Calculate the high surrogate based on the Unicode code point.
    # @param codepoint [Integer] decimal codepoint
    # @return [Integer] decimal high surrogate
    # @example
    #   Unisec::Surrogates.high_surrogate(128169) # => 55357
    def self.high_surrogate(codepoint)
      (((codepoint - 0x10000) / 0x400).floor + 0xd800)
    end

    # Calculate the low surrogate based on the Unicode code point.
    # @param codepoint [Integer] decimal codepoint
    # @return [Integer] decimal low surrogate
    # @example
    #   Unisec::Surrogates.low_surrogate(128169) # => 56489
    def self.low_surrogate(codepoint)
      (((codepoint - 0x10000) % 0x400) + 0xdc00)
    end

    # Calculate the Unicode code point based on the surrogates.
    # @param hs [Integer] decimal high surrogate
    # @param ls [Integer] decimal low surrogate
    # @return [Integer] decimal code point
    # @example
    #   Unisec::Surrogates.code_point(55357, 56489) # => 128169
    def self.code_point(hs, ls)
      (((hs - 0xd800) * 0x400) + ls - 0xdc00 + 0x10000)
    end

    # Same as accessing {.hs}. Calculate the {.high_surrogate}.
    # @return [Integer] decimal high surrogate
    # @example
    #   surr = Unisec::Surrogates.new(128169)
    #   surr.high_surrogate # => 55357
    def high_surrogate
      @hs = Surrogates.high_surrogate(@cp)
    end

    # Same as accessing {.ls}. Calculate the {.low_surrogate}.
    # @return [Integer] decimal low surrogate
    # @example
    #   surr = Unisec::Surrogates.new(128169)
    #   surr.low_surrogate # => 56489
    def low_surrogate
      @ls = Surrogates.low_surrogate(@cp)
    end

    # Same as accessing {.cp}. Calculate the {.code_point}.
    # @return [Integer] decimal code point
    #   surr = Unisec::Surrogates.new(55357, 56489)
    #   surr.code_point # => 128169
    def code_point
      @cp = Surrogates.code_point(@hs, @ls)
    end

    # Display a CLI-friendly output summurizing everithing about the surrogates:
    # the corresponding character, code point, high and low surrogates
    # (each displayed as hexadecimal, decimal and binary).
    # @return [String] CLI-ready output
    # @example
    #   surr = Unisec::Surrogates.new(128169)
    #   puts surr.display # =>
    #   # Char: 💩
    #   # Code Point: 0x1F4A9, 0d128169, 0b11111010010101001
    #   # High Surrogate: 0xD83D, 0d55357, 0b1101100000111101
    #   # Low Surrogate: 0xDCA9, 0d56489, 0b1101110010101001
    def display
      "Char: #{[@cp].pack('U*')}\n" \
        "Code Point: 0x#{@cp.to_hex}, 0d#{@cp}, 0b#{@cp.to_bin}\n" \
        "High Surrogate: 0x#{@hs.to_hex}, 0d#{@hs}, 0b#{@hs.to_bin}\n" \
        "Low Surrogate: 0x#{@ls.to_hex}, 0d#{@ls}, 0b#{@ls.to_bin}"
    end
  end
end
