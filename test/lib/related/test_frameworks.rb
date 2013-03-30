require 'test_helper'
require 'related/frameworks'

class TestFrameworks < RelatedTestCase
  class FakeFile
    def exists!(filename)
      @existing_filename = filename.to_s
    end

    def exists?(filename)
      defined?(@existing_filename) && @existing_filename == filename.to_s
    end
  end

  unless defined? ::VIM
    module ::VIM; end
  end

  def frameworks
    @subject ||= Related::Frameworks
  end

  def fake_file
    @fake_file ||= FakeFile.new
  end

  test ".detect detects RSpec" do
    fake_file.exists!("/path_to_repo/spec/")
    assert_equal Related::Frameworks::Rspec, frameworks.detect(fake_related_paths, fake_file).class
  end

  test ".detect detects Test::Unit" do
    fake_file.exists!("/path_to_repo/test/")
    assert_equal Related::Frameworks::TestUnit, frameworks.detect(fake_related_paths, fake_file).class
  end

  test ".detect falls back to Noop" do
    assert_equal Related::Frameworks::Noop, frameworks.detect(fake_related_paths, fake_file).class
  end
end

