require 'faker'

if Rails.env.development?
  Profile.destroy_all
  User.destroy_all
  Flat.destroy_all

  admin = User.new(
    email: 'antoine@doum.it',
    password: 'kikoolol',
    admin: true )
  admin.skip_confirmation!
  admin.save!
  admin.confirm
end

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
  flat.save

  4.times do
    flat_picture = flat.flat_pictures.build
    flat_picture.update_attributes(remote_image_url: 'http://unsplash.it/800?random')
    flat_picture.save
  end

  puts "Flat created : #{flat.title}"
end
