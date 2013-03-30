require 'pathname'

module Related

  class RelatedPaths
    attr_accessor :vim

    def initialize(vim = VIM)
      @vim = vim
    end

    def repo_root
      Pathname.new(`cd #{current_file.dirname} && git rev-parse --show-toplevel`.chomp)
    end

    def current_file
      Pathname.new(vim.evaluate("expand('%:p')"))
    end

    def current_file_relative_to_repo
      current_file.relative_path_from(repo_root)
    end
  end

end

