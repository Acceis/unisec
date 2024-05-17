# frozen_string_literal: true

require 'dry/cli'
require 'unisec'
require 'unisec/utils'

module Unisec
  module CLI
    module Commands
      # CLI sub-commands `unisec normalize xxx` for the class {Unisec::Normalization} from the lib.
      module Normalize
        # Command `unisec normalize all "example"`
        #
        # Example:
        #
        # ```plaintext
        # ➜ unisec normalize all ẛ̣
        # Original: ẛ̣
        #   U+1E9B U+0323
        # NFC: ẛ̣
        #   U+1E9B U+0323
        # NFKC: ṩ
        #   U+1E69
        # NFD: ẛ̣
        #   U+017F U+0323 U+0307
        # NFKD: ṩ
        #   U+0073 U+0323 U+0307
        #
        # ➜ unisec normalize all ẛ̣  --form nfkd
        # ṩ
        # ```
        class All < Dry::CLI::Command
          desc 'Normalize in all forms'

          argument :input, required: true,
                           desc: 'String input. Read from STDIN if equal to -.'

          option :form, default: nil, values: %w[nfc nfkc nfd nfkd],
                        desc: 'Output only in the specified normalization form.'

          # Normalize in all forms
          # @param input [String] Input string to normalize
          def call(input: nil, **options)
            input = $stdin.read.chomp if input == '-'
            if options[:form].nil?
              puts Unisec::Normalization.new(input).display
            else
              # using send() is safe here thanks to the value whitelist
              puts Unisec::Normalization.send(options[:form], input)
            end
          end
        end

        # Command `unisec normalize replace "example"`
        #
        # Example:
        #
        # ```plaintext
        # ➜ unisec normalize replace "<svg onload=\"alert('XSS')\">"
        # Original: <svg onload="alert('XSS')">
        #   U+003C U+0073 U+0076 U+0067 U+0020 U+006F U+006E U+006C U+006F U+0061 U+0064 U+003D U+0022 U+0061 U+006C U+0065 U+0072 U+0074 U+0028 U+0027 U+0058 U+0053 U+0053 U+0027 U+0029 U+0022 U+003E
        # Bypass payload: ﹤svg onload=＂alert(＇XSS＇)＂﹥
        #   U+FE64 U+0073 U+0076 U+0067 U+0020 U+006F U+006E U+006C U+006F U+0061 U+0064 U+003D U+FF02 U+0061 U+006C U+0065 U+0072 U+0074 U+0028 U+FF07 U+0058 U+0053 U+0053 U+FF07 U+0029 U+FF02 U+FE65
        # NFKC: <svg onload="alert('XSS')">
        #   U+003C U+0073 U+0076 U+0067 U+0020 U+006F U+006E U+006C U+006F U+0061 U+0064 U+003D U+0022 U+0061 U+006C U+0065 U+0072 U+0074 U+0028 U+0027 U+0058 U+0053 U+0053 U+0027 U+0029 U+0022 U+003E
        # NFKD: <svg onload="alert('XSS')">
        #   U+003C U+0073 U+0076 U+0067 U+0020 U+006F U+006E U+006C U+006F U+0061 U+0064 U+003D U+0022 U+0061 U+006C U+0065 U+0072 U+0074 U+0028 U+0027 U+0058 U+0053 U+0053 U+0027 U+0029 U+0022 U+003E
        #
        # ➜ echo -n "<svg onload=\"alert('XSS')\">" | unisec normalize replace -
        # ```
        class Replace < Dry::CLI::Command
          desc 'Prepare a XSS payload for HTML escape bypass (HTML escape followed by NFKC / NFKD normalization)'

          argument :input, required: true,
                           desc: 'String input. Read from STDIN if equal to -.'

          # Prepare a XSS payload for HTML escape bypass (HTML escape followed by NFKC / NFKD normalization)
          # @param input [String] Input string to normalize
          def call(input: nil, **_options)
            input = $stdin.read.chomp if input == '-'
            puts Unisec::Normalization.new(input).display_replace
          end
        end
      end
    end
  end
end
