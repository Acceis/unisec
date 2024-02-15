# frozen_string_literal: true

require 'twitter_cldr'
require 'unicode/confusable'
require 'paint'

module Unisec
  # Version information related to Unicode used in Unisec
  class Versions
    # Version and label of anything related to Unicode used in Unisec
    # @return [Hash] versions of each component
    # @example
    #   Unisec::Versions.versions
    #   # =>
    #   # {:unisec=>{:version=>"0.0.1", :label=>"unisec"},
    #   #  … }
    def self.versions # rubocop:disable Metrics/MethodLength
      {
        unisec: {
          version: Unisec::VERSION,
          label: 'unisec'
        },
        ruby_unicode: {
          version: RbConfig::CONFIG['UNICODE_VERSION'],
          label: 'Unicode (Ruby)'
        },
        ruby_unicode_emoji: {
          version: RbConfig::CONFIG['UNICODE_EMOJI_VERSION'],
          label: 'Unicode emoji (Ruby)'
        },
        twittercldr_cldr: {
          version: TwitterCldr::Versions::CLDR_VERSION,
          label: 'CLDR (twitter_cldr gem)'
        },
        twittercldr_icu: {
          version: TwitterCldr::Versions::ICU_VERSION,
          label: 'ICU (twitter_cldr gem)'
        },
        twittercldr_unicode: {
          version: TwitterCldr::Versions::UNICODE_VERSION,
          label: 'Unicode (twitter_cldr gem)'
        },
        twittercldr: {
          version: TwitterCldr::VERSION,
          label: 'twitter_cldr gem'
        },
        unicodeconfusable: {
          version: Unicode::Confusable::VERSION,
          label: 'unicode-confusable gem'
        },
        unicodeconfusable_unicode: {
          version: Unicode::Confusable::UNICODE_VERSION,
          label: 'Unicode (unicode-confusable gem)'
        },
        ucd_derivedname: {
          version: Unisec::Rugrep.ucd_derivedname_version,
          label: 'UCD (data/DerivedName.txt)'
        }
      }
    end

    # Display a CLI-friendly output of the version of anything related to Unicode used in unisec
    # @example
    #   Unisec::Versions.display
    #   # =>
    #   # Unicode:
    #   # Unicode (Ruby)                    15.0.0
    #   # …
    #   #
    #   # Gems:
    #   # unisec                            0.0.1
    #   # …
    def self.display # rubocop:disable Metrics/AbcSize
      data = versions
      colorize = ->(node) { Paint[data[node][:label], :red, :bold].ljust(44) + " #{data[node][:version]}\n" }
      Paint["Unicode:\n", :underline] +
        colorize.call(:ruby_unicode) +
        colorize.call(:twittercldr_unicode) +
        colorize.call(:unicodeconfusable_unicode) +
        colorize.call(:twittercldr_icu) +
        colorize.call(:twittercldr_cldr) +
        colorize.call(:ruby_unicode_emoji) +
        colorize.call(:ucd_derivedname) +
        Paint["\nGems:\n", :underline] +
        colorize.call(:unisec) +
        colorize.call(:twittercldr) +
        colorize.call(:unicodeconfusable)
    end
  end
end
