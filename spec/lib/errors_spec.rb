require 'spec_helper'

describe IbanClient::RequestError do
  subject(:request_error) { described_class.new(iban: nil, response: nil) }

  describe 'message' do
    subject(:message) { request_error.message }

    it 'does not raise' do
      expect { message }.not_to raise_error
    end
  end
end
