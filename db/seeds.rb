# frozen_string_literal: true

# Set gravatar hash
# User.find_each do |u|
#   u.send(:set_gravatar_hash)
#   u.save
# end

# Password
password = 'P@ssw0rd$1'

# Create admin
User.create(
  email: 'admin@mail.com',
  name: Faker::Name.name,
  role: 'admin',
  password:,
  password_confirmation: password
)

# Create users
10.times do
  User.create email: Faker::Internet.email,
              name: Faker::Name.name,
              password:,
              password_confirmation: password
end

# Create import
Import.create(
  filename: 'My Clippings.txt',
  mime_type: 'text/plain',
  data: Faker::Hipster.paragraph,
  user_id: User.first.id
)

# Create notes
30.times do
  Note.create(
    title: Faker::Book.title,
    author: Faker::Book.author,
    place: rand(1..10_000),
    created_kindle_at: Time.current,
    clipping: Faker::Hipster.paragraph,
    user_id: User.first.id,
    import_id: Import.last.id
  )
end
