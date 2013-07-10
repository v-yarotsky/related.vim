require 'related/frameworks/base'

module Related
  module Frameworks

    class Nose < Base
      def test_file_prefix; "test_"; end
      def source_ext; ".py"; end
      def test_ext;   ".py"; end

      def is_test?
        path = related_paths.current_file_relative_to_repo
        path.ascend { |p| break p if p.basename.to_s == "test" } &&
          path.basename.to_s =~ /^#{test_file_prefix}.*#{test_ext}$/
      end

      def run_test_command
        "nosetests --with-doctest --nocapture #{test_file}"
      end

      private

      def source_dir
        related_paths.current_file_relative_to_repo.sub(%r{/?test(?=/)}, "").dirname
      end

      def test_dir
        current_file = related_paths.current_file_relative_to_repo
        if current_file.dirname.to_s == "."
          current_file.dirname.sub(/^/, "test/")
        else
          Pathname.new(current_file.to_s.sub(/^(.+?\/)/, "\\1/test/")).dirname
        end
      end

      def test_files
        Dir.glob(File.join(related_paths.repo_root, "**", "#{test_file_prefix}*#{test_file_suffix}#{test_ext}"))
      end

      def source_files
        Dir.glob(File.join(related_paths.repo_root, "**", "*#{source_ext}")) - test_files
      end
    end

  end
end
