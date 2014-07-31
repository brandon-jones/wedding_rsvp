require 'tempfile'

class Rsvp < ActiveRecord::Base
	validates_presence_of :name, :contact
	before_save :fix_case

	def fix_case
		self.name = self.name.split(' ').map {|w| w.capitalize }.join(' ')
		self.contact = self.contact.split(' ').map {|w| w.capitalize }.join(' ')
	end

	def self.fixbool(value)
		if value == true || value == 'true'
			return 'Yes'
		else
			return 'No'
		end
	end

	def self.export_pdf(rsvp_for_export, total, title)

  	file = Tempfile.new('wedding', Rails.root.join('tmp'))
  	rsvp_export = [['','Name', 'Contact', 'Attending','Party Size']]
  	rsvp_for_export.each_with_index do |rsvp,i|
  		rsvp_export << [i+1,"#{rsvp.name}","#{rsvp.contact}","#{rsvp.attending.to_s == 'true' ? 'Yes' : 'No'}","#{rsvp.party_size.to_s}"]
  	end

    pdf = Prawn::Document.generate(file.path) do |pdf|
      # rsvp.each_with_index do |message|
	    pdf.text title, :size => 20
	    pdf.text "Total Coming: #{total}"
	    pdf.move_down 5

    	pdf.table(rsvp_export) do
    		rows(0..-1).style(:size => 9)
    		row(0).style(:background_color => 'dddddd', :align => :center, :font_style => :bold)
    		column(0).width = 25
    		column(1).width = 200
    		column(2).width = 200
    		column(3).width = 80
    		row(0).column(0).style(:background_color => 'ffffff')
    	end

    end

    file.close

    return file.path
  end

  def self.export_csv(rsvp_for_export)
  	# file = Tempfile.new('wedding', Rails.root.join('tmp'))


  	file = Tempfile.new('wedding', Rails.root.join('tmp'))
     file.write("Name,Contact,Attending,Party Size")
     file.write("\n")
     	rsvp_for_export.each do |rsvp_for_export|
	      file.write("#{rsvp_for_export.name.strip}, #{rsvp_for_export.contact.strip}, #{rsvp_for_export.attending.to_s.strip}, #{rsvp_for_export.party_size.to_s.strip}")
     file.write("\n")
    	end

    file.rewind

    return file.path
  end
  
end