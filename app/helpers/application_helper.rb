module ApplicationHelper

	def noramlize_bool(value)
		if value == true || value == 'true'
			return 'Yes'
		else
			return 'No'
		end
	end
end
