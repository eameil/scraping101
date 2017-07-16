require 'rubygems'
require 'nokogiri'
require 'open-uri'

PAGE_URL = 'http://annuaire-des-mairies.com/95/vaureal.html'

def get_the_email_of_a_townhal_from_its_webpage(page_url)
	page = Nokogiri::HTML(open(page_url))
	return page.xpath('//html/body/table/tr[3]/td/table/tr[1]/td[1]/table[4]/tr[2]/td/table/tr[4]/td[2]/p').text.slice(1..-1)
end



def get_all_the_urls_of_val_doise_townhalls()
	array_townhall = []
	page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))
	towns = page.xpath('//table/tr[2]/td/table/tr/td/p/a')

	towns.each do |node|
		h_townhall = {}
		townhall_name = node.text
		townhall_url = node['href'].slice(1..-1)
		h_townhall[:"town_name"] = townhall_name
		h_townhall[:"URL"] = "http://annuaire-des-mairies.com#{townhall_url}"
		array_townhall.push(h_townhall)
	end
	return array_townhall
end


def get_the_emails_of_all_valdoise_townhalls()
	a_townhall_emails = []
	get_all_the_urls_of_val_doise_townhalls.each do |h_towns|
		h_townhall_emails={}
		town_email = get_the_email_of_a_townhal_from_its_webpage(h_towns[:"URL"])
		h_townhall_emails[:'name'] = h_towns[:"town_name"]
		h_townhall_emails[:'email'] = town_email
		a_townhall_emails.push(h_townhall_emails)
	end
	return a_townhall_emails
end

puts get_the_emails_of_all_valdoise_townhalls
