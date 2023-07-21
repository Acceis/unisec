# frozen_string_literal: true

require 'twitter_cldr'
require 'paint'

module Unisec
  # Manipulate Unicode properties
  class Properties
    # List Unicode properties name
    # @return [Array<String>] properties name
    # @example
    #   Unisec::Properties.list # => ["ASCII_Hex_Digit", "Age", "Alphabetic", … ]
    def self.list
      TwitterCldr::Shared::CodePoint.properties.property_names
    end

    # List all code points for a given property
    # @param prop [String] the property name
    # @return [Array<Hash>] Array of code points (`{char: String, codepoint: Integer, name: String}`)
    # @example
    #   Unisec::Properties.codepoints('Quotation_Mark')
    #   # =>
    #   # [{:char=>"\"", :codepoint=>34, :name=>"QUOTATION MARK"},
    #   #  {:char=>"'", :codepoint=>39, :name=>"APOSTROPHE"},
    #   #  … ]
    def self.codepoints(prop)
      cp = TwitterCldr::Shared::CodePoint
      out = []
      ranges = cp.properties.code_points_for_property(prop).ranges
      ranges.each do |range|
        range.each do |i|
          codepoint = cp.get(i)
          out << {
            char: TwitterCldr::Utils::CodePoints.to_string([codepoint.code_point]),
            codepoint: codepoint.code_point,
            name: codepoint.name
          }
        end
      end
      out
    end

    # Display a CLI-friendly output listing all code points corresponding to a property.
    # @example
    #   Unisec::Properties.codepoints_display('Quotation_Mark')
    #   # =>
    #   # U+0022      "    QUOTATION MARK
    #   # U+0027      '    APOSTROPHE
    #   # …
    def self.codepoints_display(prop)
      codepoints = Properties.codepoints(prop)
      codepoints.each do |cp|
        puts "#{Properties.char2codepoint(cp[:char]).ljust(7)} #{cp[:char].ljust(4)} #{cp[:name]}"
      end
      nil
    end

    # Returns all properties of a given unicode character (code point)
    # @param chr [String] Unicode code point (as character / string)
    # @return [Hash] All properties of the given code point
    # @example
    #   Unisec::Properties.char('é')
    #   # =>
    #   # {:age=>"1.1",
    #   # … }
    def self.char(chr)
      cp_num = TwitterCldr::Utils::CodePoints.from_string(chr)
      cp = TwitterCldr::Shared::CodePoint.get(cp_num.first)
      props = cp.properties
      props_hash = props.properties_hash.dup
      %w[Age Block General_Category Script].each { |p| props_hash.delete(p) } # Remaining properties
      categories = props.general_category.map do |cat|
        TwitterCldr::Shared::PropertyValueAliases.long_alias_for('gc', cat)
      end
      {
        age: props.age.join,
        block: props.block.join,
        category: categories[1],
        subcategory: categories[0],
        codepoint: Properties.char2codepoint(chr),
        name: cp.name,
        script: props.script.join,
        case: {
          ruby: {
            lowercase: chr.downcase,
            uppercase: chr.upcase
          },
          twitter: {
            lowercase: chr.localize.downcase.to_s,
            uppercase: chr.localize.upcase.to_s,
            titlecase: chr.localize.titlecase.to_s,
            casefold: chr.localize.casefold.to_s
          }
        },
        normalization: {
          ruby: {
            nfkd: chr.unicode_normalize(:nfkd),
            nfkc: chr.unicode_normalize(:nfkc),
            nfd: chr.unicode_normalize(:nfd),
            nfc: chr.unicode_normalize(:nfc)
          },
          twitter: {
            nfkd: chr.localize.normalize(using: :NFKD).to_s,
            nfkc: chr.localize.normalize(using: :NFKC).to_s,
            nfd: chr.localize.normalize(using: :NFD).to_s,
            nfc: chr.localize.normalize(using: :NFC).to_s
          }
        },
        other_properties: props_hash
      }
    end

    # Display a CLI-friendly output listing all properties corresponding to character (code point)
    # @param chr [String] Unicode code point (as character / string)
    # @param extended [String] By default, it will only show common properties, with extended set to `true` it will
    #   show all of them.
    def self.char_display(chr, extended: false)
      data = Properties.char(chr)
      display = ->(key, value) { puts Paint[key, :red, :bold].ljust(30) + " #{value}" }
      display.call('Name:', data[:name])
      display.call('Code Point:', data[:codepoint])
      puts
      display.call('Block:', data[:block])
      display.call('Category:', data[:category])
      display.call('Sub-Category:', data[:subcategory])
      display.call('Script:', data[:script])
      display.call('Since (age):', "Version #{data[:age]}")
      puts
      x = data.dig(:case, :twitter, :uppercase)
      display.call('Uppercase:', x + " (#{Properties.char2codepoint(x)})")
      x = data.dig(:case, :twitter, :lowercase)
      display.call('Lowercase:', x + " (#{Properties.char2codepoint(x)})")
      x = data.dig(:case, :twitter, :titlecase)
      display.call('Titlecase:', x + " (#{Properties.char2codepoint(x)})")
      x = data.dig(:case, :twitter, :casefold)
      display.call('Casefold:', x + " (#{Properties.char2codepoint(x)})")
      puts
      x = data.dig(:normalization, :twitter, :nfkd)
      display.call('Normalization NFKD:', x + " (#{Properties.chars2codepoints(x)})")
      x = data.dig(:normalization, :twitter, :nfkc)
      display.call('Normalization NFKC:', x + " (#{Properties.chars2codepoints(x)})")
      x = data.dig(:normalization, :twitter, :nfd)
      display.call('Normalization NFD:', x + " (#{Properties.chars2codepoints(x)})")
      x = data.dig(:normalization, :twitter, :nfc)
      display.call('Normalization NFC:', x + " (#{Properties.chars2codepoints(x)})")
      if extended
        puts
        data[:other_properties].each do |k, v|
          display.call(k, v&.join)
        end
      end
      nil
    end

    # Display the code point in Unicode format for a given character (code point as string)
    # @param chr [String] Unicode code point (as character / string)
    # @return [String] code point in Unicode format
    # @example
    #   Unisec::Properties.char2codepoint('💎') # => "U+1F48E"
    def self.char2codepoint(chr)
      "U+#{format('%.4x', chr.codepoints.first).upcase}"
    end

    # Display the code points in Unicode format for the given characters (code points as string)
    # @param chrs [String] Unicode code points (as characters / string)
    # @return [String] code points in Unicode format
    # @example
    #   Unisec::Properties.chars2codepoints("ỳ́") # => "U+0079 U+0300 U+0301"
    #   Unisec::Properties.chars2codepoints("🧑‍🌾") # => "U+1F9D1 U+200D U+1F33E"
    def self.chars2codepoints(chrs)
      out = []
      chrs.each_char do |chr|
        out << Properties.char2codepoint(chr)
      end
      out.join(' ')
    end
  end
end
