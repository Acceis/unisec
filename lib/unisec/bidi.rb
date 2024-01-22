# frozen_string_literal: true

require 'unisec/utils'
require 'ctf_party'

module Unisec
  # Manipulation of bidirectional related content
  class Bidi
    # Attack using BiDi code points like RtLO, for example, for spoofing a domain name or a file name
    class Spoof
      # The target string to spoof (eg. URL, domain or file name)
      # @return [String] the target string
      attr_reader :target_display

      # Set a new target string to spoof
      #
      # It will automatically set `@spoof_string` and `@spoof_payload` as well.
      # @param input [String] the target string
      # @param opts [Hash] optional parameters, see {Spoof.bidi_affix}
      # @return [String] the target string
      def set_target_display(input, **opts)
        @target_display = input
        @spoof_string = reverse(**opts)
        @spoof_payload = bidi_affix(**opts)
        @target_display
      end

      # The string for the spoofing attack without the BiDi characters
      # @return [String] the spoof string (without BiDi)
      attr_reader :spoof_string

      # The string for the spoofing attack with the BiDi characters. (Spoof payload = spoof string + BiDi)
      # @return [String] the spoof string (with BiDi)
      attr_reader :spoof_payload

      # @param input [String] the target string
      # @param opts [Hash] optional parameters, see {Spoof.bidi_affix}
      # @example
      #   bd = Unisec::Bidi::Spoof.new('https://moc.example.org//:sptth')
      #   bd.target_display # => "https://moc.example.org//:sptth"
      #   bd.spoof_string # => "https://gro.elpmaxe.com//:sptth"
      #   bd.spoof_payload => "‮https://gro.elpmaxe.com//:sptth‬"
      def initialize(input, **opts)
        opts[:index] ||= opts[:infix_pos]

        @target_display = input
        @spoof_string = reverse(**opts)
        @spoof_payload = bidi_affix(**opts)
      end

      # Reverse the (sub)-string (grapheme cluster aware)
      # @param target [String] string to reverse
      # @param opts [Hash] optional parameters
      # @option opts [String] :index Index at which the revese starts (before this position will be left untouched)
      # @return [String] the reversed string
      # @example
      #   Unisec::Bidi::Spoof.reverse('document_anntxt.exe', index: 12)
      #   # => "document_annexe.txt"
      #
      #   Unisec::Bidi::Spoof.reverse("🇫🇷🐓")
      #   # => "🐓🇫🇷"
      def self.reverse(target, **opts)
        opts[:index] ||= 0

        target[0...opts[:index]] + Unisec::Utils::String.grapheme_reverse(target[opts[:index]..])
      end

      # Call {Spoof.reverse} with `@target_display` as default input (target).
      def reverse(**opts)
        Spoof.reverse(@target_display, **opts)
      end

      # Inject BiDi characters into the input string
      # @param input [String] input string
      # @param opts [Hash] optional parameters
      # @option opts [String] :prefix Prefix Bidi. Default: RLO (U+202E).
      # @option opts [String] :suffix Suffix Bidi. Default: PDF (U+202C).
      # @option opts [String] :infix_bidi Bidi injected at a chosen position. Default: none (empty string).
      # @option opts [String] :infix_pos Position (index) where to inject an extra BiDi. Default: 0.
      # @return [String] spoof payload (input string with injected BiDi)
      # @example
      #   # By default inject a RLO prefix, a PDF suffix and no infix.
      #   Unisec::Bidi::Spoof.bidi_affix('acceis')
      #   # => "‮acceis‬"
      #
      #   # RLI ... PDI
      #   Unisec::Bidi::Spoof.bidi_affix('acceis', prefix: "\u{2067}", suffix: "\u{2069}")
      #   # => "⁧acceis⁩"
      #
      #   # RLE ... PDF
      #   Unisec::Bidi::Spoof.bidi_affix('acceis', prefix: "\u{202B}", suffix: "\u{202C}")
      #   # => "‫acceis‬"
      #
      #   # RLO ... PDF
      #   Unisec::Bidi::Spoof.bidi_affix('https://moc.example.org//:sptth', prefix: "\u{202E}", suffix: "\u{202C}")
      #   # => "‮https://moc.example.org//:sptth‬"
      #
      #   # FSI RLO ... PDF PDI
      #   Unisec::Bidi::Spoof.bidi_affix('https://moc.example.org//:sptth', prefix: "\u{2068 202E}", suffix: "\u{202C 2069}")
      #   # => "⁨‮https://moc.example.org//:sptth‬⁩"
      #
      #   # RLM ...
      #   Unisec::Bidi::Spoof.bidi_affix('unicode', prefix: "\u{200F}", suffix: '')
      #   # => "‏unicode"
      #
      #   # For file name spoofing, it is useful to be able to inject just a RLO before the fake extension
      #   # so we can void the prefix and suffix and just set the position of an infix
      #   ex = Unisec::Bidi::Spoof.bidi_affix('document_anntxt.exe', prefix: '', suffix: '', infix_bidi: "\u{202E}", infix_pos: 12)
      #   # => "document_ann‮txt.exe"
      #   puts ex
      #   # document_ann‮txt.exe
      def self.bidi_affix(input, **opts)
        opts[:prefix] ||= "\u{202E}" # RLO
        opts[:suffix] ||= "\u{202C}" # PDF
        opts[:infix_bidi] ||= ''
        opts[:infix_pos] ||= 0

        out = "#{opts[:prefix]}#{input}#{opts[:suffix]}"
        out.insert(opts[:infix_pos], opts[:infix_bidi])
        out
      end

      # Call {Spoof.bidi_affix} with `@spoof_string` as input.
      def bidi_affix(**opts)
        Spoof.bidi_affix(@spoof_string, **opts)
      end

      # Display a CLI-friendly output summurizing the spoof payload
      #
      # The light version displays only the spoof payload for easy piping with other commands.
      # @param light [Boolean] `true` = light display (displays only the spoof payload for easy piping with other commands), `false` (default) = full display.
      # @example
      #   puts Unisec::Bidi::Spoof.new('noraj').display
      #   # Target string: noraj
      #   # Spoof payload (display) ⚠: ‮jaron‬
      #   # Spoof string 🛈: jaron
      #   # Spoof payload (hex): e280ae6a61726f6ee280ac
      #   # Spoof payload (hex, escaped): \xe2\x80\xae\x6a\x61\x72\x6f\x6e\xe2\x80\xac
      #   # Spoof payload (base64): 4oCuamFyb27igKw=
      #   # Spoof payload (urlencode): %E2%80%AEjaron%E2%80%AC
      #   # Spoof payload (code points): U+202E U+006A U+0061 U+0072 U+006F U+006E U+202C
      #   #
      #   #
      #   #
      #   # ⚠: for the spoof payload to display correctly, be sure your VTE has RTL support, e.g. see https://wiki.archlinux.org/title/Bidirectional_text#Terminal.
      #   # 🛈: Does not contain the BiDi character (e.g. RtLO).
      #
      #   puts Unisec::Bidi::Spoof.new('noraj').display(light: true)
      #   # ‮jaron‬
      def display(light: false)
        if light == false # full display
          "Target string: #{@target_display}\n" \
            "Spoof payload (display) ⚠: #{@spoof_payload}\n" \
            "Spoof string 🛈: #{@spoof_string}\n" \
            "Spoof payload (hex): #{@spoof_payload.to_hex}\n" \
            "Spoof payload (hex, escaped): #{@spoof_payload.to_hex(prefixall: '\\x')}\n" \
            "Spoof payload (base64): #{@spoof_payload.to_b64}\n" \
            "Spoof payload (urlencode): #{@spoof_payload.urlencode}\n" \
            "Spoof payload (code points): #{Unisec::Properties.chars2codepoints(@spoof_payload)}\n" \
            "\n\n\n" \
            '⚠: for the spoof payload to display correctly, be sure your VTE has RTL support, ' \
            "e.g. see https://wiki.archlinux.org/title/Bidirectional_text#Terminal.\n" \
            '🛈: Does not contain the BiDi character (e.g. RtLO).'
        else # light display
          @spoof_payload
        end
      end
    end
  end
end
