# frozen_string_literal: true

module ViaBTC
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :http_base_url, :http_response, :http_adapter

    def initialize
      @http_base_url = nil
    end
  end
end
