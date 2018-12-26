RSpec.describe ViaBTC::HTTP::Client do

  let (:http_client) { ViaBTC::HTTP::Client.new(url: 'http://localhost:18080') }

  context 'when calling helper methods' do
    it 'can access response_invalid? method' do
      expect(http_client.methods.include?(:response_invalid?)).to be true
    end

    it 'can access amount_valid? method' do
      expect(http_client.methods.include?(:amount_valid?)).to be true
    end

    it 'can access fee_rate_valid? method' do
      expect(http_client.methods.include?(:fee_rate_valid?)).to be true
    end

    it 'can access now method' do
      expect(http_client.methods.include?(:now)).to be true
    end

    it 'can access raise_exchange_error method' do
      expect(http_client.methods.include?(:raise_exchange_error)).to be true
    end
  end
end
