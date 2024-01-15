# frozen_string_literal: true

require_relative "google_parser/version"

require "nokogiri"

module GoogleParser
  class InvalidJsModelError < StandardError; end

  class GoogleParser
    attr_reader :raw_html, :doc, :organic_results, :jsmodel

    def initialize(raw_html)
      @raw_html = raw_html
      @doc = Nokogiri::HTML(raw_html)
      @organic_results = []
      @jsmodel = @doc.css("body").attr("jsmodel").value&.strip!

      parse_organic_results
    rescue StandardError => e
      raise "Could not parse HTML"
    end

    def selectors
      @selectors ||= {
        "hspDDf" => {
          organic_results: {
            container: "div.Gx5Zad.fP1Qef.xpd.EtOod.pkphOe",
            title: "h3 > div",
            description: "div.BNeawe.s3v9rd.AP7Wnd",
            breadcrumbs: "div.BNeawe.UPmit.AP7Wnd.lRVwie",
            url: "a[href]",
          }
        }
      }[@jsmodel] || raise("Could not find selectors for jsmodel: \"#{@jsmodel}\"")
    end

    private
      def parse_organic_results
        result_elements = @doc.css(selectors.dig(:organic_results, :container))
        @organic_results = result_elements.map do |result_element|
          url = parse_google_url(result_element.css(selectors.dig(:organic_results, :url)))
          domain = extract_domain(url)
          root_domain = domain.gsub("www.", "")
          {
            position: result_elements.index(result_element) + 1,
            title: result_element.css(selectors.dig(:organic_results, :title)).text&.strip,
            description: result_element.css(selectors.dig(:organic_results, :description)).text&.strip,
            breadcrumbs: result_element.css(selectors.dig(:organic_results, :breadcrumbs)).text&.strip,
            url: url,
            domain: domain,
            root_domain: root_domain
          }
        end
      end

      def extract_domain(url)
        URI.parse(url).host
      end

      def parse_google_url(full_google_uri)
        href = full_google_uri.attr("href").value
        if href.start_with?("/url?q=")
          href.match(/\/url\?q=(.*?)&/)[1]
        else
          href
        end
      end
  end
  # Your code goes here...
end
