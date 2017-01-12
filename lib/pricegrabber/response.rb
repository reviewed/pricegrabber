require 'active_support/core_ext/hash/conversions'
require 'pricegrabber/response_item'

module PriceGrabber
  # Represents a response from the PriceGrabber API.
  class Response
    include Enumerable
    # @param response [HTTPI::Response] The XML response from Pricegrabber's API
    # @param wants [Array<String>] Attributes from the response that should be made available within this response
    def initialize(response, wants)
      @status = response.code
      @results = []
      return if @status != 200
      resp_hash = Hash.from_xml(response.body)
      [resp_hash["ProductResponse"]["Offers"]["Offer"]].flatten.each do |product|
        curr_result = ResponseItem.with_attributes(wants)
        wants.map do |want|
          parts = want.split(".")
          curr = parts.shift
          curr_value = product
          while curr && curr_value
            curr_value = curr_value[curr]
            curr = parts.shift
          end

          curr_result.public_send(:"#{want.downcase.tr(".", "_")}=", curr_value)
        end
        @results << curr_result unless curr_result.empty?
      end
    end

    def each(*args, &block)
      @results.each(*args, &block)
    end

    def successful?
      @status < 300 && @status >= 200
    end
  end
end
