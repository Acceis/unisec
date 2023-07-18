# frozen_string_literal: true

require 'dry/cli'
require 'unisec'

module Unisec
  module CLI
    module Commands
      # CLI commands `unisec hexdumps xxx` for the class {Unisec::Hexdump} from the lib.
      class Hexdump < Dry::CLI::Command
        desc 'Hexdump in all Unicode encodings'

        argument :input, required: true,
                         desc: 'String input'

        # Hexdump of all Unicode encodings.
        # @param input [String] Input string to encode
        def call(input: nil, **)
          puts Unisec::Hexdump.new(input).display
        end
      end
    end
  end
end
