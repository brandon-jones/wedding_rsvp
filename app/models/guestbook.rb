class Guestbook < ActiveRecord::Base
	validates_presence_of :name, :message
	def self.generate_pdf
		file = Tempfile.new('guestbook', Rails.root.join('tmp'))
    Prawn::Document.generate(file.path) do
			text "Zack and Kaitlynn LaCom", :align => :center, :size => 20, :style => :bold
			text "Digital Wedding Guestbook", :align => :center, :size =>14
			move_down 40
			Guestbook.all.reverse_order.each do |message|
				float do
					text message.name, :align => :left
				end
				text message.created_at.localtime.strftime("%d %B %Y %l:%M %p"), :align => :right
				move_down 5
				text message.message, :indent_paragraphs => 30
				move_down 20
			end
			number_pages "page <page>/<total>", { :start_count_at => 0, :page_filter => :all, :at => [bounds.right - 50, 0], :align => :right, :size => 10 }
    end
    return file.path
	end
end
