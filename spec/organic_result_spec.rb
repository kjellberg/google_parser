require 'spec_helper'

RSpec.describe GoogleParser::OrganicResult do
  let(:organic_result) {
    described_class.new(
      position: 1,
      title: 'Example Title',
      description: 'Example Description',
      breadcrumbs: 'example.com > subpage',
      url: 'https://example.com',
      domain: 'example.com',
      root_domain: 'example.com'
    )
  }

  describe '#initialize' do
    it 'assigns attributes correctly' do
      expect(organic_result.position).to eq(1)
      expect(organic_result.title).to eq('Example Title')
      expect(organic_result.description).to eq('Example Description')
      expect(organic_result.breadcrumbs).to eq('example.com > subpage')
      expect(organic_result.url).to eq('https://example.com')
      expect(organic_result.domain).to eq('example.com')
      expect(organic_result.root_domain).to eq('example.com')
    end
  end
end
