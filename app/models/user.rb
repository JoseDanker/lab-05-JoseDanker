class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Asociaciones
  has_many :messages, dependent: :destroy
  has_many :chats_as_sender, class_name: "Chat", foreign_key: "sender_id"
  has_many :chats_as_receiver, class_name: "Chat", foreign_key: "receiver_id"

  def all_chats
    Chat.where("sender_id = ? OR receiver_id = ?", id, id)
  end
end
