require 'faker'

80.times do
  first_name = Faker::Name.first_name.downcase
  last_name = Faker::Name.last_name.downcase
  random_number = rand(1..200)
  email = "#{last_name}.#{random_number}@osu.edu"
  password = Faker::Internet.password(min_length: 8, max_length: 20)
  phone = Faker::PhoneNumber.phone_number

  # Create the user
  user = User.create!(
    name: "#{first_name} #{last_name}",
    email: email,
    phone: phone,
    password: password
  )
  puts "Created user: #{first_name} #{last_name} (#{email})"

  # Create posts for each user
  5.times do
    Post.create!(
      title: Faker::Lorem.sentence,
      topic: Faker::Lorem.paragraph,
      user: user # Assign the post to the created user
    )
    puts "Created post for user: #{user.name}"
  end
end