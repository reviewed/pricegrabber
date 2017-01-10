require 'spec_helper'

describe PriceGrabber::Response do
  let(:valid_xml) do
    <<-XML
    <?xml version"1.0"?>
    <ProductResponse>
      <Offers>
        <PriceSet>
          <minPrice>$0.00</minPrice>
          <maxPrice>$999.00</maxPrice>
        </PriceSet>
        <Offer>
          <title>Super Soaker</title>
          <price>$27.18</price>
          <merchantName>Amazon</merchantName>
        </Offer>
      </Offers>
    </ProductResponse>
    XML
  end

  let(:no_offers) do
    <<-XML
    <?xml version="1.0"?>
    <ProductResponse>
      <Offers>
      </Offers>
    </ProductResponse>
    XML
  end

  context 'with valid response JSON' do
    before do
      http_resp = HTTPI::Response.new(200, {}, valid_xml)
      @response = described_class.new(http_resp, ["merchantName", "price"])
    end

    it 'reports that it is a successful response' do
      expect(@response.successful?).to eq(true)
    end

    it 'makes response items available as underscorized methods' do
      @response.each do |item|
        expect(item.price).to eq("$27.18")
        expect(item.merchantname).to eq("Amazon")
      end
    end
  end

  context 'with error JSON and 400 response code' do
    it 'reports that the request was unsuccessful' do
      http_resp = HTTPI::Response.new(400, {}, '')
      response = described_class.new(http_resp, ["merchantName", "price"])
      expect(response.successful?).to eq(false)
    end
  end

  context 'with no offers for a product' do
    it 'iterates zero times' do
      http_resp = HTTPI::Response.new(200, {}, no_offers)
      response = described_class.new(http_resp, ["merchantName", "price"])
      expect(response.count).to eq(0)
    end
  end
end
