# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.delete_all
Chat.delete_all
Message.delete_all

ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('chats')
ActiveRecord::Base.connection.reset_pk_sequence!('messages')



10.times do |i|
  User.create!(
    email: "user#{i}@gmail.com",
    first_name: "First#{i}",
    last_name: "Last#{i}"
  )
end

10.times do
  Chat.create!(
    sender_id: rand(1..10),
    receiver_id: rand(1..10)
  )
end

10.times do
  Message.create!(
    chat_id: rand(1..10),
    user_id: rand(1..10),
    body: "This is a sample message body at #{Time.now}."
  )
end

  