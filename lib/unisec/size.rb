# frozen_string_literal: true

require 'paint'

module Unisec
  # All kinf of size information about a Unicode string
  class Size
    # Number of code points
    # @return [Integer] number of code points
    # @example
    #   us = Unisec::Size.new('👩‍❤️‍👩')
    #   us.code_points_size # => 6
    attr_reader :code_points_size

    # Number of graphemes
    # @return [Integer] number of graphemes
    # @example
    #   us = Unisec::Size.new('👩‍❤️‍👩')
    #   us.grapheme_size # => 1
    attr_reader :grapheme_size

    # UTF-8 size in bytes
    # @return [Integer] UTF-8 size in bytes
    # @example
    #   us = Unisec::Size.new('👩‍❤️‍👩')
    #   us.utf8_bytesize # => 20
    attr_reader :utf8_bytesize

    # UTF-16 size in bytes
    # @return [Integer] UTF-16 size in bytes
    # @example
    #   us = Unisec::Size.new('👩‍❤️‍👩')
    #   us.utf16_bytesize # => 16
    attr_reader :utf16_bytesize

    # UTF-32 size in bytes
    # @return [Integer] UTF-32 size in bytes
    # @example
    #   us = Unisec::Size.new('👩‍❤️‍👩')
    #   us.utf32_bytesize # => 24
    attr_reader :utf32_bytesize

    # Number of UTF-8 units
    # @return [Integer] number of UTF-8 units
    # @example
    #   us = Unisec::Size.new('👩‍❤️‍👩')
    #   us.utf8_unitsize # => 20
    attr_reader :utf8_unitsize

    # Number of UTF-16 units
    # @return [Integer] number of UTF-16 units
    # @example
    #   us = Unisec::Size.new('👩‍❤️‍👩')
    #   us.utf16_unitsize # => 8
    attr_reader :utf16_unitsize

    # Number of UTF-32 units
    # @return [Integer] number of UTF-32 units
    # @example
    #   us = Unisec::Size.new('👩‍❤️‍👩')
    #   us.utf32_unitsize # => 6
    attr_reader :utf32_unitsize

    def initialize(str)
      @code_points_size = Size.code_points_size(str)
      @grapheme_size = Size.grapheme_size(str)
      @utf8_bytesize = Size.utf8_bytesize(str)
      @utf16_bytesize = Size.utf16_bytesize(str)
      @utf32_bytesize = Size.utf32_bytesize(str)
      @utf8_unitsize = Size.utf8_unitsize(str)
      @utf16_unitsize = Size.utf16_unitsize(str)
      @utf32_unitsize = Size.utf32_unitsize(str)
    end

    # Number of code points
    # @param str [String] Input sting we want to know the size of
    # @return [Integer] number of code points
    # @example
    #   Unisec::Size.code_points_size('👩‍❤️‍👩') # => 6
    def self.code_points_size(str)
      str.size
    end

    # Number of graphemes
    # @param str [String] Input sting we want to know the size of
    # @return [Integer] number of graphemes
    # @example
    #   Unisec::Size.grapheme_size('👩‍❤️‍👩') # => 1
    def self.grapheme_size(str)
      str.grapheme_clusters.size
    end

    # UTF-8 size in bytes
    # @param str [String] Input sting we want to know the size of
    # @return [Integer] UTF-8 size in bytes
    # @example
    #   Unisec::Size.utf8_bytesize('👩‍❤️‍👩') # => 20
    def self.utf8_bytesize(str)
      str.bytesize
    end

    # UTF-16 size in bytes
    # @param str [String] Input sting we want to know the size of
    # @return [Integer] UTF-16 size in bytes
    # @example
    #   Unisec::Size.utf16_bytesize('👩‍❤️‍👩') # => 16
    def self.utf16_bytesize(str)
      str.encode('UTF-16BE').bytesize
    end

    # UTF-32 size in bytes
    # @param str [String] Input sting we want to know the size of
    # @return [Integer] UTF-32 size in bytes
    # @example
    #   Unisec::Size.utf32_bytesize('👩‍❤️‍👩') # => 24
    def self.utf32_bytesize(str)
      str.encode('UTF-32BE').bytesize
    end

    # Number of UTF-8 units
    # @param str [String] Input sting we want to know the size of
    # @return [Integer] number of UTF-8 units
    # @example
    #   Unisec::Size.utf8_unitsize('👩‍❤️‍👩') # => 20
    def self.utf8_unitsize(str)
      utf8_bytesize(str)
    end

    # Number of UTF-16 units
    # @param str [String] Input sting we want to know the size of
    # @return [Integer] number of UTF-16 units
    # @example
    #   Unisec::Size.utf16_unitsize('👩‍❤️‍👩') # => 8
    def self.utf16_unitsize(str)
      utf16_bytesize(str) / 2
    end

    # Number of UTF-32 units
    # @param str [String] Input sting we want to know the size of
    # @return [Integer] number of UTF-32 units
    # @example
    #   Unisec::Size.utf32_unitsize('👩‍❤️‍👩') # => 6
    def self.utf32_unitsize(str)
      utf32_bytesize(str) / 4
    end

    # Display a CLI-friendly output summurizing the size information about a Unicode string.
    # @example
    #   Unisec::Size.new('👩‍❤️‍👨').display
    #   # =>
    #   # Code point(s):   6
    #   # Grapheme(s):     1
    #   # UTF-8 byte(s):   20
    #   # UTF-16 byte(s):  16
    #   # UTF-32 byte(s):  24
    #   # UTF-8 unit(s):   20
    #   # UTF-16 unit(s):  8
    #   # UTF-32 unit(s):  6
    def display
      display = ->(key, value) { puts Paint[key, :red, :bold].ljust(27) + " #{value}" }
      display.call('Code point(s):', @code_points_size)
      display.call('Grapheme(s):', @grapheme_size)
      display.call('UTF-8 byte(s):', @utf8_bytesize)
      display.call('UTF-16 byte(s):', @utf16_bytesize)
      display.call('UTF-32 byte(s):', @utf32_bytesize)
      display.call('UTF-8 unit(s):', @utf8_unitsize)
      display.call('UTF-16 unit(s):', @utf16_unitsize)
      display.call('UTF-32 unit(s):', @utf32_unitsize)
    end
  end
end
