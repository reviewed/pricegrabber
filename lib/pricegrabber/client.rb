module PriceGrabber
  class Client
    def initialize(api_key:, publisher_id:, environment: :staging)
      @environment = environment
      @api_key = api_key
      @publisher_id = publisher_id
    end

    def find_by_id(asin: nil, upc: nil)
      Request.new(asin: asin, upc: upc,publisher_id: @publisher_id, key: @api_key, environment: @environment)
    end

    def search(query)
      Request.new(q: query, publisher_id: @publisher_id, key: @api_key, environment: @environment)
    end
  end
end
