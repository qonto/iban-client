require 'rest-client'
require 'json'
require 'uri'

require 'iban_client/errors'
require 'iban_client/iban'

module IbanClient
  @api_base = 'https://api.iban.com/clients/api/ibanv2.php'
  @timeout = 10

  class << self
    attr_accessor :api_key, :timeout
    attr_reader :api_base
  end

  def self.config
    yield self if block_given?
  end
end
