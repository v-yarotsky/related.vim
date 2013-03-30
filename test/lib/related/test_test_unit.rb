require 'test_helper'
require 'related/test_unit'

class TestTestUnit < RelatedTestCase
  def t_u
    @subject ||= Related::TestUnit.new(fake_vim, fake_related)
  end

  def setup
    fake_related.repo_root = pathname("/path_to_repo/")
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
    t_u.run_test("my_test_file.rb")
    assert_equal [":!clear && cd /path_to_repo/ && ruby -Itest my_test_file.rb"], fake_vim.commands
  end
end

