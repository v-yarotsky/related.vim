module Related

  module Runners
    def self.detect(vim = VIM)
      pipe = vim.evaluate("g:related_pipe")
      pipe.empty? ? ForegroundRunner.new(vim) : PipeRunner.new(pipe, vim)
    end
  end

end

require 'related/runners/foreground_runner'
require 'related/runners/pipe_runner'

