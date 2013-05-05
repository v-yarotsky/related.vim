require 'related/frameworks/base'

module Related
  module Frameworks

    class Noop < Base
      def source_for_test
        raise RelatedError, "Don't know how to find source for test"
      end

      def test_for_source
        raise RelatedError, "Don't know how to find test for source"
      end

      def is_test?
        raise RelatedError, "Don't know whether it's test or source"
      end

      def run_test_command
        raise RelatedError, "Don't know how to run related test"
      end
    end

  end
end
