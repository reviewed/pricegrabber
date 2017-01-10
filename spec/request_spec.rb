require 'spec_helper'

describe PriceGrabber::Request do
  describe 'url construction' do
    it 'produces the correct URL for a given ASIN' do
      req = described_class.new(key: '123456', publisher_id: '654321', asin: 'B007ARLMI0')
      expect(req.to_s).to eq('http://catalog.bizrate.com/services/catalog/v1/api/product?apiKey=123456&productIdType=MPID&merchantId=184056&productId=B007ARLMI0&publisherId=654321')
    end

    describe 'full text queries' do
      it 'constructs urls for full text queries' do
        req = described_class.new(key: '123456', publisher_id: '654321', q: 'wool sweater')
        expect(req.to_s).to eq('http://catalog.bizrate.com/services/catalog/v1/api/product?apiKey=123456&keyword=wool+sweater&publisherId=654321')
      end
    end

    it 'constructs queries for UPCs' do
      req = described_class.new(key: '123456', publisher_id: '654321', upc: '004815162342')
      expect(req.to_s).to eq('http://catalog.bizrate.com/services/catalog/v1/api/product?apiKey=123456&productIdType=UPC&productId=004815162342&publisherId=654321')
    end

    it 'provides to_curl for debugging purposes' do
      req = described_class.new(key: '123456', publisher_id: '654321', asin: 'B007ARLMI0')
      expect(req.to_curl).to eq('curl -G \'http://catalog.bizrate.com/services/catalog/v1/api/product?apiKey=123456&productIdType=MPID&merchantId=184056&productId=B007ARLMI0&publisherId=654321\'')
    end

    it 'switches between production and staging urls' do
      req = described_class.new(key: '123456', publisher_id: '654321', asin: 'B007ARLMI0', environment: :production)
      expect(req.to_s).to eq('http://catalog.bizrate.com/services/catalog/v1/api/product?apiKey=123456&productIdType=MPID&merchantId=184056&productId=B007ARLMI0&publisherId=654321')
    end
  end

  describe 'environment' do
    it 'reports what environment the request is for' do
      req = described_class.new(key: '123456', publisher_id: '654321', asin: 'B007ARLMI0', environment: :production)
      expect(req.environment).to eq(:production)
    end
  end

  describe 'query execution' do
    it 'returns an enumerable' do
      req = described_class.new(key: '123456', publisher_id: '654321', asin: 'B007ARLMI0', driver: :mock_driver)
      expect(req.call.class < Enumerable).to eq(true)
    end

    it "allows attribute plucking" do
      req = described_class.new(key: '123456', publisher_id: '654321', asin: 'B007ARLMI0', driver: :mock_driver).pluck(:"title", :"url")
      resp = req.call.first
      expect(resp.title).to eq("Vitamix Professional Series 750 Black with 64-Oz. Container")
      expect(resp.url).to eq("http://rd.bizrate.com/rd?t=http%3A%2F%2Fwww.amazon.com%2Fdp%2FB00LFVV8CM%2Fref%3Dasc_df_B00LFVV8CM4586991%3Fsmid%3DATVPDKIKX0DER%26tag%3Dshopzilla0d-20%26ascsubtag%3Dshopzilla_rev_128-20%3BSZ_REDIRECT_ID%26linkCode%3Ddf0%26creative%3D395093%26creativeASIN%3DB00LFVV8CM&mid=184056&cat_id=13050809&atom=10526&prod_id=&oid=6514681944&pos=1&b_id=18&bid_type=4&bamt=fd093910640770ad&cobrand=1&ppr=1bcdf7dc04befe13&af_sid=76&mpid=B00LFVV8CM&brandId=357327&rf=af1&af_assettype_id=10&af_creative_id=2912&af_id=614546&af_placement_id=1")
    end
  end
end
