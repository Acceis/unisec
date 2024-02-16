# frozen_string_literal: true

require 'dry/cli'
require 'unisec'
require 'unisec/utils'

module Unisec
  module CLI
    module Commands
      # CLI sub-commands `unisec normalize xxx` for the class {Unisec::Normalization} from the lib.
      #
      # Command `unisec normalize "example"`
      #
      # Example:
      #
      # ```plaintext
      # ➜ unisec normalize ẛ̣
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
      # ➜ unisec normalize ẛ̣  --form nfkd
      # ṩ
      # ```
      class Normalize < Dry::CLI::Command
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
    end
  end
end
