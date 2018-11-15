module ViaBTC
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :base_url, :faraday_response, :faraday_adapter

    def initialize
      @base_url = nil
    end
  end
end
