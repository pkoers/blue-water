# Uncomment these requires to use this script outside of Rails
#
# require 'httparty'
# require 'nokogiri'

Holder = Struct.new(:percentage, :text)

class Scraper
  attr_accessor :holders

  def initialize(symbol: 'AAPL')
    @url     = "https://finance.yahoo.com/quote/#{symbol}/holders/"
    @holders = []
  end

  def fetch
    response = HTTParty.get(@url, {
                            headers: {
                              # Look like a browser
                              "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
                            }})

    document = Nokogiri::HTML(response.body)

    major_holders = document.css("tr.majorHolders")

    major_holders.each do |holder_row|
      cols       = holder_row.css("td.majorHolders")
      percentage = cols.first.text.strip
      text       = cols.last.text.strip

      holder = Holder.new(percentage, text)

      @holders.push(holder)
    end
  end
end


# Example Usage -------------------------------------

# symbols = ['AAPL', 'V', 'AMZN', 'BA', 'COKE', 'MCD']

# symbols.each do |symbol|
#   scraper = Scraper.new(symbol: symbol)
#   scraper.fetch

#   puts "Symbol: #{symbol}"

#   scraper.holders.each do |holder|
#     puts "#{holder.percentage} -- #{holder.text}"
#   end

#   puts ''
# end
