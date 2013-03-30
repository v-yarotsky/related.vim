module Related

  module Frameworks
    def self.detect(related_paths)
      #TODO: support for minitest/spec
      framework_class = if File.exists?(File.join(related_paths.repo_root, "spec/"))
        Frameworks::Rspec
      elsif File.exists?(File.join(related_paths.repo_root, "test/"))
        Frameworks::TestUnit
      else
        Frameworks::Noop
      end
      framework_class.new
    end
  end

end

require 'related/frameworks/noop'
require 'related/frameworks/test_unit'
require 'related/frameworks/rspec'

