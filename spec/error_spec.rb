RSpec.configure do |config|
  config.include ViaBTC::Helpers
end

RSpec.describe 'ViaBTC Error Handling' do

  describe '#raise_exchange_error' do
    it 'raises InvalidArgument on error code 1' do
      error_response = generate_error(1, 'invalid argument')
      expect { raise_exchange_error(error_response) }.to raise_error(ViaBTC::Error::InvalidArgument)
    end

    it 'raises InternalError on error code 2' do
      error_response = generate_error(2, 'internal error')
      expect { raise_exchange_error(error_response) }.to raise_error(ViaBTC::Error::InternalError)
    end

    it 'raises ServiceUnavailable on error code 3' do
      error_response = generate_error(3, 'service unavailable')
      expect { raise_exchange_error(error_response) }.to raise_error(ViaBTC::Error::ServiceUnavailable)
    end

    it 'raises MethodNotFound on error code 4' do
      error_response = generate_error(4, 'method not found')
      expect { raise_exchange_error(error_response) }.to raise_error(ViaBTC::Error::MethodNotFound)
    end

    it 'raises RequireAuthentication on error code 6' do
      error_response = generate_error(6, 'require authentication')
      expect { raise_exchange_error(error_response) }.to raise_error(ViaBTC::Error::RequireAuthentication)
    end

    it 'raises ServiceTimeout on error code 5' do
      error_response = generate_error(5, 'service timeout')
      expect { raise_exchange_error(error_response) }.to raise_error(ViaBTC::Error::ServiceTimeout)
    end

    context 'on limit orders' do
      it 'raises BalanceNotEnough on error code 10' do
        error_response = generate_error(10, 'balance not enough')
        expect { raise_exchange_error(error_response) }.to raise_error(ViaBTC::Error::LimitOrderBalanceNotEnough)
      end

      it 'raises LimitOrderAmountTooSmall on error code 11' do
        error_response = generate_error(11, 'amount too small')
        expect { raise_exchange_error(error_response) }.to raise_error(ViaBTC::Error::LimitOrderAmountTooSmall)
      end
    end

    context 'on balance update' do
      it 'raises RepeatBalanceUpdate on error code 10' do
        error_response = generate_error(10, 'repeat update')
        expect { raise_exchange_error(error_response) }.to raise_error(ViaBTC::Error::RepeatBalanceUpdate)
      end

      it 'raises BalanceNotEnough on error code 11' do
        error_response = generate_error(11, 'balance not enough')
        expect { raise_exchange_error(error_response) }.to raise_error(ViaBTC::Error::BalanceNotEnough)
      end
    end

    it 'raises LimitOrderNoEnoughTrader on error code 12' do
      error_response = generate_error(12, 'no enough trader')
      expect { raise_exchange_error(error_response) }.to raise_error(ViaBTC::Error::LimitOrderNoEnoughTrader)
    end

    it 'raises ExchangeError on unknown error code' do
      error_response = generate_error(69, 'unknown error')
      expect { raise_exchange_error(error_response) }.to raise_error(ViaBTC::Error::ExchangeError)
    end

  end

end
