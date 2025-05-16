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
  sender_id = rand(1..10)
  receiver_id = (1..10).to_a.reject { |id| id == sender_id }.sample

  Chat.create!(
    sender_id: sender_id,
    receiver_id: receiver_id
  )
end

10.times do
  chat = Chat.find(rand(1..10))
  user_id = [chat.sender_id, chat.receiver_id].sample

  Message.create!(
    chat_id: chat.id,
    user_id: user_id,
    body: "This is a sample message body at #{Time.now}."
  )
end

  