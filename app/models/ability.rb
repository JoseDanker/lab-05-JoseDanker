

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    if user.admin?
      can :manage, :all  # 🔓 acceso total
    else
      can :read, User
      can :manage_profile, User, id: user.id

      can :create, Chat

      can :read, Chat do |chat|
        chat.sender_id == user.id || chat.receiver_id == user.id
      end
      can :create, Message
      # Puede ver/editar/borrar sus propios mensajes
      can [:read, :update, :destroy], Message, user_id: user.id
      can :read, Message do |message|
        chat = message.chat
        chat.sender_id == user.id || chat.receiver_id == user.id
      end
    end
  end
end

