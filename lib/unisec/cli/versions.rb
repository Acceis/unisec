# frozen_string_literal: true

require 'dry/cli'
require 'unisec'

module Unisec
  module CLI
    module Commands
      # CLI command `unisec versions` for the class {Unisec::Versions} from the lib.
      #
      # Example:
      #
      # ```plaintext
      # $ unisec versions
      # Unicode:
      # Unicode (Ruby)                    15.0.0
      # Unicode (twitter_cldr gem)        14.0.0
      # Unicode (unicode-confusable gem)  15.0.0
      # ICU (twitter_cldr gem)            70.1
      # CLDR (twitter_cldr gem)           40
      # Unicode emoji (Ruby)              15.0
      #
      # Gems:
      # unisec                            0.0.1
      # twitter_cldr gem                  6.11.5
      # unicode-confusable gem            1.9.0
      # ```
      class Versions < Dry::CLI::Command
        desc 'Version of anything related to Unicode as used in unisec'

        # Version of anything related to Unicode as used in unisec.
        def call(**)
          puts Unisec::Versions.display
        end
      end
    end
  end
end
