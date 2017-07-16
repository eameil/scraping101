require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = 'https://coinmarketcap.com/all/views/all/'

def get_prices()
	page = Nokogiri::HTML(open(PAGE_URL))
	moneys_array = page.xpath('//td[2]/a')
	prices_array = page.xpath('//td/a[@class = "price"]')
	array_crypto = []

	for i in (0...moneys_array.length)
		array_crypto[i] = {}
		array_crypto[i][:"name"] = moneys_array[i].text
		array_crypto[i][:"price"] = prices_array[i].text
	end

	return array_crypto
end

puts get_prices()

def price_update()
end

