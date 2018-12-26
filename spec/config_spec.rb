RSpec.describe 'ViaBTC Configuration' do
  context 'when no configuration set' do
    it 'raises error when instantiated no params' do
      expect { ViaBTC::HTTP::Client.new }.to raise_error(ViaBTC::Error::Configuration)
    end

    it 'raises error when instantiated no http_base_url' do
      options = { http_response: :logger, http_adapter: :net_http }
      expect { ViaBTC::HTTP::Client.new(options) }.to raise_error(ViaBTC::Error::Configuration)
    end
  end

  context 'when configuration block set' do
    it 'raises error if http_base_url is missing' do
      ViaBTC.configure do |config|
        config.http_response = :logger
        config.http_adapter = :net_http
      end
      expect { ViaBTC::HTTP::Client.new }.to raise_error(ViaBTC::Error::Configuration)
    end
  end
end
