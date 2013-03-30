module Related
  module Frameworks

    class Base
      attr_accessor :vim, :related

      def initialize(vim = VIM, related = Related)
        @vim, @related = vim, related
      end
    end

  end
end

