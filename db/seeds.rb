
require 'faker'
City.destroy_all
Person.destroy_all
Employer.destroy_all
Position.destroy_all

50.times do 
    person = Person.create({
        name: Faker::Name.name,
    })

    city = City.create({
        name: Faker::Address.city,
        country: Faker::Address.country,
        region: Faker::Address.state
    })

    employer = Employer.create({
        name: Faker::Company.name,
        industry: Faker::Company.industry,
        size: Faker::Company.type,
        description: Faker::Company.catch_phrase,
        products: Faker::Company.bs
    })
end



100.times do
    start_date = Time.at(946707000.to_f + rand * (Time.now.to_f - 946707000.to_f))
    finish_date = Time.at(start_date.to_f + rand * (Time.now.to_f - start_date.to_f))
    position = Position.create({
        title: Faker::Job.title,
        description: Faker::Job.key_skill,
        person_id: Person.all.sample.id,
        city_id: City.all.sample.id,
        employer_id: Employer.all.sample.id,
        start_date: start_date,
        finish_date: finish_date
    })
end