RSpec.configure do |config|
  config.include ViaBTC::Helpers
end

RSpec.describe ViaBTC::Helpers do
  describe '#response_invalid?' do
    it 'returns true if response invalid' do
      expect(response_invalid?(generate_error(1, 'invalid argument'))).to eql(true)
    end

    it 'returns false if response valid' do
      expect(response_invalid?({"error"=>nil} )).to eql(false)
    end
  end

  describe '#amount_valid?' do
    it 'returns true if amount is a positive integer' do
      expect(amount_valid?(1)).to eql(true)
    end

    it 'returns true if amount is a positive float' do
      expect(amount_valid?(1.0)).to eql(true)
    end

    it 'returns false if amount is a negative integer' do
      expect(amount_valid?(-1)).to eql(false)
    end

    it 'returns false if amount is a negative float' do
      expect(amount_valid?(-1.0)).to eql(false)
    end

    it 'returns false if amount is a string' do
      expect(amount_valid?('1')).to eql(false)
    end
  end

  describe '#fee_rate_valid?' do
    it 'validates 0 fee rate' do
      expect(fee_rate_valid?(0)).to eql(true)
    end

    it 'validates fee rate between 0 and 1' do
      expect(fee_rate_valid?(0.5)).to eql(true)
    end

    it 'does not validate fee rate 1' do
      expect(fee_rate_valid?(1)).to eql(false)
    end
  end
end
