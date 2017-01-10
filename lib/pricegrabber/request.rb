require 'uri'
require 'httpi'

module PriceGrabber
  class Request
    attr_reader :environment

    def initialize(key:, publisher_id:, asin: nil, q: nil, upc: nil, environment: :staging, driver: :net_http)
      @environment = environment
      @publisher_id = publisher_id
      @key = key
      @asin = asin
      @q = q
      @upc = upc
      @driver = driver
      @wants = []
    end

    def to_uri
      uri = ::URI::HTTP.build({})
      uri.scheme = "http"
      if @environment == :production
        uri.host = "catalog.bizrate.com"
      else
        uri.host = "catalog.bizrate.com"
      end
      uri.path = "/services/catalog/v1/api/product"
      uri.query = [
        key,
        publisher_id,
        asin_or_upc || q
      ].compact.sort.join("&")
      uri
    end

    def to_s
      to_uri.to_s
    end

    def to_curl
      "curl -G '#{to_s}'"
    end

    def call
      request = HTTPI::Request.new
      request.url = to_s
      resp = HTTPI.get(request, @driver)
      PriceGrabber::Response.new(resp, @wants)
    end

    def pluck(*attributes)
      @wants = attributes.map(&:to_s)
      self
    end

    private

    def version
      "version=#{@version}"
    end

    def pid
      "publisherId=#{@pid}"
    end

    def key
      "apiKey=#{@key}"
    end

    def publisher_id
      "publisherId=#{@publisher_id}"
    end

    def asin_or_upc
      if @asin
        "productIdType=MPID&merchantId=184056&productId=#{@asin}"
      elsif @upc
        "productIdType=UPC&productId=#{@upc}"
      end
    end

    def q
      if @q
        "keyword=#{@q.gsub(/\s/, '+')}"
      end
    end
  end
end
