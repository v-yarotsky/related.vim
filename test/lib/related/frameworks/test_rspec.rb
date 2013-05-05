require 'test_helper'
require 'related/frameworks/rspec'

class TestRspec < RelatedTestCase
  def rspec
    @subject ||= Related::Frameworks::Rspec.new(fake_related_paths)
  end

  test "#source_for_test returns source for test" do
    fake_related_paths.current_file_relative_to_repo = pathname("spec/lib/related/rspec_spec.rb")
    assert_equal "/path_to_repo/lib/related/rspec.rb", rspec.source_for_test
  end

  test "#test_for_source returns test for source" do
    fake_related_paths.current_file_relative_to_repo = pathname("lib/related/rspec.rb")
    assert_equal "/path_to_repo/spec/lib/related/rspec_spec.rb", rspec.test_for_source
  end

  test "#is_test?" do
    fake_related_paths.current_file_relative_to_repo = pathname("spec/lib/related/rspec_spec.rb")
    assert rspec.is_test?, "spec/lib/related/rspec_spec.rb must be recognized as test"

    fake_related_paths.current_file_relative_to_repo = pathname("lib/related/rspec.rb")
    assert !rspec.is_test?, "lib/related/rspec.rb must not be recognized as test"
  end

  test "#run_test_command returns a command to run test file" do
    def rspec.test_file; "my_test_file.rb"; end
    assert_equal "rspec my_test_file.rb", rspec.run_test_command
  end
end

