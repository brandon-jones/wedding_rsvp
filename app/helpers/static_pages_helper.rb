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
end
