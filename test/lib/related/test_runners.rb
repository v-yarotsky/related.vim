require 'test_helper'
require 'related/runners'

class TestFrameworks < RelatedTestCase
  test ".detect detects ForegroundRunner" do
    fake_vim.evaluate("g:related_pipe", :to => "")
    assert_instance_of Related::Runners::ForegroundRunner, Related::Runners.detect(fake_vim)
  end

  test ".detect detects PipeRunner" do
    fake_vim.evaluate("g:related_pipe", :to => "thy_pipe")
    assert_instance_of Related::Runners::PipeRunner, Related::Runners.detect(fake_vim)
  end
end


