require 'test_helper'
require 'related/matcher'

include Related

class TestMatcher < RelatedTestCase
  test "weighted matching" do
    test_unit_matcher = Matcher.new

    conventional_match = "/repo_root_path/test/app/models/test_user.rb"

    available_tests = [
      "/repo_root_path/test/isolated/models/test_something.rb",
      "/repo_root_path/test/integration/models/test_user.rb",
      "/repo_root_path/test/lib/test_user.rb"
    ]

    expected_weights = [
      Matcher::WeightedMatch.new("/repo_root_path/test/isolated/models/test_something.rb", 0),
      Matcher::WeightedMatch.new("/repo_root_path/test/integration/models/test_user.rb", 2),
      Matcher::WeightedMatch.new("/repo_root_path/test/lib/test_user.rb", 1),
    ]

    assert_equal expected_weights, test_unit_matcher.weighted_matches(conventional_match, available_tests)
  end

  test "weighted matching with source" do
    test_unit_matcher = Matcher.new

    conventional_match = "/repo_root_path/integration/models/user.rb"

    available_tests = [
      "/repo_root_path/lib/user.rb",
      "/repo_root_path/app/models/user.rb",
      "/repo_root_path/models/other.rb"
    ]

    expected_weights = [
      Matcher::WeightedMatch.new("/repo_root_path/lib/user.rb", 1),
      Matcher::WeightedMatch.new("/repo_root_path/app/models/user.rb", 2),
      Matcher::WeightedMatch.new("/repo_root_path/models/other.rb", 0),
    ]

    assert_equal expected_weights, test_unit_matcher.weighted_matches(conventional_match, available_tests)
  end

  test "#best_match" do
    test_unit_matcher = Matcher.new

    conventional_match = "/repo_root_path/integration/models/user.rb"

    available_tests = [
      "/repo_root_path/lib/user.rb",
      "/repo_root_path/app/models/user.rb",
      "/repo_root_path/models/other.rb"
    ]

    assert_equal "/repo_root_path/app/models/user.rb", test_unit_matcher.best_match(conventional_match, available_tests)
  end

  test "#best_match doesn't return 0-weight match" do
    test_unit_matcher = Matcher.new

    conventional_match = "/repo_root_path/integration/models/user.rb"

    available_tests = [
      "/repo_root_path/models/other.rb"
    ]

    assert_equal nil, test_unit_matcher.best_match(conventional_match, available_tests)
  end
end

