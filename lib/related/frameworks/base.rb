require 'related/errors'
require 'related/matcher'

module Related
  module Frameworks

    class Base
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

      def source_ext
        ".rb"
      end
      alias_method :test_ext, :source_ext

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
        ideal_match = File.join(related_paths.repo_root, source_dir, source_file_basename)
        best_file_match_or_new(ideal_match, source_files)
      end

      def source_file_basename
        related_paths.current_file_relative_to_repo.basename(test_ext).
          sub(/^#{test_file_prefix}/, "").sub(/#{test_file_suffix}$/, "").sub(/$/, source_ext)
      end
      private :source_file_basename

      def source_dir
        related_paths.current_file_relative_to_repo.sub(%r{^#{test_path_prefix}/}, "").dirname
      end
      private :source_dir

      def test_for_source
        ideal_match = File.join(related_paths.repo_root, test_dir, test_file_basename)
        best_file_match_or_new(ideal_match, test_files)
      end

      def test_dir
        related_paths.current_file_relative_to_repo.sub(/^/, "#{test_path_prefix}/").dirname
      end
      private :test_dir

      def test_file_basename
        related_paths.current_file_relative_to_repo.basename(source_ext).
          sub(/^/, test_file_prefix).sub(/$/, test_file_suffix).sub(/$/, test_ext)
      end
      private :test_file_basename

      def best_file_match_or_new(ideal_match, files)
        Pathname.new(matcher.best_match(ideal_match, files) || ideal_match).cleanpath.to_s
      end
      private :best_file_match_or_new

      def is_test?
        raise NotImplementedError
      end

      def matcher
        Matcher.new
      end

      def test_files
        Dir.glob(File.join(related_paths.repo_root, test_path_prefix, "**", "#{test_file_prefix}*#{test_file_suffix}#{test_ext}"))
      end

      def source_files
        Dir.glob(File.join(related_paths.repo_root, "**", "*#{source_ext}")) - test_files
      end

    end

  end
end

