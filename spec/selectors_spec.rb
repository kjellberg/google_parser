# frozen_string_literal: true

require "spec_helper"

RSpec.describe GoogleParser::Selectors do
  describe ".for" do
    it "returns the correct selectors for a known jsmodel" do
      selectors = described_class.for("hspDDf")
      expect(selectors).to have_key(:organic_results)
    end

    it "raises an error for an unknown jsmodel" do
      expect { described_class.for("unknownJsModel") }.to raise_error(GoogleParser::InvalidJsModelError)
    end
  end
end
