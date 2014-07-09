module GuestbooksHelper
	def flag_status(guestbook)
		if guestbook.flag == nil
			return link_to content_tag(:i,'', :class=>"fa fa-flag-o fa-2x"),flag_guestbook_path(guestbook.id), class: 'disable-hover'
		end
	end

	def login_url
		return "user@localhost:3003/guestbooks/manage"
	end
end
