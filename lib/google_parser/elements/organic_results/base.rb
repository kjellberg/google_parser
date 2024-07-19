# frozen_string_literal: true

module GoogleParser
  module Elements
    module OrganicResults
      class Base
        attr_reader :element

        SELECTORS = {
          title: "h3",
          description: "div.v9i61e",
          url: "a"
        }

        def initialize(element)
          @element = element
        end

        def title
          value_or_nil extract_text_from_selector(:title)
        end

        def description
          value_or_nil extract_text_from_selector(:description)
        end

        def url
          href = extract_href_value_from_selector(:url)

          if href.start_with?("/url?q=")
            href.match(%r{/url\?q=(.*?)&})[1]
          else
            href
          end
        end

        def domain
          URI.parse(url).host
        end

        def root_domain
          domain.gsub("www.", "")
        end

        private
          def extract_href_value_from_selector(selector)
            @element.css(SELECTORS[selector]).attr("href").value
          end

          def extract_text_from_selector(selector)
            @element.css(SELECTORS[selector]).text
          end

          def value_or_nil(value)
            value.empty? ? nil : value
          end

        # def parse_google_url(href)
        #   if href.start_with?("/url?q=")
        #     href.match(%r{/url\?q=(.*?)&})[1]
        #   else
        #     href
        #   end
        # rescue NoMethodError => e
        #   raise "Error parsing Google URL: #{e.message}"
        # end
      end
    end
  end
end
