require 'related/errors'
require 'related/matcher'

module Related
  module Frameworks

    class Base
      RUBY_EXT = ".rb"

      attr_accessor :related_paths

      def initialize(related_paths = Related)
        @related_paths = related_paths
      end

      def related_file
        is_test? ? source_for_test : test_for_source
      end

      def test_file
        is_test? ? related_paths.current_file_relative_to_repo : test_for_source
      end

      def run_test
        raise NotImplementedError
      end

      def test_path_prefix
        ""
      end

      def test_file_prefix
        ""
      end

      def test_file_suffix
        ""
      end

      def source_for_test
        source_dir = related_paths.current_file_relative_to_repo.sub(%r{^#{test_path_prefix}/}, "").dirname
        source_file = related_paths.current_file_relative_to_repo.basename(RUBY_EXT).
          sub(/^#{test_file_prefix}/, "").sub(/#{test_file_suffix}$/, "").sub(/$/, RUBY_EXT)
        ideal_match = File.join(related_paths.repo_root, source_dir, source_file)
        matcher.best_match(ideal_match, source_files) || ideal_match
      end

      def test_for_source
        test_dir = related_paths.current_file_relative_to_repo.sub(/^/, "#{test_path_prefix}/").dirname
        test_file = related_paths.current_file_relative_to_repo.basename(RUBY_EXT).
          sub(/^/, test_file_prefix).sub(/$/, test_file_suffix).sub(/$/, RUBY_EXT)
        ideal_match = File.join(related_paths.repo_root, test_dir, test_file)
        matcher.best_match(ideal_match, test_files) || ideal_match
      end

      def is_test?
        raise NotImplementedError
      end

      def matcher
        Matcher.new
      end

      def test_files
        Dir.glob(File.join(related_paths.repo_root, test_path_prefix, "**", "#{test_file_prefix}*#{test_file_suffix}#{RUBY_EXT}"))
      end

      def source_files
        Dir.glob(File.join(related_paths.repo_root, "**", "*#{RUBY_EXT}")) - test_files
      end
    end

  end
end

