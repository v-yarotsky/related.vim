module Related
  module Runners

    class PipeRunner
      def initialize(pipe, vim = VIM)
        @pipe, @vim = pipe, vim
      end

      def run(command)
        @vim.command(":silent !echo '#{command}' > #@pipe")
        @vim.command(":redraw!")
      end
    end

  end
end

