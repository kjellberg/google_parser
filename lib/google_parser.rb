# frozen_string_literal: true

require_relative "google_parser/version"

require "nokogiri"

module GoogleParser
  autoload :Parser, "google_parser/parser"

  module Elements
    module OrganicResults
      autoload :Base, "google_parser/elements/organic_results/base"
    end
  end
end
