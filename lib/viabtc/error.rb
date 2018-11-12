module ViaBTC
  module Error
    # This gem will only raise errors that originate from the exchange server.

    ExchangeError      = Class.new(StandardError)  # Base Error Class

    InvalidArgument    = Class.new(ExchangeError)  # 1: Invalid Argument
    InternalError      = Class.new(ExchangeError)  # 2: Internal Error
    ServiceUnavailable = Class.new(ExchangeError)  # 3: Service Unavailable
    MethodNotFound     = Class.new(ExchangeError)  # 4: Method Not Found
    ServiceTimeout     = Class.new(ExchangeError)  # 5: Service Timeout
  end
end
