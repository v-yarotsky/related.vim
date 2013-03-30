require 'related/base'

module Related

  class Noop < Base
    def source_for_test
      vim.message("Don't know how to find source for test")
    end

    def test_for_source
      vim.message("Don't know how to find test for source")
    end

    def is_test?
      vim.message("Don't know whether it's test or source")
    end

    def run_test(*)
      vim.message("Don't know how to run related test")
    end
  end

end
