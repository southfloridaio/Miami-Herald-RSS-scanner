[
	'open-uri',
	'nokogiri'
].each{|g|
	require g
}

rssArray = [
	'local/',
	'local/community/miami-dade/',
	'local/community/broward/',
	'local/community/florida-keys/',
	'local/community/gay-south-florida/',
	'state/florida/',
	'local/crime/',
	'politics-government/',
	'local/education/',
	'local/environment/'
]

File.open("MiamiHeraldRSS.txt", "w"){|file|  
	rssArray.each{|rssURLPart|
		rssURL = 'http://www.miamiherald.com/news/'+rssURLPart+'?widgetName=rssfeed&widgetContentId=712015&getXmlFeed=true'
		page = Nokogiri::XML(open(rssURL))
		items = page.css('item')
		items.each{|item|
			title = item.css('title').text
			link = item.css('link').text
			description = item.css('description').text
			arr = [
				Date.today.to_s,
				title,
				link,
				Nokogiri::HTML(description).text.gsub("\n",' ')
			]
			file.puts(arr.join("\t"))
			p arr
		}
	}
}