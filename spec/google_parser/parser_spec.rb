# frozen_string_literal: true

require "spec_helper"

RSpec.describe GoogleParser::Parser do
  let(:html) { File.read("spec/fixtures/google_query-matkasse.html") }
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
      expect(parser.organic_results).to all(be_a(GoogleParser::Elements::OrganicResults::Base))
    end

    it "correctly extracts data from organic results" do
      result = parser.organic_results.first
      expect(result.title).to eq("Linas Matkasse: Nyttiga, goda & hälsosamma matkassar")
      expect(result.description).to eq("Matglädje för hela familjen – med Linas Matkasse. ✓ Färska och lokala råvaror i säsong ✓ 80 sunda, goda recept i veckan ✓ Ingen bindningstid.")
      expect(result.url).to eq("https://www.linasmatkasse.se/")
      expect(result.domain).to eq("www.linasmatkasse.se")
      expect(result.root_domain).to eq("linasmatkasse.se")
    end
  end
end
