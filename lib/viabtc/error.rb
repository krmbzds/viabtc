module ViaBTC
  module Error
    # Base Error Class
    class ExchangeError < StandardError
      attr_reader :response
      def initialize(response)
        @code = response['error']['code']
        @message = response['error']['message']
        @response = response
      end
    end

    # ViaBTC Exchange Server General Error Codes
    InvalidArgument    = Class.new(ExchangeError)  # 1: Invalid Argument
    InternalError      = Class.new(ExchangeError)  # 2: Internal Error
    ServiceUnavailable = Class.new(ExchangeError)  # 3: Service Unavailable
    MethodNotFound     = Class.new(ExchangeError)  # 4: Method Not Found
    ServiceTimeout     = Class.new(ExchangeError)  # 5: Service Timeout

    ViaBTCError        = Class.new(StandardError)
    Configuration      = Class.new(ViaBTCError)
    InvalidParameter   = Class.new(ViaBTCError)
  end
end
