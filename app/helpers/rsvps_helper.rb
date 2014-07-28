module RsvpsHelper

	def get_order(name)
		if params[:sort_by]
			if params[:sort_by] == name

				if params[:order_by]
					return params[:order_by] == 'asc' ? 'desc' : 'asc'
				end
			end
		end
		return 'asc'
	end

	def direction_arrow(name)
		if params[:sort_by] && params[:sort_by] == name
			if params[:order_by] == 'asc'
				return raw "<span class='glyphicon glyphicon-chevron-up'></span> "
			else
				return raw "<span class='glyphicon glyphicon-chevron-down'></span> "
			end	
		end
		return ''
	end

end
