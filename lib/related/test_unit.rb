require 'related/base'

module Related

  class TestUnit < Base
    def source_for_test
      source_dir = related.current_file_relative_to_repo.sub(%r{^test/}, "").dirname
      source_file = related.current_file_relative_to_repo.basename.sub(/^test_/, "")
      File.join(related.repo_root, source_dir, source_file)
    end

    def test_for_source
      test_dir = related.current_file_relative_to_repo.sub(/^/, "test/").dirname
      test_file = related.current_file_relative_to_repo.basename.sub(/^/, "test_")
      File.join(related.repo_root, test_dir, test_file)
    end

    def is_test?
      related.current_file_relative_to_repo.to_s =~ /^test\//
    end

    def run_test(test_file)
      vim.command ":!clear && cd #{related.repo_root} && ruby -Itest #{test_file}"
    end
  end

end
