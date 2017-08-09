module IbanClient
  class Iban
    BANK_DATA_GETTER = %w(bic bank address city state zip country country_iso account)
    SEPA_DATA_GETTER = %w(sct sdd cor1 b2b scc)

    VALIDATION_MESSAGES = {
      '201' => :invalid_account_number,
      '202' => :invalid_iban_digit,
      '203' => :invalid_iban_length,
      '205' => :invalid_iban_structure
    }

    attr_reader :iban

    def initialize(iban)
      @iban = iban
    end

    BANK_DATA_GETTER.each do |attribute|
      define_method(attribute) do
        handle_result { (result['bank_data'] || [])[attribute] }
      end
    end

    SEPA_DATA_GETTER.each do |attribute|
      define_method("#{attribute}?") do
        handle_result { (result['sepa_data'] || [])[attribute.upcase] == 'YES' }
      end
    end

    def attributes
      handle_result { (result['bank_data'] || {}).merge('iban' => iban) }
    end

    def valid?
      errors.empty?
    end

    def errors
      handle_result do
        (result['validations'] || []).map { |validation| VALIDATION_MESSAGES[validation['code']] }
                                     .reject(&:nil?)
      end
    end

    private

    def request
      RestClient::Request.execute(
        method: :get,
        url: "#{IbanClient.api_base}?#{params}",
        timeout: IbanClient.timeout
      )
    rescue RestClient::ExceptionWithResponse => err
      raise IbanClient::RequestError.new(iban: iban, initial_error: err)
    end

    def params
      URI.encode_www_form(
        format: :json,
        api_key: IbanClient.api_key,
        iban: iban
      )
    end

    def result
      @result ||= JSON.parse(request)
    end

    def api_errors
      result['errors']
    end

    def handle_result(&block)
      raise IbanClient::AccountError.new(iban: iban, errors: api_errors) if api_errors.count > 0
      yield
    end
  end
end
