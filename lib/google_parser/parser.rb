# frozen_string_literal: true

require "nokogiri"
require "uri"

module GoogleParser
  class Parser
    attr_reader :raw_html

    def initialize(html)
      @raw_html = html
      @doc = Nokogiri::HTML(html)
    end

    def organic_results
      @organic_results ||= begin
        selector = GoogleParser::Selectors.new(@doc).find(:organic_results)
        results = @doc.css(selector.dig(:container))
        results.map do |element, index|
          GoogleParser::Elements::OrganicResults::Base.new(
            title: "Result title",
            description: "Lorem ipsum dolor sit amet",
            breadcrumbs: "Foo > Bar > Zoo",
            url: "https://google.com"
          )
        end
      end
    end
  end
end
