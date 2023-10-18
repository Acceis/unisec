# frozen_string_literal: true

require 'twitter_cldr'
require 'paint'

module Unisec
  # Ruby grep : Ruby regular expression search for Unicode code point names
  class Rugrep
    # UCD Derived names file location
    # @see https://www.unicode.org/Public/UCD/latest/ucd/extracted/DerivedName.txt
    UCD_DERIVEDNAME = File.join(__dir__, '../../data/DerivedName.txt')

    # Search code points by (Ruby) regexp
    # @param regexp [Regexp] Regular expression without delimiters or modifiers.
    #   Supports everything Ruby Regexp supports
    # @return [Array<Hash>] Array of code points (`{char: String, codepoint: Integer, name: String}`)
    # @example
    #   Unisec::Rugrep.regrep('snowman|snowflake')
    #   # =>
    #   # [{:char=>"☃", :codepoint=>9731, :name=>"SNOWMAN"},
    #   #  {:char=>"⛄", :codepoint=>9924, :name=>"SNOWMAN WITHOUT SNOW"},
    #   #  {:char=>"⛇", :codepoint=>9927, :name=>"BLACK SNOWMAN"},
    #   #  {:char=>"❄", :codepoint=>10052, :name=>"SNOWFLAKE"},
    #   #  {:char=>"❅", :codepoint=>10053, :name=>"TIGHT TRIFOLIATE SNOWFLAKE"},
    #   #  {:char=>"❆", :codepoint=>10054, :name=>"HEAVY CHEVRON SNOWFLAKE"}]
    #   Unisec::Rugrep.regrep('greek small letter \w+')
    #   # =>
    #   # [{:char=>"ͱ", :codepoint=>881, :name=>"GREEK SMALL LETTER HETA"},
    #   #  {:char=>"ͳ", :codepoint=>883, :name=>"GREEK SMALL LETTER ARCHAIC SAMPI"},
    #   #  {:char=>"ͷ", :codepoint=>887, :name=>"GREEK SMALL LETTER PAMPHYLIAN DIGAMMA"},
    #   #  …]
    def self.regrep(regexp)
      out = []
      file = File.new(UCD_DERIVEDNAME)
      file.each_line(chomp: true) do |line|
        # Skip if the line is empty or a comment
        next if line.empty? || line[0] == '#'

        # parse the line to extract code point as integer and the name
        cp_int, name = line.split(';')
        cp_int = cp_int.chomp.to_i(16)
        name.lstrip!
        next unless /#{regexp}/i.match?(name) # compiling regexp once is surprisingly not faster

        out << {
          char: TwitterCldr::Utils::CodePoints.to_string([cp_int]),
          codepoint: cp_int,
          name: name
        }
      end
      out
    end

    # Display a CLI-friendly output listing all code points corresponding to a regular expression.
    # @example
    #   Unisec::Rugrep.regrep_display('snowman|snowflake')
    #   # =>
    #   # U+2603  ☃    SNOWMAN
    #   # U+26C4  ⛄    SNOWMAN WITHOUT SNOW
    #   # U+26C7  ⛇    BLACK SNOWMAN
    #   # U+2744  ❄    SNOWFLAKE
    #   # U+2745  ❅    TIGHT TRIFOLIATE SNOWFLAKE
    #   # U+2746  ❆    HEAVY CHEVRON SNOWFLAKE
    def self.regrep_display(regexp)
      codepoints = regrep(regexp)
      codepoints.each do |cp|
        puts "#{Properties.deccp2stdhexcp(cp[:codepoint]).ljust(7)} #{cp[:char].ljust(4)} #{cp[:name]}"
      end
      nil
    end

    # Returns the version of Unicode used in UCD local file (data/DerivedName.txt)
    # @return [String] Unicode version
    # @example
    #   Unisec::Rugrep.ucd_derivedname_version # => "15.1.0"
    def self.ucd_derivedname_version
      first_line = File.open(UCD_DERIVEDNAME, &:readline)
      first_line.match(/-(\d+\.\d+\.\d+)\.txt/).captures.first
    end

    # Search code points by (Ruby) regexp
    # @param regexp [Regexp] Regular expression without delimiters or modifiers
    # @return [Array<Hash>] Array of code points (`{char: String, codepoint: Integer, name: String}`)
    # @example
    #   Unisec::Rugrep.regrep_slow('snowman|snowflake')
    #   # =>
    #   # [{:char=>"☃", :codepoint=>9731, :name=>"SNOWMAN"},
    #   #  {:char=>"⛄", :codepoint=>9924, :name=>"SNOWMAN WITHOUT SNOW"},
    #   #  {:char=>"⛇", :codepoint=>9927, :name=>"BLACK SNOWMAN"},
    #   #  {:char=>"❄", :codepoint=>10052, :name=>"SNOWFLAKE"},
    #   #  {:char=>"❅", :codepoint=>10053, :name=>"TIGHT TRIFOLIATE SNOWFLAKE"},
    #   #  {:char=>"❆", :codepoint=>10054, :name=>"HEAVY CHEVRON SNOWFLAKE"}]
    # @note ⚠ This command is very time consuming (~ 1min) and unoptimized (execute one regexp per code point…)
    def self.regrep_slow(regexp)
      out = []
      TwitterCldr::Shared::CodePoint.each do |cp|
        next unless /#{regexp}/oi.match?(cp.name) # compiling regexp once is surprisingly not faster

        out << {
          char: TwitterCldr::Utils::CodePoints.to_string([cp.code_point]),
          codepoint: cp.code_point,
          name: cp.name
        }
      end
      out
    end

    # Display a CLI-friendly output listing all code points corresponding to a regular expression.
    # @example
    #   Unisec::Rugrep.regrep_display_slow('snowman|snowflake')
    #   # =>
    #   # U+2603  ☃    SNOWMAN
    #   # U+26C4  ⛄    SNOWMAN WITHOUT SNOW
    #   # U+26C7  ⛇    BLACK SNOWMAN
    #   # U+2744  ❄    SNOWFLAKE
    #   # U+2745  ❅    TIGHT TRIFOLIATE SNOWFLAKE
    #   # U+2746  ❆    HEAVY CHEVRON SNOWFLAKE
    def self.regrep_display_slow(regexp)
      codepoints = regrep_slow(regexp)
      codepoints.each do |cp|
        puts "#{Properties.deccp2stdhexcp(cp[:codepoint]).ljust(7)} #{cp[:char].ljust(4)} #{cp[:name]}"
      end
      nil
    end
  end
end
