# frozen_string_literal: true

module ViaBTC
  module Error
    # ViaBTC Module Error Classes
    ViaBTCError      = Class.new(StandardError)  # Module Base Error Class
    Configuration    = Class.new(ViaBTCError)    # Module Config Error
    InvalidParameter = Class.new(ViaBTCError)    # Module Invalid Param Error

    # ViaBTC Exchange Server Base Error Class
    class ExchangeError < StandardError
      attr_reader :response
      def initialize(response)
        @code = response['error']['code']
        @message = response['error']['message']
        @response = response
      end
    end

    # ViaBTC Exchange Server General Error Codes
    InvalidArgument       = Class.new(ExchangeError)  #  1: Invalid Argument
    InternalError         = Class.new(ExchangeError)  #  2: Internal Error
    ServiceUnavailable    = Class.new(ExchangeError)  #  3: Service Unavailable
    MethodNotFound        = Class.new(ExchangeError)  #  4: Method Not Found
    ServiceTimeout        = Class.new(ExchangeError)  #  5: Service Timeout
    RequireAuthentication = Class.new(ExchangeError)  #  6: Require Authentication

    # ViaBTC Exchange Server Undocumented Error Codes with Gotchas

    # matchengine/me_server.c: on_cmd_order_put_limit
    LimitOrderBalanceNotEnough = Class.new(ExchangeError)  # 10: Balance Not Enough
    LimitOrderAmountTooSmall   = Class.new(ExchangeError)  # 11: Amount Too Small
    LimitOrderNoEnoughTrader   = Class.new(ExchangeError)  # 12: No Enough Trader

    # matchengine/me_server.c: on_cmd_balance_update
    RepeatBalanceUpdate = Class.new(ExchangeError)  # 10: Repeat Update
    BalanceNotEnough    = Class.new(ExchangeError)  # 11: Balance Not Enough
  end
end
