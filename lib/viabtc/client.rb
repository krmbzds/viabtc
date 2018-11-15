module ViaBTC
  class Client
    def initialize(base_url: nil, faraday_response: nil, faraday_adapter: nil)
      if ViaBTC.configuration
        base_url         ||= ViaBTC.configuration.base_url
        faraday_response ||= ViaBTC.configuration.faraday_response || :logger
        faraday_adapter  ||= ViaBTC.configuration.faraday_adapter  || :net_http
      else
        faraday_response ||= :logger
        faraday_adapter  ||= :net_http
      end

      raise ViaBTC::Error::Configuration, 'required: base_url' unless base_url

      @connection ||= Faraday.new(base_url) do |conn|
        conn.response faraday_response
        conn.adapter faraday_adapter
        conn.headers['Content-Type'] = ['application/json']
      end
    end

  end
end
