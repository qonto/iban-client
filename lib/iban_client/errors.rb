module IbanClient
  class Error < StandardError
    attr_reader :iban

    def initialize(iban:)
      @iban = iban
    end
  end

  class RequestError < Error
    attr_reader :initial_error

    def initialize(iban:, initial_error:)
      @initial_error = initial_error
      super(iban: iban)
    end

    def message
      "#{initial_error.message}\n"\
      "Request iban: #{iban}\n"\
      "Response: #{initial_error.response}"
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
