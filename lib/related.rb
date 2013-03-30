require 'pathname'

$: << File.dirname(__FILE__)

require 'related/noop'
require 'related/rspec'
require 'related/test_unit'

module Related
  extend self

  def repo_root
    Pathname.new(`cd #{current_file.dirname} && git rev-parse --show-toplevel`.chomp)
  end

  def current_file
    Pathname.new(VIM.evaluate("expand('%:p')"))
  end

  def current_file_relative_to_repo
    current_file.relative_path_from(repo_root)
  end

  def open_related_file
    related_file = finder.is_test? ? finder.source_for_test : finder.test_for_source
    VIM.command "silent :e #{related_file}"
  end

  def run_test
    test_file = finder.is_test? ? current_file_relative_to_repo : finder.test_for_source
    finder.run_test(test_file)
  end

  #TODO: support for minitest/spec
  def finder
    finder_class = if File.exists?(File.join(repo_root, "spec/"))
      Rspec
    elsif File.exists?(File.join(repo_root, "test/"))
      TestUnit
    else
      Noop
    end
    finder_class.new
  end
end


