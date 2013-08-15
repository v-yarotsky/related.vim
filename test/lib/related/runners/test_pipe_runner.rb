require 'test_helper'
require 'related/runners/pipe_runner'

class TestPipeRunner < RelatedTestCase
  def runner
    @subject ||= Related::Runners::PipeRunner.new("thy_pipe", fake_vim)
  end

  def test_outputs_test_run_command_to_pipe
    runner.run("ohai")
    assert_equal [":silent !echo 'ohai' > thy_pipe", ":redraw!"], fake_vim.commands
  end
end

