require 'rubygems'
require 'nokogiri'
require 'open-uri'

BASE_WIKIPEDIA_URL = "https://fr.wikipedia.org"
PAGE_URL = "#{BASE_WIKIPEDIA_URL}/wiki/Tru64_UNIX"
RANDOM_PAGE = "#{BASE_WIKIPEDIA_URL}/wiki/Sp%C3%A9cial:Page_au_hasard"

def move_to_next_page(page_url)
	page = Nokogiri::HTML(open(page_url))
	parenth = 0

	page.css('div.mw-parser-output > p').each do |p|
		p.children.each do |c|
			if parenth == 0 or (parenth > 1 and (parenth % 2 == 0))
        		if c.name == 'a'
          		return BASE_WIKIPEDIA_URL + c.attributes["href"].value
        		end
      		end

      		if /\(/ === c.to_s
        		parenth += 1
      		elsif /\)/ === c.to_s
        		parenth += 1
     		end
    	end
  	end
end




# def move_to_next_page(page_url)
# 	page = Nokogiri::HTML(open(page_url))
# 	wiki_link = page.xpath('//*[@id="mw-content-text"]/div/p/a')

# 	i=0
# 	while i<wiki_link.length
# 		i+= 1 unless (wiki_link[i]['href'].slice(0..5)=="/wiki/") || ("#{BASE_WIKIPEDIA_URL}#{wiki_link[i]['href']}" == page_url) || (wiki_link[i]['href'] == nil)
# 		break
# 	end

# 	return BASE_WIKIPEDIA_URL + wiki_link[i]['href']
# end


def philosophy_road(p_url)
	
	page = Nokogiri::HTML(open(p_url))
	p_url = BASE_WIKIPEDIA_URL + page.xpath('//*[@id="ca-nstab-main"]/span/a')[0]['href']
	puts "Your road do philosohy started here : #{p_url}"
	title = page.xpath('//*[@id="firstHeading"]').text
	puts title

	count = 0

	array_history =[]
	
	while (p_url != 'https://fr.wikipedia.org/wiki/Philosophie')
		array_history.push(p_url)
		p_url = move_to_next_page(p_url)
		puts "current URL #{p_url}"
		count+=1
		break if (array_history.include?(p_url)) || (p_url == 0)
	end

	puts "The loop stopped after #{count} iterations at #{p_url}"
end

# puts philosophy_road(PAGE_URL)

def perform()
	philosophy_road(RANDOM_PAGE)
end

perform()

