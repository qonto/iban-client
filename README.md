# Iban.com wrapper

Wrapper for the [iban.com](https://www.iban.com) validation api (v2)

## Documentation

See the [API docs](https://www.iban.com/validation-api-v2.html).


### Requirements

* Ruby 2.2+.

### Bundler

If you are installing via bundler, you should be sure to use the https rubygems
source in your Gemfile, as any gems fetched over http could potentially be
compromised in transit and alter the code of gems fetched securely over https:

``` ruby
source 'https://rubygems.org'

gem 'iban_client'
```

## Configuration

```ruby
IbanClient.configure do |config|
  config.api_key = 'you api key'
  config.timeout = 2
end
```

## Usage

```ruby
iban = IbanClient::Iban.new('FR7616798000010000005663951')
iban.valid? # => true

iban.bic # => "TRZOFR21"
iban.bank # => "TREEZOR SAS"
iban.address # => "150 RUE GALLIENI"
iban.city # => "BOULOGNE BILLANCOURT CEDEX"
iban.state # => nil
iban.zip # => "92641"
iban.country # => "FRANCE"
iban.country_iso # => "FR"
iban.bic # => "TRZOFR21"
iban.account # => "00000056639"
```

## Development

Run all tests:

    bundle exec rspec
