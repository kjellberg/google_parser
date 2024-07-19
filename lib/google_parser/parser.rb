# frozen_string_literal: true

require "nokogiri"
require "uri"

module GoogleParser
  class Parser
    attr_reader :raw_html

    VARIANTS_MAP = {
      organic_results: {
        "div.Gx5Zad.fP1Qef.xpd.EtOod.pkphOe": "GoogleParser::Elements::OrganicResults::Base"
      }
    }

    def initialize(html)
      @raw_html = html
      @doc = Nokogiri::HTML(html)
    end

    def organic_results
      @organic_results ||= extract_elements(:organic_results)
    end

    private
      def extract_elements(element_type)
        VARIANTS_MAP[element_type].flat_map do |selector, class_name|
          @doc.css(selector)&.flat_map do |element|
            Object.const_get(class_name).new(element)
          end
        end
      end
  end
end
