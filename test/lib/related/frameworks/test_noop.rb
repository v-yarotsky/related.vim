require 'test_helper'
require 'related/frameworks/noop'

class TestNoop < RelatedTestCase
  def noop
    @subject ||= Related::Frameworks::Noop.new(nil, fake_vim)
  end

  test "#source_for_test prints message" do
    noop.source_for_test
    assert_equal ["Don't know how to find source for test"], fake_vim.messages
  end

  test "#test_for_source prints message" do
    noop.test_for_source
    assert_equal ["Don't know how to find test for source"], fake_vim.messages
  end

  test "#is_test?" do
    noop.is_test?
    assert_equal ["Don't know whether it's test or source"], fake_vim.messages
  end

  test "#run_test prints message" do
    noop.run_test
    assert_equal ["Don't know how to run related test"], fake_vim.messages
  end
end

