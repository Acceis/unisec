# frozen_string_literal: true

require 'dry/cli'
require 'unisec'
require 'unisec/utils'

module Unisec
  module CLI
    module Commands
      # CLI sub-commands `unisec bidi xxx` for the class {Unisec::Bidi} from the lib.
      module Bidi
        # Command `unisec bidi spoof`
        #
        # Example:
        #
        # ```plaintext
        # $ unisec bidi spoof noraj
        # Target string: noraj
        # Spoof payload (display) ⚠: ‮jaron‬
        # Spoof string 🛈: jaron
        # Spoof payload (hex): e280ae6a61726f6ee280ac
        # Spoof payload (hex, escaped): \xe2\x80\xae\x6a\x61\x72\x6f\x6e\xe2\x80\xac
        # Spoof payload (base64): 4oCuamFyb27igKw=
        # Spoof payload (urlencode): %E2%80%AEjaron%E2%80%AC
        # Spoof payload (code points): U+202E U+006A U+0061 U+0072 U+006F U+006E U+202C
        #
        #
        #
        # ⚠: for the spoof payload to display correctly, be sure your VTE has RTL support, e.g. see https://wiki.archlinux.org/title/Bidirectional_text#Terminal.
        # 🛈: Does not contain the BiDi character (e.g. RtLO).
        #
        # $ unisec bidi spoof 'document_annexe.txt' --prefix '' --suffix '' --infix-bidi $'\U202E' --infix-pos 12 --light=true
        # document_ann‮txt.exe
        # ```
        class Spoof < Dry::CLI::Command
          desc 'Craft a payload for BiDi attacks (for example, for spoofing a domain name or a file name)'

          argument :input, required: true,
                           desc: 'String input'
          option :light, default: false, values: %w[true false],
                         desc: 'true = light display (displays only the spoof payload for easy piping with other ' \
                               'commands), false = full display'
          option :prefix, default: nil, desc: 'Prefix Bidi. Default: RLO (U+202E).'
          option :suffix, default: nil, desc: 'Suffix Bidi. Default: PDF (U+202C).'
          option :infix_bidi, default: nil, desc: 'Bidi injected at a chosen position. Default: none (empty string).'
          option :infix_pos, default: nil, desc: 'Spoof payload (input string with injected BiDi)'

          # Craft a payload for BiDi attacks
          # @param input [String] Input string to spoof
          # @param options [Hash] optional parameters, see {Unisec::Bidi::Spoof.bidi_affix}
          def call(input: nil, **options)
            to_bool = ->(str) { ['true', true].include?(str) }
            light = to_bool.call(options.fetch(:light))
            infix_pos = options[:infix_pos].to_i unless options[:infix_pos].nil?
            puts Unisec::Bidi::Spoof.new(input, prefix: options[:prefix], suffix: options[:suffix],
                                                infix_bidi: options[:infix_bidi],
                                                infix_pos: infix_pos).display(light: light)
          end
        end
      end
    end
  end
end
