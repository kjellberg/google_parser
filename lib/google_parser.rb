# frozen_string_literal: true

require_relative "google_parser/version"
require_relative "selectors"

require "nokogiri"

module GoogleParser
  autoload :Parser, "google_parser/parser"

  module Elements
    autoload :AdResult, "google_parser/elements/ad_result"
    autoload :OrganicResult, "google_parser/elements/organic_result"
  end
end
