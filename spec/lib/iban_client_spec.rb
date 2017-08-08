require 'spec_helper'

describe IbanClient do
  subject { IbanClient }

  describe '.api_base' do
    it 'has default url' do
      expect(subject.api_base).to eq('https://api.iban.com/clients/api/ibanv2.php')
    end
  end

  describe '.timeout' do
    it 'has default timeout' do
      expect(subject.timeout).to eq(10)
    end
  end

  describe '.config' do
    let(:api_key) { 'foo_bar' }

    before do
      subject.config do |config|
        config.api_key = api_key
        config.timeout = 2
      end
    end

    it 'changes the config' do
      expect(subject.api_key).to eq(api_key)
      expect(subject.timeout).to eq(2)
    end
  end
end
