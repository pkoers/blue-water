#require 'finnhub_ruby'
#require 'dotenv/load'

FinnhubRuby.configure do |config|
  config.api_key['api_key'] = ENV['FINNHUB_API_KEY']
end

finnhub_client = FinnhubRuby::DefaultApi.new

puts(finnhub_client.company_profile2({symbol: 'AAPL'}))
