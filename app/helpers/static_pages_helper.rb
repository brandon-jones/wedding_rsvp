module StaticPagesHelper
	def map_url(address)
		split_address = address.split(',')
		"https://www.google.com/maps/place/#{split_address[0].gsub(' ','+')}"
	end
end
