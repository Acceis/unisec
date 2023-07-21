# frozen_string_literal: true

require 'unicode/confusable'
require 'twitter_cldr'

module Unisec
  # Operations about Unicode confusable characters (homoglyphs).
  class Confusables
    # List confusables characters for a given character
    # @param chr [String] the character to search confusables for
    # @param map [Boolean] allows partial mapping, includes confusable where the given chart is a part of
    # @return [Array<String>] list of confusables
    # @example
    #   Unisec::Confusables.list('!') # => ["！", "ǃ", "ⵑ", "‼", "⁉", "⁈"]
    #   Unisec::Confusables.list('!', map: false) # => ["！", "ǃ", "ⵑ"]
    def self.list(chr, map: true)
      Unicode::Confusable.list(chr, map)
    end

    # Display a CLI-friendly output listing all confusables corresponding to a character (code point)
    # @param chr [String] the character to search confusables for
    # @param map [Boolean] allows partial mapping, includes confusable where the given chart is a part of
    def self.list_display(chr, map: true)
      Confusables.list(chr, map: map).each do |confu|
        puts "#{Properties.char2codepoint(confu).ljust(9)} #{confu.ljust(4)} " \
             "#{TwitterCldr::Shared::CodePoint.get(confu.codepoints.first).name}"
      end
      nil
    end

    # Replace all characters with random confusables when possible.
    # @param str [String] Unicode string
    # @return [String] input randomized with confusables
    # @example
    #   Unisec::Confusables.randomize('noraj') # => "𝓃ⲟ𝓇𝒶ｊ"
    #   Unisec::Confusables.randomize('noraj') # => "𝗻૦𝚛⍺𝐣"
    #   Unisec::Confusables.randomize('noraj') # => "𝔫𞺄𝕣⍺ｊ"
    def self.randomize(str)
      out = ''
      str.each_char do |chr|
        confu = Confusables.list(chr, map: false).sample
        out += confu.nil? ? chr : confu
      end
      out
    end

    # Display a CLI-friendly output of a string where characters are replaces with random confusables
    # @param str [String] Unicode string
    def self.randomize_display(str)
      display = ->(key, value) { puts Paint[key, :red, :bold].ljust(23) + " #{value}" }
      display.call('Original:', str)
      display.call('Transformed:', Unisec::Confusables.randomize(str))
    end
  end
end
