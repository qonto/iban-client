module IbanClient
  class Error < StandardError
    attr_reader :iban

    def initialize(iban:)
      @iban = iban
    end
  end

  class RequestError < Error
    attr_reader :response

    def initialize(iban:, response:)
      @response = response
      super(iban: iban)
    end

    def message
      "Request iban: #{iban}\n"\
      "Response: #{response}"
    end
  end

  class AccountError < Error
    attr_reader :errors

    def initialize(iban:, errors:)
      @errors = errors
      super(iban: iban)
    end

    def code
      errors.first['code']
    end

    def message
      "#{errors.first['message']} (#{code})"
    end
  end
end
