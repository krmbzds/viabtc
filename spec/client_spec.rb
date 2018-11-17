RSpec.describe ViaBTC::Client do

  let (:viabtc_client) { ViaBTC::Client.new(base_url: 'http://localhost:18080') }

  def generate_error(code, message)
    {"error"=>{"code"=>code, "message"=>message}, "result"=>nil, "id"=>0}
  end

  describe '#response_invalid?' do
    it 'returns true if response invalid' do
      expect(viabtc_client.send(:response_invalid?, generate_error(1, 'invalid argument'))).to eql(true)
    end

    it 'returns false if response valid' do
      expect(viabtc_client.send(:response_invalid?, {"error"=>nil} )).to eql(false)
    end
  end

  describe '#amount_valid?' do
    it 'returns true if amount is a positive integer' do
      expect(viabtc_client.send(:amount_valid?, 1)).to eql(true)
    end

    it 'returns true if amount is a positive float' do
      expect(viabtc_client.send(:amount_valid?, 1.0)).to eql(true)
    end

    it 'returns false if amount is a negative integer' do
      expect(viabtc_client.send(:amount_valid?, -1)).to eql(false)
    end

    it 'returns false if amount is a negative float' do
      expect(viabtc_client.send(:amount_valid?, -1.0)).to eql(false)
    end

    it 'returns false if amount is a string' do
      expect(viabtc_client.send(:amount_valid?, '1')).to eql(false)
    end
  end

  describe '#fee_rate_valid?' do
    it 'validates 0 fee rate' do
      expect(viabtc_client.send(:fee_rate_valid?, 0)).to eql(true)
    end

    it 'validates fee rate between 0 and 1' do
      expect(viabtc_client.send(:fee_rate_valid?, 0.5)).to eql(true)
    end

    it 'does not validate fee rate 1' do
      expect(viabtc_client.send(:fee_rate_valid?, 1)).to eql(false)
    end
  end

  describe '#raise_exchange_error' do
    it 'raises InvalidArgument on error code 1' do
      error_response = generate_error(1, 'invalid argument')
      expect { viabtc_client.send(:raise_exchange_error, error_response) }.to raise_error(ViaBTC::Error::InvalidArgument)
    end

    it 'raises InternalError on error code 2' do
      error_response = generate_error(2, 'internal error')
      expect { viabtc_client.send(:raise_exchange_error, error_response) }.to raise_error(ViaBTC::Error::InternalError)
    end

    it 'raises ServiceUnavailable on error code 3' do
      error_response = generate_error(3, 'service unavailable')
      expect { viabtc_client.send(:raise_exchange_error, error_response) }.to raise_error(ViaBTC::Error::ServiceUnavailable)
    end

    it 'raises MethodNotFound on error code 4' do
      error_response = generate_error(4, 'method not found')
      expect { viabtc_client.send(:raise_exchange_error, error_response) }.to raise_error(ViaBTC::Error::MethodNotFound)
    end

    it 'raises ServiceTimeout on error code 5' do
      error_response = generate_error(5, 'service timeout')
      expect { viabtc_client.send(:raise_exchange_error, error_response) }.to raise_error(ViaBTC::Error::ServiceTimeout)
    end

    context 'on limit orders' do
      it 'raises BalanceNotEnough on error code 10' do
        error_response = generate_error(10, 'balance not enough')
        expect { viabtc_client.send(:raise_exchange_error, error_response) }.to raise_error(ViaBTC::Error::LimitOrderBalanceNotEnough)
      end

      it 'raises LimitOrderAmountTooSmall on error code 11' do
        error_response = generate_error(11, 'amount too small')
        expect { viabtc_client.send(:raise_exchange_error, error_response) }.to raise_error(ViaBTC::Error::LimitOrderAmountTooSmall)
      end
    end

    context 'on balance update' do
      it 'raises RepeatBalanceUpdate on error code 10' do
        error_response = generate_error(10, 'repeat update')
        expect { viabtc_client.send(:raise_exchange_error, error_response) }.to raise_error(ViaBTC::Error::RepeatBalanceUpdate)
      end

      it 'raises BalanceNotEnough on error code 11' do
        error_response = generate_error(11, 'balance not enough')
        expect { viabtc_client.send(:raise_exchange_error, error_response) }.to raise_error(ViaBTC::Error::BalanceNotEnough)
      end
    end

    it 'raises LimitOrderNoEnoughTrader on error code 12' do
      error_response = generate_error(12, 'no enough trader')
      expect { viabtc_client.send(:raise_exchange_error, error_response) }.to raise_error(ViaBTC::Error::LimitOrderNoEnoughTrader)
    end

    it 'raises ExchangeError on unknown error code' do
      error_response = generate_error(69, 'unknown error')
      expect { viabtc_client.send(:raise_exchange_error, error_response) }.to raise_error(ViaBTC::Error::ExchangeError)
    end

  end
end
