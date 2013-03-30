require 'pathname'

$: << File.dirname(__FILE__)

require 'related/frameworks'

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
    related_file = framework.is_test? ? framework.source_for_test : framework.test_for_source
    VIM.command "silent :e #{related_file}"
  end

  def run_test
    test_file = framework.is_test? ? current_file_relative_to_repo : framework.test_for_source
    framework.run_test(test_file)
  end

  def framework
    Frameworks.detect(self)
  end

end


