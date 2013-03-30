require 'test_helper'
require 'related/frameworks/base'

class TestBase < RelatedTestCase
  class DumbFramework < Related::Frameworks::Base
    def is_test!
      @is_test = true
    end

    def is_source!
      @is_test = false
    end

    def source_for_test
      "source"
    end

    def test_for_source
      "test"
    end

    def is_test?
      !!@is_test
    end
  end

  def framework
    @subject ||= DumbFramework.new(fake_related_paths, fake_vim)
  end

  test "#open_related_file opens related test if current file is source" do
    framework.is_source!
    framework.open_related_file
    assert_equal ["silent :e test"], fake_vim.commands
  end

  test "#open_related_file opens related source if current file is test" do
    framework.is_test!
    framework.open_related_file
    assert_equal ["silent :e source"], fake_vim.commands
  end

  test "#test_file returns current file if current file is test" do
    fake_related_paths.current_file_relative_to_repo = "test_file"
    framework.is_test!
    assert_equal "test_file", framework.test_file
  end

  test "#test_file returns related test file if current file is source" do
    framework.is_source!
    assert_equal "test", framework.test_file
  end
end

