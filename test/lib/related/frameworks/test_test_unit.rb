require 'test_helper'
require 'related/frameworks/test_unit'

class TestTestUnit < RelatedTestCase
  def t_u
    @subject ||= Related::Frameworks::TestUnit.new(fake_related, fake_vim)
  end

  test "#source_for_test returns source for test" do
    fake_related.current_file_relative_to_repo = pathname("test/lib/related/test_test_unit.rb")
    assert_equal "/path_to_repo/lib/related/test_unit.rb", t_u.source_for_test
  end

  test "#test_for_source returns test for source" do
    fake_related.current_file_relative_to_repo = pathname("lib/related/test_unit.rb")
    assert_equal "/path_to_repo/test/lib/related/test_test_unit.rb", t_u.test_for_source
  end

  test "#is_test?" do
    fake_related.current_file_relative_to_repo = pathname("test/lib/related/test_test_unit.rb")
    assert t_u.is_test?, "test/lib/related/test_test_unit.rb must be recognized as test"

    fake_related.current_file_relative_to_repo = pathname("lib/related/test_unit.rb")
    assert !t_u.is_test?, "lib/related/test_unit.rb must not be recognized as test"
  end

  test "#run_test runs test file" do
    def t_u.test_file; "my_test_file.rb"; end
    t_u.run_test
    assert_equal [":!clear && cd /path_to_repo/ && ruby -Itest my_test_file.rb"], fake_vim.commands
  end
end

