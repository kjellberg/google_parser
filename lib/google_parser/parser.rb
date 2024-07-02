require "nokogiri"
require "uri"

module GoogleParser
  class Parser
    attr_reader :organic_results, :raw_html

    def initialize(html)
      @doc = Nokogiri::HTML(html)
      @jsmodel = extract_jsmodel
      @selectors = Selectors.for(@jsmodel)
      parse_results
    rescue Nokogiri::SyntaxError => e
      raise "HTML parsing error: #{e.message}"
    rescue StandardError => e
      raise "Could not parse HTML: #{e.message}"
    end

    private
      def parse_results
        @organic_results = parse_organic_results
      end

      def parse_organic_results
        result_elements = @doc.css(@selectors.dig(:organic_results, :container))
        result_elements.map.with_index(1) do |result_element, index|
          url = parse_google_url(result_element.css(@selectors.dig(:organic_results, :url)))
          domain = extract_domain(url)
          root_domain = domain.gsub('www.', '')

          OrganicResult.new(
            position: index,
            title: result_element.css(@selectors.dig(:organic_results, :title)).text&.strip,
            description: result_element.css(@selectors.dig(:organic_results, :description)).text&.strip,
            breadcrumbs: result_element.css(@selectors.dig(:organic_results, :breadcrumbs)).text&.strip,
            url: url,
            domain: domain,
            root_domain: root_domain
          )
        end
      end

      def extract_jsmodel
        body_jsmodel = @doc.css('body').attr('jsmodel')&.value&.strip
        raise "No jsmodel found in the body tag" unless body_jsmodel

        body_jsmodel.split(' ')
      end

      def extract_domain(url)
        URI.parse(url).host
      rescue URI::InvalidURIError => e
        raise "Invalid URL: #{e.message}"
      end

      def parse_google_url(full_google_uri)
        href = full_google_uri.attr('href').value
        if href.start_with?('/url?q=')
          href.match(%r{/url\?q=(.*?)&})[1]
        else
          href
        end
      rescue NoMethodError => e
        raise "Error parsing Google URL: #{e.message}"
      end
  end
end
