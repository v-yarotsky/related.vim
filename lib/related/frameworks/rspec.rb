require 'related/frameworks/base'
require 'related/matcher'

module Related
  module Frameworks

    class Rspec < Base
      def test_path_prefix; "spec"; end
      def test_file_suffix; "_spec"; end

      def is_test?
        related_paths.current_file_relative_to_repo.basename(RUBY_EXT).to_s =~ %r{#{test_file_suffix}$}
      end

      def run_test_command
        "rspec #{test_file}"
      end
    end

  end
end
