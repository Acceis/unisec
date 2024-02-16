# frozen_string_literal: true

require 'ctf_party'

module Unisec
  # Normalization Forms
  class Normalization
    # Original input
    # @return [String] untouched input
    attr_reader :original

    # Normalization Form C (NFC) - Canonical Decomposition, followed by Canonical Composition
    # @return [String] input normalized with NFC
    attr_reader :nfc

    # Normalization Form KC (NFKC) - Compatibility Decomposition, followed by Canonical Composition
    # @return [String] input normalized with NFKC
    attr_reader :nfkc

    # Normalization Form D (NFD) - Canonical Decomposition
    # @return [String] input normalized with NFD
    attr_reader :nfd

    # Normalization Form KD (NFKD) - Compatibility Decomposition
    # @return [String] input normalized with NFKD
    attr_reader :nfkd

    # Generate all normilzation forms for a given input
    # @param str [String] the target string
    # @return [nil]
    def initialize(str)
      @original = str
      @nfc = Normalization.nfc(str)
      @nfkc = Normalization.nfkc(str)
      @nfd = Normalization.nfd(str)
      @nfkd = Normalization.nfkd(str)
    end

    # Normalization Form C (NFC) - Canonical Decomposition, followed by Canonical Composition
    # @param str [String] the target string
    # @return [String] input normalized with NFC
    def self.nfc(str)
      str.unicode_normalize(:nfc)
    end

    # Normalization Form KC (NFKC) - Compatibility Decomposition, followed by Canonical Composition
    # @param str [String] the target string
    # @return [String] input normalized with NFKC
    def self.nfkc(str)
      str.unicode_normalize(:nfkc)
    end

    # Normalization Form D (NFD) - Canonical Decomposition
    # @param str [String] the target string
    # @return [String] input normalized with NFD
    def self.nfd(str)
      str.unicode_normalize(:nfd)
    end

    # Normalization Form KD (NFKD) - Compatibility Decomposition
    # @param str [String] the target string
    # @return [String] input normalized with NFKD
    def self.nfkd(str)
      str.unicode_normalize(:nfkd)
    end

    # Display a CLI-friendly output summurizing all normalization forms
    # @return [String] CLI-ready output
    # @example
    #   puts Unisec::Normalization.new("\u{1E9B 0323}").display
    #   # =>
    #   # Original: ẛ̣
    #   #   U+1E9B U+0323
    #   # NFC: ẛ̣
    #   #   U+1E9B U+0323
    #   # NFKC: ṩ
    #   #   U+1E69
    #   # NFD: ẛ̣
    #   #   U+017F U+0323 U+0307
    #   # NFKD: ṩ
    #   #   U+0073 U+0323 U+0307
    def display
      colorize = lambda { |form_title, form_attr|
        "#{Paint[form_title.to_s, :underline,
                 :bold]}: #{form_attr}\n  #{Paint[Unisec::Properties.chars2codepoints(form_attr), :red]}\n"
      }
      colorize.call('Original', @original) +
        colorize.call('NFC', @nfc) +
        colorize.call('NFKC', @nfkc) +
        colorize.call('NFD', @nfd) +
        colorize.call('NFKD', @nfkd)
    end
  end
end
