require 'pathname'

$: << File.dirname(__FILE__)

require 'related/related_paths'
require 'related/frameworks'
require 'related/runners'

module Related
  extend self

  version_file = File.expand_path('../VERSION', File.dirname(__FILE__))
  VERSION = File.read(version_file).chomp.freeze

  def open_related_file
    VIM.command "silent :e #{framework.related_file}"
  rescue RelatedError => e
    VIM.message e.message
  end

  def run_test
    @command = "clear && cd #{related_paths.repo_root} && #{framework.run_test_command}"
    runner.run(@command)
  rescue RelatedError => e
    VIM.message e.message
  end

  def run_latest_test
    @command ? runner.run(@command) : VIM.message("No previous test runs")
  end

  private

  def framework
    Frameworks.detect(related_paths)
  end

  def related_paths
    @related_paths ||= RelatedPaths.new
  end

  def runner
    Runners.detect
  end
end


