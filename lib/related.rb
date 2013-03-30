require 'pathname'

$: << File.dirname(__FILE__)

require 'related/related_paths'
require 'related/frameworks'

module Related
  extend self

  def open_related_file
    framework.open_related_file
  end

  def run_test
    framework.run_test
  end

  private

  def framework
    Frameworks.detect(related_paths)
  end

  def related_paths
    @related_paths ||= RelatedPaths.new
  end
end


