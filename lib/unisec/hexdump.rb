# frozen_string_literal: true

require 'ctf_party'

module Unisec
  # Hexdump of all Unicode encodings.
  class Hexdump
    # UTF-8 hexdump
    # @return [String] UTF-8 hexdump
    attr_reader :utf8

    # UTF-16BE hexdump
    # @return [String] UTF-16BE hexdump
    attr_reader :utf16be

    # UTF-16LE hexdump
    # @return [String] UTF-16LE hexdump
    attr_reader :utf16le

    # UTF-32BE hexdump
    # @return [String] UTF-32BE hexdump
    attr_reader :utf32be

    # UTF-32LE hexdump
    # @return [String] UTF-32LE hexdump
    attr_reader :utf32le

    # Init the hexdump.
    # @param str [String] Input string to encode
    # @example
    #   hxd = Unisec::Hexdump.new('I 💕 Ruby 💎')
    #   hxd.utf8 # => "49 20 f0 9f 92 95 20 52 75 62 79 20 f0 9f 92 8e"
    #   hxd.utf16be # => "0049 0020 d83d dc95 0020 0052 0075 0062 0079 0020 d83d dc8e"
    #   hxd.utf32be # => "00000049 00000020 0001f495 00000020 00000052 00000075 00000062 00000079 00000020 0001f48e"
    def initialize(str)
      @utf8 = Hexdump.utf8(str)
      @utf16be = Hexdump.utf16be(str)
      @utf16le = Hexdump.utf16le(str)
      @utf32be = Hexdump.utf32be(str)
      @utf32le = Hexdump.utf32le(str)
    end

    # Encode to UTF-8 in hexdump format (spaced at every code unit = every byte)
    # @param str [String] Input string to encode
    # @return [String] hexdump (UTF-8 encoded)
    # @example
    #   Unisec::Hexdump.utf8('🐋') # => "f0 9f 90 8b"
    def self.utf8(str)
      str.encode('UTF-8').to_hex.scan(/.{2}/).join(' ')
    end

    # Encode to UTF-16BE in hexdump format (spaced at every code unit = every 2 bytes)
    # @param str [String] Input string to encode
    # @return [String] hexdump (UTF-16BE encoded)
    # @example
    #   Unisec::Hexdump.utf16be('🐋') # => "d83d dc0b"
    def self.utf16be(str)
      str.encode('UTF-16BE').to_hex.scan(/.{4}/).join(' ')
    end

    # Encode to UTF-16LE in hexdump format (spaced at every code unit = every 2 bytes)
    # @param str [String] Input string to encode
    # @return [String] hexdump (UTF-16LE encoded)
    # @example
    #   Unisec::Hexdump.utf16le('🐋') # => "3dd8 0bdc"
    def self.utf16le(str)
      str.encode('UTF-16LE').to_hex.scan(/.{4}/).join(' ')
    end

    # Encode to UTF-32BE in hexdump format (spaced at every code unit = every 4 bytes)
    # @param str [String] Input string to encode
    # @return [String] hexdump (UTF-32BE encoded)
    # @example
    #   Unisec::Hexdump.utf32be('🐋') # => "0001f40b"
    def self.utf32be(str)
      str.encode('UTF-32BE').to_hex.scan(/.{8}/).join(' ')
    end

    # Encode to UTF-32LE in hexdump format (spaced at every code unit = every 4 bytes)
    # @param str [String] Input string to encode
    # @return [String] hexdump (UTF-32LE encoded)
    # @example
    #   Unisec::Hexdump.utf32le('🐋') # => "0bf40100"
    def self.utf32le(str)
      str.encode('UTF-32LE').to_hex.scan(/.{8}/).join(' ')
    end

    # Display a CLI-friendly output summurizing the hexdump in all Unicode encodings
    # @example
    #   puts Unisec::Hexdump.new('K').display # =>
    #   # UTF-8: e2 84 aa
    #   # UTF-16BE: 212a
    #   # UTF-16LE: 2a21
    #   # UTF-32BE: 0000212a
    #   # UTF-32LE: 2a210000
    def display
      "UTF-8: #{@utf8}\n" \
        "UTF-16BE: #{@utf16be}\n" \
        "UTF-16LE: #{@utf16le}\n" \
        "UTF-32BE: #{@utf32be}\n" \
        "UTF-32LE: #{@utf32le}"
    end
  end
end
