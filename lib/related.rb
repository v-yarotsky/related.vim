require 'pathname'

$: << File.dirname(__FILE__)

require 'related/related_paths'
require 'related/frameworks'

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
    pipe = VIM.evaluate("exists('g:related_pipe')") == 0 ? "" : VIM.evaluate("g:related_pipe")
    command = "clear && cd #{related_paths.repo_root} && #{framework.run_test_command}"
    if pipe.empty?
      VIM.command ":!#{command}"
    else
      VIM.command ":!echo '#{command}' > #{pipe}"
    end
  rescue RelatedError => e
    VIM.message e.message
  end

  private

  def framework
    Frameworks.detect(related_paths)
  end

  def related_paths
    @related_paths ||= RelatedPaths.new
  end
end


