module GuestbooksHelper
	def flag_status(guestbook)
		if guestbook.flag == nil
			return link_to content_tag(:i,'', :class=>"fa fa-flag-o fa-2x flag"),flag_guestbook_path(guestbook.id), class: 'disable-hover'
		end
	end

	def login_url
		return "user@localhost:3003/guestbooks/manage"
	end

	def get_stars(rating)
		full = "<i class='fa fa-star'></i>"
		half = "<i class='fa fa-star-half-o'></i>"
		none = "<i class='fa fa-star-o'></i>"
		builder = ""
		builder += rating.floor.times.map { full }.join
		builder += half if (rating % 1 != 0)
		builder += (5 - rating.ceil).times.map { none }.join
		return raw builder
	end
end
