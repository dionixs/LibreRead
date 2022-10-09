# frozen_string_literal: true

# Set gravatar hash
# User.find_each do |u|
#   u.send(:set_gravatar_hash)
#   u.save
# end

# Create users
# password = 'P@ssw0rd$1'
#
# 10.times do
#   User.create email: Faker::Internet.email,
#               name: Faker::Name.name,
#               password:,
#               password_confirmation: password
# end

# Create import
# Import.create(
#   filename: 'My Clippings.txt',
#   mime_type: 'text/plain',
#   data: Faker::Hipster.paragraph,
#   user_id: User.first.id
# )

# Create notes
# 30.times do
#   Note.create(
#     title: Faker::Book.title,
#     author: Faker::Book.author,
#     place: rand(1..10000),
#     created_kindle_at: Time.now,
#     clipping: Faker::Hipster.paragraph,
#     user_id: User.first.id,
#     import_id: Import.last.id
#   )
# end

# Create tags
# 5.times do
#   title = Faker::Hipster.word
#   Tag.create(
#     title:,
#     user_id: User.first.id
#   )
# end
