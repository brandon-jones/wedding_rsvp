namespace :db do
  desc "fix case on all usernames and contacts"
  task :downcase_names_and_email => :environment do
  	Rsvp.all.each do |rsvp|
  		puts "converting #{rsvp.name} to #{rsvp.name.split(' ').map {|w| w.capitalize }.join(' ')}"
  		puts "and #{rsvp.contact} to #{rsvp.contact.capitalize}"
  		rsvp.name = rsvp.name.split(' ').map {|w| w.capitalize }.join(' ')
  		rsvp.contact = rsvp.contact.capitalize
  		rsvp.save
  	end
  end
end