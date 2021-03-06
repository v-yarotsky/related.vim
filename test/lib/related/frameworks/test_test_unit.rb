require 'test_helper'
require 'related/frameworks/test_unit'

class TestTestUnit < RelatedTestCase
  def t_u
    @subject ||= Related::Frameworks::TestUnit.new(fake_related_paths)
  end

  test "#source_for_test returns source for test" do
    fake_related_paths.current_file_relative_to_repo = pathname("test/lib/related/test_test_unit.rb")
    assert_equal "/path_to_repo/lib/related/test_unit.rb", t_u.source_for_test
  end

  test "#test_for_source returns test for source" do
    fake_related_paths.current_file_relative_to_repo = pathname("lib/related/test_unit.rb")
    assert_equal "/path_to_repo/test/lib/related/test_test_unit.rb", t_u.test_for_source
  end

  test "#is_test?" do
    fake_related_paths.current_file_relative_to_repo = pathname("test/lib/related/test_test_unit.rb")
    assert t_u.is_test?, "test/lib/related/test_test_unit.rb must be recognized as test"

    fake_related_paths.current_file_relative_to_repo = pathname("lib/related/test_unit.rb")
    assert !t_u.is_test?, "lib/related/test_unit.rb must not be recognized as test"
  end

  test "#run_test_command returns a command to runs test file" do
    def t_u.test_file; "my_test_file.rb"; end
    assert_equal "ruby -Itest my_test_file.rb", t_u.run_test_command
  end
end

