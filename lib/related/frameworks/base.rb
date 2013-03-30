module Related
  module Frameworks

    class Base
      attr_accessor :vim, :related_paths

      def initialize(related_paths = Related, vim = VIM)
        @vim, @related_paths = vim, related_paths
      end

      def open_related_file
        related_file = is_test? ? source_for_test : test_for_source
        vim.command "silent :e #{related_file}"
      end

      def test_file
        is_test? ? related_paths.current_file_relative_to_repo : test_for_source
      end

      def run_test
        raise NotImplementedError
      end

      def source_for_test
        raise NotImplementedError
      end

      def test_for_source
        raise NotImplementedError
      end

      def is_test?
        raise NotImplementedError
      end
    end

  end
end

