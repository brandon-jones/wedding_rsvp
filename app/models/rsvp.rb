class Rsvp < ActiveRecord::Base
	validates_presence_of :name, :party_size, :contact
	validates_numericality_of :party_size, :greater_than => -1

end
