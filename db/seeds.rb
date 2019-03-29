require 'faker'
require 'random_user_generator'
Position.destroy_all
Event.destroy_all
City.destroy_all
Person.destroy_all
Employer.destroy_all
Position.destroy_all

people = []
500.times do 
    people << RandomUserGenerator.generate
end

people.each do |user| 
    Person.create({
        name: "#{user.name.first.titleize} #{user.name.last.titleize}",
        birthday: user.dob.date,
        avatar_url: user.picture.large
    })
end

stored_name = nil
CSV.foreach("./lib/b_corp_impact_data_modified.csv", :encoding => 'windows-1251:utf-8') do |row|
    if stored_name != nil 
        if stored_name != row[0].to_s && row[9].to_s.exclude?(',') && row[9].to_s.exclude?('?') && row[9].to_s.exclude?('(') && row[9].to_s.exclude?('1') && !row[9].to_s.blank?
            new_city = City.find_or_create_by(name: row[9].to_s.downcase.titleize)
            new_city.country = row[7].to_s.blank? ? "-" : row[7].to_s.downcase.titleize
            new_city.region = row[8].to_s.blank? ? "-" : row[8].to_s.downcase.titleize

            new_company = Employer.new(name: row[0].to_s)
            new_company.industry = row[4].to_s.blank? ? "-" : row[4].to_s
            new_company.description = row[3].to_s.blank? ? "-" : row[3].to_s
            new_company.products = row[6].to_s.blank? ? "-" : row[6].to_s
            new_company.size = row[11].to_s.blank? ? "-" : row[11].to_s
            new_company.website_url = row[13].to_s.blank? ? "-" : (row[13].to_s.include?("http") ? row[13].to_s : row[13].to_s.prepend("http://"))

            new_city.save
            new_company.save

            chosen_person = Person.all.sample
            if chosen_person.positions == []
                start_date = Faker::Date.between(20.years.ago, Date.today)
            else
                start_date = chosen_person.positions.last.finish_date
            end
            new_position = Position.create(
                employer_id: new_company.id,
                city_id: new_city.id,
                person_id: chosen_person.id,
                title: Faker::Job.title,
                description: Faker::Job.key_skill,
                start_date: start_date,
                finish_date: Faker::Date.between(start_date, 1.year.from_now)
            )            
        end
    end
    stored_name = row[0] 
end

500.times do
    start_date = Faker::Date.between(20.years.ago, Date.today)
    Event.create({
        title: Faker::Hipster.words(3).join(" "),
        description: Faker::Hipster.sentence,
        start_date: start_date,
        finish_date: Faker::Date.between(start_date, start_date+30),
        visitor_id: Person.all.sample.id,
        destination_id: City.all.sample.id
    })
end

Person.all.each do |p|
    if p.positions == []
        start_date = Faker::Date.between(20.years.ago, Date.today)
    else
        start_date = p.positions.last.finish_date
    end
    Position.create(
        employer_id: Employer.all.sample.id,
        city_id: City.all.sample.id,
        person_id: p.id,
        title: Faker::Job.title,
        description: Faker::Job.key_skill,
        start_date: start_date,
        finish_date: Faker::Date.between(start_date, 1.year.from_now)
    )
end        