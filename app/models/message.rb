class Message < ApplicationRecord
    belongs_to :chat
    belongs_to :user

    validates :body, presence: true

    validate :author_must_be_part_of_chat

  private

  def author_must_be_part_of_chat
    return if chat.nil? || user.nil?

    unless [chat.sender_id, chat.receiver_id].include?(user_id)
      errors.add(:user_id, "must be either the sender or the receiver of the chat")
    end
  end
end
