require 'pathname'

$: << File.dirname(__FILE__)

require 'related/related_paths'
require 'related/frameworks'
require 'related/runners'

module Related
  extend self

  version_file = File.expand_path('../VERSION', File.dirname(__FILE__))
  VERSION = File.read(version_file).chomp.freeze

  # Relying on cache-absence here
  # If user creates a file with different name in #ensure_file!
  # the repo is scanned again and the custom file is likely found
  #
  def open_related_file
    ensure_file!(framework.related_file)
    VIM.command "silent :e #{framework.related_file}"
  rescue RelatedError => e
    VIM.message e.message
  end

  def run_test
    ensure_file!(framework.test_file)
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
    @framework ||= Frameworks.detect(related_paths)
  end

  def related_paths
    @related_paths ||= RelatedPaths.new
  end

  # TODO move and test
  def ensure_file!(file)
    return if File.exists?(file)
    if VIM.evaluate(%{confirm("Create #{file}?", "&Yes\n&No", 1)}) == 1
      file_to_create = VIM.evaluate(%{input("File to create: ", "#{file}")})
      Pathname.new(file_to_create).dirname.mkpath
      File.open(file_to_create, "w") {}
    else
      raise RelatedError, "File #{file} does not exist"
    end
  end

  def runner
    Runners.detect
  end
end


