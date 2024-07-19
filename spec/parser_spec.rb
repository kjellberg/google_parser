# frozen_string_literal: true

require "spec_helper"

RSpec.describe GoogleParser::Parser do
  let(:html) { File.read("spec/fixtures/google_response_hspDDf.html") }
  let(:parser) { described_class.new(html) }

  describe "#initialize" do
    it "initializes without errors" do
      expect { parser }.not_to raise_error
    end
  end

  describe "#organic_results" do
    it "extracts organic results" do
      expect(parser.organic_results).not_to be_empty
    end

    it "returns an array of Result objects" do
      expect(parser.organic_results).to all(be_a(GoogleParser::Elements::OrganicResult))
    end

    it "correctly extracts data from organic results" do
      result = parser.organic_results.first
      expect(result.title).not_to be_nil
      expect(result.description).not_to be_nil
      expect(result.url).not_to be_nil
      expect(result.domain).not_to be_nil
      expect(result.root_domain).not_to be_nil
    end
  end
end
