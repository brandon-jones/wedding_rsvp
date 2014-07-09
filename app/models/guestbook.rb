class Guestbook < ActiveRecord::Base
	def self.generate_pdf
    Prawn::Document.generate("tmp/pdf/export.pdf") do
			Guestbook.all.reverse_order.each do |message|
				text message.name
				text message.message
				move_down 20
			end
    end
	end
end
