require 'sinatra/base'

class FakeIban < Sinatra::Base
  get '/clients/api/ibanv2.php' do
    if params['api_key'] == 'invalid_key'
      json_response(200, 'errors')
    elsif params['iban'] == 'FR7616798000010000005663951'
      json_response(200, 'valid')
    elsif params['iban'] == 'raise'
      halt 500, { message: 'Failure' }.to_json
    else
      json_response(200, 'invalid')
    end
  end

  private

  def json_response(status, path)
    content_type :json
    IO.read("spec/fixtures/#{path}.json")
  end
end
