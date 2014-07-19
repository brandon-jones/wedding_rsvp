class Weather

	def initialize
		key = YAML.load_file("config/tehachapi.yml")[Rails.env]['weather_key']
		@base_url = "http://api.worldweatheronline.com/free/v1/weather.ashx?q=Tehachapi,ca&key=#{key}&format=json&num_of_days=5"
		weather = Nokogiri::XML(File.read("config/weather_codes.xml"))
		@weather_xml = weather.xpath("//condition")
	end

	def get_current
		weather_condidtions = request_weather
		if weather_hash = JSON.parse(weather_condidtions)
			return weather_hash['data']['current_condition'][0] if weather_hash['data'] && weather_hash['data']['current_condition'] 
		end
	end

	def get_forcast
		weather_condidtions = request_weather
		if weather_hash = JSON.parse(weather_condidtions)
			return weather_hash['data']['weather'] if weather_hash['data'] && weather_hash['data']['weather'] 
		end
	end

	def request_weather
		return @weather if @weather
		return @weather = RestClient.get(@base_url)
	end

	def code_description(code)
		@weather_xml.each do |child|
			if child.children.filter("code")[0].inner_text == code
				return child.children.filter("description")[0].inner_text
			end
		end
	end

	def code_icon(code)
		@weather_xml.each do |child|
			if child.children.filter("code")[0].inner_text == code
				if Time.now.hour > 5 || Time.now.hour < 19
					return child.children.filter("day_icon")[0].inner_text
				else
					return child.children.filter("night_icon")[0].inner_text
				end
			end
		end
	end

	def code_icon_description_array(code)
		@weather_xml.each do |child|
			if child.children.filter("code")[0].inner_text == code
				if Time.now.hour > 5 || Time.now.hour < 19
					return_array = Hash.new
					return_array['description'] = child.children.filter("description")[0].inner_text
					return return_array['icon'] == child.children.filter("day_icon")[0].inner_text
				else
					return return_array['icon'] == child.children.filter("night_icon")[0].inner_text
				end
			end
		end
	end

end
