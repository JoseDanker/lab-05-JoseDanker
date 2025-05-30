class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    # A user can send many chats
    has_many :sent_chats, class_name: 'Chat', foreign_key: 'sender_id', dependent: :destroy

    # A user can receive many chats
    has_many :received_chats, class_name: 'Chat', foreign_key: 'receiver_id', dependent: :destroy

    # A user can send many messages
    has_many :messages, dependent: :destroy

    # A user can receive messages through chats (optional way to access received messages)
    has_many :received_messages, through: :received_chats, source: :messages

    validates :email, presence: true, uniqueness: true

    def all_chats
        Chat.where("sender_id = ? OR receiver_id = ?", self.id, self.id)
    end
end
