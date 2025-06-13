class Chat < ApplicationRecord
    scope :involving, ->(user_id) {
      where("sender_id = :id OR receiver_id = :id", id: user_id)
    }
    belongs_to :sender, class_name: 'User'
    belongs_to :receiver, class_name: 'User'
    has_many :messages, dependent: :destroy

    validates :sender_id, presence: true
    validates :receiver_id, presence: true
    validate :sender_and_receiver_must_be_different

  private

  def sender_and_receiver_must_be_different
    errors.add(:receiver_id, "must be different from sender") if sender_id == receiver_id
  end
end
