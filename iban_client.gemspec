$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'iban_client/version'

Gem::Specification.new do |s|
  s.name        = 'iban_client'
  s.version     = IbanClient::VERSION
  s.date        = '2017-08-08'
  s.summary     = 'Iban.com client'
  s.description = 'Wrapper for the Iban.com API'
  s.authors     = ['Vincent Pochet']
  s.email       = 'vincent@qonto.eu'
  s.homepage    = "https://github.com/qonto/iban-client"
  s.files       = ['lib/iban_client.rb']
  s.license     = 'WTFPL'

  s.require_paths = ['lib']

  s.required_ruby_version     = '>= 2.2'
  s.required_rubygems_version = '>= 1.8.11'

  s.add_dependency 'rest-client', '~> 1.8'

  s.add_development_dependency 'bundler', '~> 1.7'
  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency 'pry', '~> 0.10'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'sinatra'
end
