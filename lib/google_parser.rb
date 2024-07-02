# frozen_string_literal: true

require_relative "google_parser/version"
require_relative "selectors"

require "nokogiri"

module GoogleParser
  autoload :Parser, "google_parser/parser"
  autoload :AdResult, "google_parser/ad_result"
  autoload :OrganicResult, "google_parser/organic_result"
end
