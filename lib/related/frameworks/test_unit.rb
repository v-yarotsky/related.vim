require 'related/frameworks/base'

module Related
  module Frameworks

    class TestUnit < Base
      def test_path_prefix; "test"; end
      def test_file_prefix; "test_"; end

      def is_test?
        related_paths.current_file_relative_to_repo.to_s =~ /^#{test_path_prefix}\//
      end

      def run_test
        vim.command ":!clear && cd #{related_paths.repo_root} && ruby -I#{test_path_prefix} #{test_file}"
      end
    end

  end
end
