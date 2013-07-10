require 'related/existence_checker'

module Related

  module Frameworks
    def self.detect(related_paths, existence_checker = ExistenceChecker)
      framework_class = if existence_checker.exists?(related_paths.repo_root.join("*/test/__init__.py"))
        Nose
      elsif existence_checker.exists?(related_paths.repo_root.join("spec/"))
        Rspec
      elsif existence_checker.exists?(related_paths.repo_root.join("test/"))
        TestUnit
      else
        Noop
      end
      framework_class.new(related_paths)
    end
  end

end

require 'related/frameworks/noop'
require 'related/frameworks/test_unit'
require 'related/frameworks/rspec'
require 'related/frameworks/nose'

