# frozen_string_literal: true

module ViaBTC
  module Helpers
    def response_invalid?(response)
      !response['error'].nil?
    end

    def amount_valid?(amount)
      amount.is_a?(Numeric) && amount.positive? && (amount.is_a?(Integer) || amount.is_a?(Float))
    end

    def fee_rate_valid?(fee_rate)
      (0...1).cover?(fee_rate)
    end

    def now
      Time.now.to_i
    end

    def raise_exchange_error(response)
      error_code    = response['error']['code']
      error_message = response['error']['message']

      case error_code
      when 1 then raise ViaBTC::Error::InvalidArgument, response
      when 2 then raise ViaBTC::Error::InternalError, response
      when 3 then raise ViaBTC::Error::ServiceUnavailable, response
      when 4 then raise ViaBTC::Error::MethodNotFound, response
      when 5 then raise ViaBTC::Error::ServiceTimeout, response
      when 6 then raise ViaBTC::Error::RequireAuthentication, response
      when 10
        case error_message
        when 'balance not enough' then raise ViaBTC::Error::LimitOrderBalanceNotEnough, response
        when 'repeat update' then raise ViaBTC::Error::RepeatBalanceUpdate, response
        else raise ViaBTC::Error::ExchangeError, response
        end
      when 11
        case error_message
        when 'amount too small' then raise ViaBTC::Error::LimitOrderAmountTooSmall, response
        when 'balance not enough' then raise ViaBTC::Error::BalanceNotEnough, response
        end
      when 12 then raise ViaBTC::Error::LimitOrderNoEnoughTrader, response
      else raise ViaBTC::Error::ExchangeError, response
      end
    end
  end
end
