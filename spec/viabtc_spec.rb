RSpec.describe ViaBTC do
  context 'when no configuration set' do
    it 'raises error when instantiated no params' do
      expect { ViaBTC::Client.new }.to raise_error(ViaBTC::Error::Configuration)
    end

    it 'raises error when instantiated no base_url' do
      options = { faraday_response: :logger, faraday_adapter: :net_http }
      expect { ViaBTC::Client.new(options) }.to raise_error(ViaBTC::Error::Configuration)
    end
  end

  context 'when configuration block set' do
    it 'raises error if base_url is missing' do
      ViaBTC.configure do |config|
        config.faraday_response = :logger
        config.faraday_adapter = :net_http
      end
      expect { ViaBTC::Client.new }.to raise_error(ViaBTC::Error::Configuration)
    end
  end
end
