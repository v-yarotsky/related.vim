require 'related/frameworks/base'

module Related
  module Frameworks

    class Rspec < Base
      def source_for_test
        source_dir = related.current_file_relative_to_repo.sub(%r{^spec/}, "").dirname
        unless File.exists?(source_dir)
          source_dir = related.current_file_relative_to_repo.sub(%r{^spec/}, "app/").dirname
        end
        source_file = related.current_file_relative_to_repo.basename.sub(/_spec.rb$/, ".rb")
        File.join(related.repo_root, source_dir, source_file)
      end

      def test_for_source
        test_dir = related.current_file_relative_to_repo.sub(/^(app\/)?/, "spec/").dirname
        test_file = related.current_file_relative_to_repo.basename.sub(/\.rb$/, "_spec.rb")
        File.join(related.repo_root, test_dir, test_file)
      end

      def is_test?
        related.current_file_relative_to_repo.basename.to_s =~ %r{_spec\.rb$}
      end

      def run_test(test_file)
        vim.command ":!clear && cd #{related.repo_root} && rspec #{test_file}"
      end
    end

  end
end