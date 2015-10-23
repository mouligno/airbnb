require 'faker'

10.times do
  user = User.new(
    email: Faker::Internet.email,
    password: 'kikoolol'
  )
  user.skip_confirmation!
  user.save!
  user.confirm
  user.profile.update(
    first_name:   Faker::Name.first_name,
    last_name:    Faker::Name.last_name,
    description:  Faker::Lorem.sentence
  )

  user.profile.update_attributes(remote_profile_picture_url: 'http://unsplash.it/300/300?random')

  puts "User created : #{user.profile.first_name} #{user.profile.last_name}"
end


25.times do
  owner = User.all.sample(1).first
  flat = owner.flats.build(
    title:            Faker::Book.title,
    address_line_1:   Faker::Address.street_address,
    zip_code:         Faker::Address.zip_code,
    city:             Faker::Address.city,
    country:          Faker::Address.country,
    rooms_number:     rand(1..10),
    bed_number:       rand(1..10),
    bathroom_number:  rand(1..10),
    people_number:    rand(1..20),
    kind:             [:shared_room, :private_room, :all_flat].sample(1).first,
    price:            rand(20..2000),
    latitude:         Faker::Address.latitude,
    longitude:        Faker::Address.longitude
  )

  if Rails.env.development?
    @flat_id = 13
  else
    @flat_id = [10, 8, 9, 7, 6].sample(1).first
  end

  flat.update_attributes(flat_pictures: Flat.find(@flat_id).flat_pictures)

  puts "Flat created : #{flat.title}"
end
