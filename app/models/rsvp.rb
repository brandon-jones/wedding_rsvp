class Rsvp < ActiveRecord::Base
	validates_presence_of :name, :attending, :party_size
	validates_numericality_of :party_size, :greater_than => 0
end
