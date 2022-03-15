# frozen_string_literal: true

module ViaBTC
  module HTTP
    class Client
      include ViaBTC::Helpers

      def initialize(url: nil, http_response: nil, http_adapter: nil)
        if ViaBTC.configuration
          url ||= ViaBTC.configuration.http_base_url
          http_response ||= ViaBTC.configuration.http_response
          http_adapter ||= ViaBTC.configuration.http_adapter
        end

        @connection ||= connection(url, http_response, http_adapter)
      end

      # Asset API

      def balance(user_id:, id: 0)
        request(id: id, method: "balance.query", params: [user_id])
      end

      def withdraw(user_id:, asset:, withdraw_id:, amount:, source: "web", id: 0)
        raise ViaBTC::Error::InvalidParameter, "invalid amount: #{amount}" unless amount_valid?(amount)

        request(
          id: id,
          method: "balance.update",
          params: [user_id, asset, "withdraw", withdraw_id, amount, {source: source}]
        )
      end

      def deposit(user_id:, asset:, deposit_id:, amount:, source: "web", id: 0)
        raise ViaBTC::Error::InvalidParameter, "invalid amount: #{amount}" unless amount_valid?(amount)

        request(
          id: id,
          method: "balance.update",
          params: [user_id, asset, "deposit", deposit_id, amount, {source: source}]
        )
      end

      def balance_history(user_id:, asset:, business: "", start_time: 0, end_time: 0, offset: 0, limit: 100, id: 0)
        request(id: id, method: "balance.history", params: [user_id, asset, business, start_time, end_time, offset, limit])
      end

      def asset_list
        request(method: "asset.list", params: [])
      end

      def asset_summary
        request(method: "asset.summary", params: [])
      end

      # Trade API

      def limit_sell(user_id:, market:, amount:, price:, taker_fee_rate:, maker_fee_rate:, source: "web", id: 0)
        raise ViaBTC::Error::InvalidParameter, "invalid amount: #{amount}" unless amount_valid?(amount)
        raise ViaBTC::Error::InvalidParameter, "invalid fee rate #{taker_fee_rate}" unless fee_rate_valid?(taker_fee_rate)
        raise ViaBTC::Error::InvalidParameter, "invalid fee rate #{maker_fee_rate}" unless fee_rate_valid?(maker_fee_rate)

        request(
          id: id,
          method: "order.put_limit",
          params: [user_id, market, 1, amount, price, taker_fee_rate, maker_fee_rate, source]
        )
      end

      def limit_buy(user_id:, market:, amount:, price:, taker_fee_rate:, maker_fee_rate:, source: "web", id: 0)
        raise ViaBTC::Error::InvalidParameter, "invalid amount: #{amount}" unless amount_valid?(amount)
        raise ViaBTC::Error::InvalidParameter, "invalid fee rate #{taker_fee_rate}" unless fee_rate_valid?(taker_fee_rate)
        raise ViaBTC::Error::InvalidParameter, "invalid fee rate #{maker_fee_rate}" unless fee_rate_valid?(maker_fee_rate)

        request(
          id: id,
          method: "order.put_limit",
          params: [user_id, market, 2, amount, price, taker_fee_rate, maker_fee_rate, source]
        )
      end

      def market_sell(user_id:, market:, amount:, taker_fee_rate:, source: "web", id: 0)
        raise ViaBTC::Error::InvalidParameter, "invalid amount: #{amount}" unless amount_valid?(amount)
        raise ViaBTC::Error::InvalidParameter, "invalid fee rate #{taker_fee_rate}" unless fee_rate_valid?(taker_fee_rate)

        request(
          id: id,
          method: "order.put_market",
          params: [user_id, market, 1, amount, taker_fee_rate.to_s, source]
        )
      end

      def market_buy(user_id:, market:, amount:, taker_fee_rate:, source: "web", id: 0)
        raise ViaBTC::Error::InvalidParameter, "invalid amount: #{amount}" unless amount_valid?(amount)
        raise ViaBTC::Error::InvalidParameter, "invalid fee rate #{taker_fee_rate}" unless fee_rate_valid?(taker_fee_rate)

        request(
          id: id,
          method: "order.put_market",
          params: [user_id, market, 2, amount, taker_fee_rate.to_s, source]
        )
      end

      def cancel_order(user_id:, market:, order_id:, id: 0)
        request(id: id, method: "order.cancel", params: [user_id, market, order_id])
      end

      def order_deals(order_id:, offset: 0, limit: 100, id: 0)
        request(id: id, method: "order.deals", params: [order_id, offset, limit])
      end

      def sell_orders(market:, offset: 0, limit: 100, id: 0)
        request(id: id, method: "order.book", params: [market, 1, offset, limit])
      end

      def buy_orders(market:, offset: 0, limit: 100, id: 0)
        request(id: id, method: "order.book", params: [market, 2, offset, limit])
      end

      def order_depth(market:, limit: 100, interval: "0", id: 0)
        request(id: id, method: "order.depth", params: [market, limit, interval])
      end

      def pending_orders(user_id:, market:, offset: 0, limit: 100, id: 0)
        request(id: id, method: "order.pending", params: [user_id, market, offset, limit])
      end

      def pending_order_details(order_id:, market:, id: 0)
        request(id: id, method: "order.pending_detail", params: [market, order_id])
      end

      def finished_orders(user_id:, market:, start_time: 0, end_time: 0, offset: 0, limit: 100, side: 0, id: 0)
        request(id: id, method: "order.finished", params: [user_id, market, start_time, end_time, offset, limit, side])
      end

      def finished_sell_orders(user_id:, market:, start_time: 0, end_time: 0, offset: 0, limit: 100, side: 1, id: 0)
        request(id: id, method: "order.finished", params: [user_id, market, start_time, end_time, offset, limit, side])
      end

      def finished_buy_orders(user_id:, market:, start_time: 0, end_time: 0, offset: 0, limit: 100, side: 2, id: 0)
        request(id: id, method: "order.finished", params: [user_id, market, start_time, end_time, offset, limit, side])
      end

      def finished_order_detail(order_id:, id: 0)
        request(id: id, method: "order.finished_detail", params: [order_id])
      end

      # Market API

      def market_last(market:, id: 0)
        request(id: id, method: "market.last", params: [market])
      end

      def market_deals(market:, limit: 10_000, last_id: 0, id: 0)
        request(id: id, method: "market.deals", params: [market, limit, last_id])
      end

      def user_executed_orders(user_id:, market:, offset: 0, limit: 100, id: 0)
        request(id: id, method: "market.user_deals", params: [user_id, market, offset, limit])
      end

      def market_kline(market:, start_time: now - 86_400, end_time: now, interval: 3600, id: 0)
        request(id: id, method: "market.kline", params: [market, start_time, end_time, interval])
      end

      def market_status(market:, period: 86_400, id: 0)
        request(id: id, method: "market.status", params: [market, period])
      end

      def market_status_today(market:, id: 0)
        market_status(market: market, period: 86_400, id: id)
      end

      def market_list(id: 0)
        request(id: id, method: "market.list", params: [])
      end

      def market_summary(id: 0)
        request(id: id, method: "market.summary", params: [])
      end

      private

      def connection(url, http_response, http_adapter)
        raise ViaBTC::Error::Configuration, "required: url" unless url

        http_response ||= :logger
        http_adapter ||= :net_http

        Faraday.new(url) do |conn|
          conn.response http_response
          conn.adapter http_adapter
          conn.headers["Content-Type"] = ["application/json"]
        end
      end

      def request(method:, params:, id: 0)
        response = @connection.post do |req|
          req.body = {
            "id" => id,
            "method" => method,
            "params" => params
          }.to_json
        end
        response = JSON.parse(response.body)
        raise_exchange_error(response) if response_invalid?(response)
        response
      end
    end
  end
end
