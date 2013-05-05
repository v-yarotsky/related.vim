require 'test_helper'
require 'related/frameworks/noop'

class TestNoop < RelatedTestCase
  def noop
    @subject ||= Related::Frameworks::Noop.new(nil)
  end

  test "#source_for_test prints message" do
    assert_raises Related::RelatedError, "Don't know how to find source for test" do
      noop.source_for_test
    end
  end

  test "#test_for_source prints message" do
    assert_raises Related::RelatedError, "Don't know how to find test for source" do
      noop.test_for_source
    end
  end

  test "#is_test?" do
    assert_raises Related::RelatedError, "Don't know whether it's test or source" do
      noop.is_test?
    end
  end

  test "#run_test_command prints message" do
    assert_raises Related::RelatedError, "Don't know how to run related test" do
      noop.run_test_command
    end
  end
end

