namespace :fill do

  desc "Tire reindex profiles"

  task :guestbook => :environment do
    for i in 0..100
    	puts i
    	Guestbook.create(name: Faker::Name.name, message: Faker::Lorem.paragraph, flag: [true, false, nil, false, nil, false, nil].sample)
    end
  end

end