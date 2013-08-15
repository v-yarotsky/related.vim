module Related
  module Runners

    class ForegroundRunner
      def initialize(vim = VIM)
        @vim = vim
      end

      def run(command)
        @vim.command(":!" + command)
      end
    end

  end
end

