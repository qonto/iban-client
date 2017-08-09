require 'simplecov'
SimpleCov.start

require 'webmock/rspec'

require 'iban_client'
require 'support/fake_iban'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each, iban: true) do
    WebMock.stub_request(:any, /iban\.com/).to_rack(FakeIban)
  end
end
