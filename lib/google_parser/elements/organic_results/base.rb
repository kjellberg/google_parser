# frozen_string_literal: true

module GoogleParser
  module Elements
    module OrganicResults
      class Base
        attr_reader :element

        def initialize(element)
          @element = element
        end
      end
    end
  end
end
