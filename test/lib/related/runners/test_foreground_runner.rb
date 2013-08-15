require 'test_helper'
require 'related/runners/foreground_runner'

class TestForegroundRunner < RelatedTestCase
  def runner
    @subject ||= Related::Runners::ForegroundRunner.new(fake_vim)
  end

  def test_runs_test_in_foreground
    runner.run("ohai")
    assert_equal [":!ohai"], fake_vim.commands
  end
end


