#require 'finnhub_ruby'
#require 'dotenv/load'

def object_to_hash(object)
  hash = {}
  object.instance_variables.each do |var|
    hash[var.to_s.delete('@').to_sym] = object.instance_variable_get(var)
  end
  hash
end

FinnhubRuby.configure do |config|
  config.api_key['api_key'] = ENV['FINNHUB_API_KEY']
end

finnhub_client = FinnhubRuby::DefaultApi.new

begin
  # Get the company profile for Stock
  output = finnhub_client.company_profile2({symbol: 'AAPL'})

  # Convert the output to a hash that can be returned to the view
  company_profile = object_to_hash(output)

  # Get Quote data for Stock
  output = finnhub_client.quote('AAPL')

  # Convert the output to a hash that can be returned to the view
  company_quote = object_to_hash(output)

rescue FinnhubRuby::ApiError => e
  puts "Exception when calling FinnhubRuby::DefaultApi->company_profile2: #{e}"
end
