require 'test_helper'
require 'related/frameworks/nose'

# Possible directory structures
# =============================
#
# One-file project
# ----------------
#
#     /my_project.py
#     /test/test_my_project.py
#
# Multiple-file project
# ---------------------
#
#     /my_project/foo.py
#     /my_project/bar/bar.py
#     /my_project/test/test_foo.py
#     /my_project/test/bar/test_bar.py
#
class TestNose < RelatedTestCase
  def nose
    @subject ||= Related::Frameworks::Nose.new(fake_related_paths)
  end

  SOURCES_TO_TESTS = {
    "my_project.py"         => "test/test_my_project.py",
    "my_project/foo.py"     => "my_project/test/test_foo.py",
    "my_project/bar/bar.py" => "my_project/test/bar/test_bar.py"
  }.freeze

  SOURCES_TO_TESTS.each do |source_file, test_file|
    test "#source_for_test returns #{source_file} for #{test_file}" do
      fake_related_paths.current_file_relative_to_repo = pathname(test_file)
      assert_equal fake_related_paths.repo_root.join(source_file).to_s, nose.source_for_test
    end
  end

  SOURCES_TO_TESTS.each do |source_file, test_file|
    test "#test_for_source returns #{test_file} for #{source_file}" do
      fake_related_paths.current_file_relative_to_repo = pathname(source_file)
      assert_equal fake_related_paths.repo_root.join(test_file).to_s, nose.test_for_source
    end
  end

  SOURCES_TO_TESTS.values.each do |test_file|
    test "#{test_file} #is_test?" do
      fake_related_paths.current_file_relative_to_repo = pathname(test_file)
      assert nose.is_test?, "#{test_file} must be recognized as test"
    end
  end

  SOURCES_TO_TESTS.keys.each do |source_file|
    test "#{source_file} not #is_test?" do
      fake_related_paths.current_file_relative_to_repo = pathname(source_file)
      assert !nose.is_test?, "#{source_file} must not be recognized as test"
    end
  end

  xtest "#run_test_command returns a command to run test file" do
    def rspec.test_file; "my_test_file.rb"; end
    assert_equal "rspec my_test_file.rb", rspec.run_test_command
  end
end


