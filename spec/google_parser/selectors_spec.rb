# frozen_string_literal: true

require "spec_helper"

RSpec.describe GoogleParser::Selectors do
  let(:html) { File.read("spec/fixtures/google_response_hspDDf.html") }
  let(:doc) { Nokogiri::HTML(html) }

  describe ".find" do
    it "returns the correct selectors if matching" do
      selectors = described_class.new(doc).find(:organic_results)
      expect(selectors[:container]).to eq("div.Gx5Zad.fP1Qef.xpd.EtOod.pkphOe")
    end
  end
end
