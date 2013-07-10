require 'test_helper'
require 'related/existence_checker'

class TestExistenceChecker < RelatedTestCase
  test ".exists? performs a glob if * is present in filename" do
    called = false
    stub_method_on(Dir, :glob, proc { |fn| called = true; [] }) do
      Related::ExistenceChecker.exists?("foo/*/bar")
    end
    assert called, "must have made a glob"
  end

  test ".exists? checks if file exists if there is no * in filename" do
    called = false
    stub_method_on(File, :exists?, proc { |fn| called = true }) do
      Related::ExistenceChecker.exists?("foo/bar")
    end
    assert called, "must have checked file existence"
  end

  def stub_method_on(obj, name, stub_implementation, &block)
    old_method = obj.method(name)
    (class << obj; self; end).send(:define_method, name, &stub_implementation)
    yield
  ensure
    (class << obj; self; end).send(:define_method, name, &old_method)
  end
end


