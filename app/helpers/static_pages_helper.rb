module StaticPagesHelper
	def humanize_16point(value)
		ary = Array.new
		value.chars.each do |v|
			ary << convert_compase_direction(v)
		end
		return ary.join(' ')
	end

	def convert_compase_direction(value)
		case value
		when 'N'
			return 'North'
		when 'W'
			return 'West'
		when 'E'
			return 'East'
		when 'S'
			return 'South'
		end
	end

	def map_url(address)
		split_address = address.split(',')
		"https://www.google.com/maps/dir/#{split_address[0].gsub(' ','+')},+Tehachapi,+CA+93561/30301+Sheeptrail+Ct,+Tehachapi,+CA+93561"
	end
end
