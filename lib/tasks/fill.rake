namespace :fill do

  desc "Tire reindex profiles"

  task :guestbook => :environment do
    for i in 0..19
    	puts i
    	Guestbook.create(name: Faker::Name.name, message: Faker::Lorem.paragraph(2, true, 10), flag: [true, false, nil, false, nil, false, nil].sample)
    end
  end

  task :blog => :environment do
    for i in 0..20
    	puts i
    	Blog.create(title: Faker::Lorem.sentence(4,true,6), body: Faker::Lorem.paragraph(4,true,10))
    end
  end

  task :rsvp => :environment do
    for i in 0..100
      puts i
      Rsvp.create(name: Faker::Name.name, contact: [Faker::Internet.email,Faker::PhoneNumber.phone_number].sample, attending: [true,false].sample, party_size: rand(1..9))
    end
  end
end